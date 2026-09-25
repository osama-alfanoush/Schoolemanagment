// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_send_bulk_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationSendBulkRequest extends NotificationSendBulkRequest {
  @override
  final String templateKey;
  @override
  final BuiltList<String>? templateData;
  @override
  final NotificationSendBulkRequestTarget target;

  factory _$NotificationSendBulkRequest([
    void Function(NotificationSendBulkRequestBuilder)? updates,
  ]) => (NotificationSendBulkRequestBuilder()..update(updates))._build();

  _$NotificationSendBulkRequest._({
    required this.templateKey,
    this.templateData,
    required this.target,
  }) : super._();
  @override
  NotificationSendBulkRequest rebuild(
    void Function(NotificationSendBulkRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationSendBulkRequestBuilder toBuilder() =>
      NotificationSendBulkRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationSendBulkRequest &&
        templateKey == other.templateKey &&
        templateData == other.templateData &&
        target == other.target;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, templateKey.hashCode);
    _$hash = $jc(_$hash, templateData.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationSendBulkRequest')
          ..add('templateKey', templateKey)
          ..add('templateData', templateData)
          ..add('target', target))
        .toString();
  }
}

class NotificationSendBulkRequestBuilder
    implements
        Builder<
          NotificationSendBulkRequest,
          NotificationSendBulkRequestBuilder
        > {
  _$NotificationSendBulkRequest? _$v;

  String? _templateKey;
  String? get templateKey => _$this._templateKey;
  set templateKey(String? templateKey) => _$this._templateKey = templateKey;

  ListBuilder<String>? _templateData;
  ListBuilder<String> get templateData =>
      _$this._templateData ??= ListBuilder<String>();
  set templateData(ListBuilder<String>? templateData) =>
      _$this._templateData = templateData;

  NotificationSendBulkRequestTargetBuilder? _target;
  NotificationSendBulkRequestTargetBuilder get target =>
      _$this._target ??= NotificationSendBulkRequestTargetBuilder();
  set target(NotificationSendBulkRequestTargetBuilder? target) =>
      _$this._target = target;

  NotificationSendBulkRequestBuilder() {
    NotificationSendBulkRequest._defaults(this);
  }

  NotificationSendBulkRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _templateKey = $v.templateKey;
      _templateData = $v.templateData?.toBuilder();
      _target = $v.target.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationSendBulkRequest other) {
    _$v = other as _$NotificationSendBulkRequest;
  }

  @override
  void update(void Function(NotificationSendBulkRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationSendBulkRequest build() => _build();

  _$NotificationSendBulkRequest _build() {
    _$NotificationSendBulkRequest _$result;
    try {
      _$result =
          _$v ??
          _$NotificationSendBulkRequest._(
            templateKey: BuiltValueNullFieldError.checkNotNull(
              templateKey,
              r'NotificationSendBulkRequest',
              'templateKey',
            ),
            templateData: _templateData?.build(),
            target: target.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'templateData';
        _templateData?.build();
        _$failedField = 'target';
        target.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationSendBulkRequest',
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
