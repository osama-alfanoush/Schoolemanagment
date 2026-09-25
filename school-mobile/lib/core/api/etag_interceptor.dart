import 'dart:io';

import 'package:dio/dio.dart';

import 'etag_store.dart';

/// Conditional-GET support.
///
/// Sends `If-None-Match` when an `ETag` is already known for a GET, and records
/// the `ETag` of every successful GET response.
///
/// A 304 is delivered to the caller as a normal response (see
/// [NotModifiedResponse.isNotModified]) rather than an error, so callers can
/// fall back to their cached copy.
class EtagInterceptor extends Interceptor {
  EtagInterceptor({required this.store});

  final EtagStore store;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method.toUpperCase() == 'GET') {
      final etag = store.read(etagKeyFor(options));
      if (etag != null && etag.isNotEmpty) {
        options.headers[HttpHeaders.ifNoneMatchHeader] = etag;
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;
    if (options.method.toUpperCase() == 'GET' &&
        response.statusCode == HttpStatus.ok) {
      final etag = response.headers.value(HttpHeaders.etagHeader);
      if (etag != null && etag.isNotEmpty) {
        store.write(etagKeyFor(options), etag);
      }
    }
    handler.next(response);
  }
}

/// Lets callers tell a validated cache hit from a fresh body.
extension NotModifiedResponse on Response<dynamic> {
  /// True when the server answered 304 and the caller should use its cached
  /// copy — the body is empty by definition.
  bool get isNotModified => statusCode == HttpStatus.notModified;
}
