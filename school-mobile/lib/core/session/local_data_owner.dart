import '../db/app_database.dart';
import '../db/tables.dart';

/// What claiming the device for a user did to what was already on it.
class LocalDataClaim {
  const LocalDataClaim({
    required this.wasSameUser,
    required this.discardedRows,
    required this.discardedUnsentWrites,
  });

  /// True when the device already belonged to this user, so nothing was
  /// touched. The ordinary case: one family, one phone.
  final bool wasSameUser;

  /// Cached reads dropped. Disposable by definition — everything cached can be
  /// fetched again.
  final int discardedRows;

  /// Queued writes dropped. **Not** disposable: these are things someone
  /// believed they had saved. Reported rather than swallowed so the app can
  /// say what was lost and to whom it belonged.
  final int discardedUnsentWrites;

  bool get discardedAnything => discardedRows > 0 || discardedUnsentWrites > 0;
}

/// Which user the local database belongs to.
///
/// A school phone or a shared family tablet gets signed into by more than one
/// person. Every cached payload on this device — a child's marks, a family's
/// invoices, a class roster — belongs to whoever fetched it, and none of it may
/// survive into the next person's session.
///
/// The owner is recorded in the local database itself rather than in secure
/// storage, deliberately: it has to be dropped by exactly the same act that
/// drops the data it describes, and a record that can outlive its data is a
/// record that eventually lies about it.
class LocalDataOwner {
  LocalDataOwner({required this.database});

  final AppDatabase database;

  static const String _entity = 'session_owner';
  static const String _id = 'current';

  /// The user this device's local data belongs to, or null when unclaimed.
  Future<int?> current() async {
    final row = await database.readCache(_entity, _id);
    if (row == null) return null;

    return int.tryParse(row.payloadJson);
  }

  /// Claims the device for [userId], clearing another user's data first.
  ///
  /// Called after a sign-in and after a cold-start restore, because those are
  /// the only two moments the app knows both who owns the data and who is
  /// about to read it.
  Future<LocalDataClaim> claim(int userId) async {
    final owner = await current();

    if (owner == userId) {
      return const LocalDataClaim(
        wasSameUser: true,
        discardedRows: 0,
        discardedUnsentWrites: 0,
      );
    }

    final unsent = await unsentWrites();
    final rows = await database.clearLocalData();

    await database.upsertCache(
      entityType: _entity,
      entityId: _id,
      payloadJson: '$userId',
    );

    return LocalDataClaim(
      wasSameUser: false,
      discardedRows: rows,
      discardedUnsentWrites: unsent,
    );
  }

  /// Writes still owed to the server.
  ///
  /// Succeeded and dead rows do not count: one is finished and the other is
  /// already reported to the user as rejected.
  Future<int> unsentWrites() async {
    final rows = await database.allOutbox();

    return rows
        .where((entry) =>
            entry.status != OutboxStatus.succeeded &&
            entry.status != OutboxStatus.dead)
        .length;
  }

  /// Forgets the claim without touching the data.
  ///
  /// Used when the *same* user signs out: their cache is still theirs, and
  /// re-signing in on the same device should not cost them a cold start.
  Future<void> release() => database.deleteCache(_entity, _id);
}
