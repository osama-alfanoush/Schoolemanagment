import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A request as the adapter saw it, captured for assertions.
class RecordedRequest {
  RecordedRequest(RequestOptions options)
      : method = options.method.toUpperCase(),
        path = options.path,
        headers = Map<String, dynamic>.from(options.headers),
        body = options.data;

  final String method;
  final String path;
  final Map<String, dynamic> headers;

  /// The body as the client handed it to the adapter, before encoding.
  ///
  /// Captured so a test can assert a field is *present* — `device_id` is the
  /// one that matters, because a session established without it can never be
  /// revoked remotely.
  final Object? body;

  /// The body as a map, or an empty map when it is not one.
  Map<String, Object?> get json => body is Map
      ? (body! as Map).map((key, value) => MapEntry('$key', value))
      : const <String, Object?>{};

  String? get authorization => header('Authorization');

  /// Case-insensitive header lookup: Dio and dart:io disagree on casing.
  String? header(String name) {
    final wanted = name.toLowerCase();
    for (final entry in headers.entries) {
      if (entry.key.toLowerCase() == wanted) return entry.value?.toString();
    }
    return null;
  }

  bool hasHeader(String name) => header(name) != null;
}

/// Canned reply for a mocked call.
class MockReply {
  const MockReply({
    this.statusCode = 200,
    this.body = const <String, dynamic>{},
    this.headers = const <String, List<String>>{},
    this.delay = Duration.zero,
  });

  final int statusCode;
  final Object? body;
  final Map<String, List<String>> headers;

  /// Widens the window in which concurrent callers overlap.
  final Duration delay;
}

/// Signature of a handler that answers a mocked call, or throws a
/// [DioException] to simulate a transport failure.
typedef MockResponder = FutureOr<MockReply> Function(RequestOptions options);

/// An [HttpClientAdapter] that never opens a socket.
///
/// Every test in this suite installs one of these; nothing here can reach a
/// real host.
class MockHttpAdapter implements HttpClientAdapter {
  MockHttpAdapter(this._responder);

  final MockResponder _responder;

  /// Every request the client attempted, in order.
  final List<RecordedRequest> requests = <RecordedRequest>[];

  /// Requests recorded for [path].
  List<RecordedRequest> requestsFor(String path) =>
      requests.where((request) => request.path == path).toList(growable: false);

  int countFor(String path) => requestsFor(path).length;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(RecordedRequest(options));

    final reply = await _responder(options);
    if (reply.delay > Duration.zero) {
      await Future<void>.delayed(reply.delay);
    }

    return ResponseBody.fromString(
      reply.body == null ? '' : jsonEncode(reply.body),
      reply.statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        ...reply.headers,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Builds the [DioException] Dio raises when the device has no connectivity.
DioException connectionLost(RequestOptions options) => DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
      error: const SocketExceptionStub(),
    );

/// Stand-in for `dart:io`'s SocketException, so the test does not depend on
/// platform socket internals.
class SocketExceptionStub implements Exception {
  const SocketExceptionStub();

  @override
  String toString() => 'SocketException: Network is unreachable';
}
