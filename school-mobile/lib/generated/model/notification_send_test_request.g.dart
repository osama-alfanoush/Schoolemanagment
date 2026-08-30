// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_test_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationSendTestRequest extends NotificationSendTestRequest {
  @override
  final int userId;
  @override
  final String templateKey;
  @override
  final BuiltList<String>? templateData;

  factory _$NotificationSendTestRequest([
    void Function(NotificationSendTestRequestBuilder)? updates,
  ]) => (NotificationSendTestRequestBuilder()..update(updates))._build();

  _$NotificationSendTestRequest._({
    required this.userId,
    required this.templateKey,
    this.templateData,
  }) : super._();
  @override
  NotificationSendTestRequest rebuild(
    void Function(NotificationSendTestRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendTestRequestBuilder toBuilder() =>
      NotificationSendTestRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendTestRequest &&
        userId == other.userId &&
        templateKey == other.templateKey &&
        templateData == other.templateData;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, templateKey.hashCode);
    _$hash = $jc(_$hash, templateData.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationSendTestRequest')
          ..add('userId', userId)
          ..add('templateKey', templateKey)
          ..add('templateData', templateData))
        .toString();
  }
}

class NotificationSendTestRequestBuilder
    implements
        Builder<
          NotificationSendTestRequest,
          NotificationSendTestRequestBuilder
        > {
  _$NotificationSendTestRequest? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _templateKey;
  String? get templateKey => _$this._templateKey;
  set templateKey(String? templateKey) => _$this._templateKey = templateKey;

  ListBuilder<String>? _templateData;
  ListBuilder<String> get templateData =>
      _$this._templateData ??= ListBuilder<String>();
  set templateData(ListBuilder<String>? templateData) =>
      _$this._templateData = templateData;

  NotificationSendTestRequestBuilder() {
    NotificationSendTestRequest._defaults(this);
  }

  NotificationSendTestRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _templateKey = $v.templateKey;
      _templateData = $v.templateData?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendTestRequest other) {
    _$v = other as _$NotificationSendTestRequest;
  }

  @override
  void update(void Function(NotificationSendTestRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendTestRequest build() => _build();

  _$NotificationSendTestRequest _build() {
    _$NotificationSendTestRequest _$result;
    try {
      _$result =
          _$v ??
          _$NotificationSendTestRequest._(
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'NotificationSendTestRequest',
              'userId',
            ),
            templateKey: BuiltValueNullFieldError.checkNotNull(
              templateKey,
              r'NotificationSendTestRequest',
              'templateKey',
            ),
            templateData: _templateData?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'templateData';
        _templateData?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationSendTestRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
