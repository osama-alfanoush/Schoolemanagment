//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:school_mobile/generated/api_util.dart';
import 'package:school_mobile/generated/model/file_profile_photo403_response.dart';
import 'package:school_mobile/generated/model/inline_object.dart';
import 'package:school_mobile/generated/model/sync_delta200_response.dart';
import 'package:school_mobile/generated/model/sync_delta403_response.dart';

class SyncApi {

  final Dio _dio;

  final Serializers _serializers;

  const SyncApi(this._dio, this._serializers);

  /// Mobile delta sync
  /// Returns everything that changed for the authenticated user since &#x60;since&#x60;, plus tombstones for what was deleted, plus the cursor to resume from. Omit &#x60;since&#x60; for a first full pull.  The response is scoped entirely from the token: a parent sees only their own children&#39;s records, a teacher only their assigned classes, a student only themselves. &#x60;types&#x60; selects from what the role already allows and can only narrow that set, never widen it.
  ///
  /// Parameters:
  /// * [since] 
  /// * [types] 
  /// * [limit] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [SyncDelta200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<SyncDelta200Response>> syncDelta({ 
    String? since,
    String? types,
    int? limit,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/mobile/v1/sync/delta';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'http',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'since': encodeQueryParameter(_serializers, since, const FullType(String)),
      r'types': encodeQueryParameter(_serializers, types, const FullType(String)),
      r'limit': encodeQueryParameter(_serializers, limit, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    SyncDelta200Response? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(SyncDelta200Response),
      ) as SyncDelta200Response;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<SyncDelta200Response>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
