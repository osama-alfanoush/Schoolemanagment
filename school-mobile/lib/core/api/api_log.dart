import 'package:dio/dio.dart';

import 'token_refresh_coordinator.dart';

/// Destination for the layer's log lines.
typedef ApiLogSink = void Function(String message);

/// Logs the shape of a call and nothing else.
///
/// Deliberately records only method, path, status and correlation id. Headers
/// (which carry the bearer token), query strings and request/response bodies
/// (which carry passwords and personal data) are never written anywhere.
class ApiLogInterceptor extends Interceptor {
  const ApiLogInterceptor(this._sink);

  final ApiLogSink _sink;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _sink('--> ${options.method} ${options.uri.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _sink(
      '<-- ${response.statusCode} ${response.requestOptions.method} '
      '${response.requestOptions.uri.path}'
      '${_requestIdSuffix(requestIdOf(response))}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _sink(
      '<-- ${err.response?.statusCode ?? err.type.name} '
      '${err.requestOptions.method} ${err.requestOptions.uri.path}'
      '${_requestIdSuffix(requestIdOf(err.response))}',
    );
    handler.next(err);
  }

  String _requestIdSuffix(String? requestId) =>
      requestId == null ? '' : ' [requestId: $requestId]';
}
