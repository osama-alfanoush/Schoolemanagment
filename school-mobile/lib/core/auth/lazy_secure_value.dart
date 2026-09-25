import 'dart:async';

import 'secure_store.dart';

/// A value that is generated once, on first use, and then persisted.
///
/// Generation is single-flighted. Without that, two callers racing on first
/// use would each generate a value and the second would overwrite the first —
/// for the database key that means data encrypted under a key nobody kept.
class LazySecureValue {
  LazySecureValue({
    required this.store,
    required this.key,
    required this.generate,
  });

  final SecureStore store;
  final String key;

  /// Produces a fresh value. Called at most once per first use.
  final String Function() generate;

  Future<String>? _inFlight;

  /// How many values this instance has generated. Tests assert this is 1 even
  /// under concurrent first use.
  int get generationCount => _generationCount;
  int _generationCount = 0;

  /// The stored value, provisioning one if this is the first use.
  Future<String> get() async {
    final existing = await store.read(key);
    if (existing != null && existing.isNotEmpty) return existing;

    // No `await` between reading and assigning `_inFlight`, so on Dart's
    // single event loop this is an atomic check-and-set: concurrent callers
    // that both saw "absent" share one generation.
    return _inFlight ??= _generateAndStore().whenComplete(() {
      _inFlight = null;
    });
  }

  Future<String> _generateAndStore() async {
    final value = generate();
    _generationCount++;
    await store.write(key, value);
    return value;
  }

  /// Removes the value; the next [get] provisions a new one.
  Future<void> clear() => store.delete(key);
}
