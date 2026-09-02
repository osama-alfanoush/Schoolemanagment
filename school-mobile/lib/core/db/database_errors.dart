/// Failures this layer raises instead of recovering silently.
///
/// A teacher's unsynced attendance and grades live in this database. Deleting
/// or recreating it to get past an open failure would destroy work the user
/// believes is saved, so every failure here is surfaced and nothing is
/// repaired automatically.
///
/// None of these messages carry the encryption key, a row payload, a file path
/// or any other value that could hold personal data.
sealed class LocalDatabaseException implements Exception {
  const LocalDatabaseException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The database file could not be read with the key we hold.
///
/// Almost always a key mismatch: SQLCipher reports a wrong key as
/// `SQLITE_NOTADB` ("file is not a database"), because it cannot decrypt the
/// header. The file is left exactly as it was — recovering it needs the
/// original key, and deleting it would throw away unsynced work.
class DatabaseUnreadableException extends LocalDatabaseException {
  const DatabaseUnreadableException([
    super.message = 'The database could not be opened with the current key. '
        'It has been left untouched.',
  ]);
}

/// The SQLite build in use has no encryption support.
///
/// Worth failing on: plain SQLite silently accepts `PRAGMA key` and then
/// writes an unencrypted file, so without this check a build misconfiguration
/// would look exactly like success.
class DatabaseEncryptionUnavailableException extends LocalDatabaseException {
  const DatabaseEncryptionUnavailableException([
    super.message = 'This build has no SQLCipher support, so the database '
        'would not be encrypted. Refusing to open it.',
  ]);
}

/// A schema migration could not be applied.
class DatabaseMigrationException extends LocalDatabaseException {
  const DatabaseMigrationException(super.message);
}
