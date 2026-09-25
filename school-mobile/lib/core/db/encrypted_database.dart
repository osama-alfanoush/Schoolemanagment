import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';

import 'app_database.dart';
import 'database_errors.dart';
import 'database_key_provider.dart';

/// SQLCipher's code for "this header did not decrypt", which is what a wrong
/// key looks like from the outside.
const int _sqliteNotADatabase = 26;

/// Opens the encrypted database, or fails.
///
/// Nothing here deletes, recreates or repairs the file. A failure to open is
/// reported as a [LocalDatabaseException] and the file is left byte-for-byte
/// as it was, because it may hold the only copy of work the user has done
/// offline.
Future<AppDatabase> openEncryptedDatabase({
  required File file,
  required DatabaseKeyProvider keyProvider,
}) async {
  final key = await keyProvider.key();
  final database = AppDatabase(encryptedExecutor(file: file, key: key));

  try {
    // Force the connection open now, so a bad key surfaces here rather than
    // at some arbitrary later query.
    await database.customSelect('SELECT 1').get();
  } catch (error) {
    await database.close();
    throw _asLocalDatabaseException(error);
  }

  return database;
}

/// The drift executor for an encrypted file, with the key applied and
/// encryption verified before any schema work happens.
QueryExecutor encryptedExecutor({required File file, required Uint8List key}) {
  return NativeDatabase(
    file,
    setup: (Database raw) => applyEncryption(raw, key),
  );
}

/// Applies [key] to [raw] and refuses to continue unless the connection is
/// genuinely encrypted and readable.
///
/// Exposed for tests, which use it to open a file directly.
void applyEncryption(Database raw, Uint8List key) {
  // Raw-key form: the bytes are used as the key directly, with no KDF, which
  // is what we want for a 256-bit value straight from the CSPRNG.
  raw.execute("PRAGMA key = \"x'${_hex(key)}'\"");

  // Plain SQLite accepts `PRAGMA key` and silently ignores it, then writes an
  // unencrypted file. Without this check, a build that lost its SQLCipher
  // dependency would look identical to a working one.
  final cipher = raw.select('PRAGMA cipher_version');
  if (cipher.isEmpty || '${cipher.first.values.first}'.trim().isEmpty) {
    throw const DatabaseEncryptionUnavailableException();
  }

  // Touching the schema forces SQLCipher to decrypt page 1, which is where a
  // wrong key is detected.
  raw.execute('SELECT count(*) FROM sqlite_master');
}

/// Lowercase hex, as SQLCipher's `x'...'` literal expects.
String _hex(Uint8List bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

/// Maps a raw open failure onto this layer's typed errors.
///
/// Deliberately drops the underlying message: SQLite errors can quote file
/// paths, which carry the user's account name.
LocalDatabaseException _asLocalDatabaseException(Object error) {
  if (error is LocalDatabaseException) return error;
  if (error is SqliteException && error.resultCode == _sqliteNotADatabase) {
    return const DatabaseUnreadableException();
  }
  if (error is SqliteException) {
    return const DatabaseUnreadableException(
      'The database could not be opened. It has been left untouched.',
    );
  }
  return const DatabaseUnreadableException();
}
