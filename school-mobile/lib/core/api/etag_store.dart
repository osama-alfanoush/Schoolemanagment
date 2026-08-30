import 'package:dio/dio.dart';

/// Cache of `ETag` values keyed by request.
///
/// In-memory only: persisting validators across launches is a later work order.
abstract class EtagStore {
  String? read(String key);

  void write(String key, String etag);

  void clear();
}

/// Default [EtagStore]; entries live only as long as the client.
class InMemoryEtagStore implements EtagStore {
  final Map<String, String> _etags = <String, String>{};

  @override
  String? read(String key) => _etags[key];

  @override
  void write(String key, String etag) => _etags[key] = etag;

  @override
  void clear() => _etags.clear();
}

/// Cache key for a request. Method and full URI, so a query change is a
/// different entry.
String etagKeyFor(RequestOptions options) =>
    '${options.method.toUpperCase()} ${options.uri}';
