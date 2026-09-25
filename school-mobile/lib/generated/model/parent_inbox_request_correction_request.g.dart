// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_request_correction_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxRequestCorrectionRequest
    extends ParentInboxRequestCorrectionRequest {
  @override
  final String field;
  @override
  final String detail;
  @override
  final String idempotencyKey;

  factory _$ParentInboxRequestCorrectionRequest([
    void Function(ParentInboxRequestCorrectionRequestBuilder)? updates,
  ]) =>
      (ParentInboxRequestCorrectionRequestBuilder()..update(updates))._build();

  _$ParentInboxRequestCorrectionRequest._({
    required this.field,
    required this.detail,
    required this.idempotencyKey,
  }) : super._();
  @override
  ParentInboxRequestCorrectionRequest rebuild(
    void Function(ParentInboxRequestCorrectionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxRequestCorrectionRequestBuilder toBuilder() =>
      ParentInboxRequestCorrectionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxRequestCorrectionRequest &&
        field == other.field &&
        detail == other.detail &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInboxRequestCorrectionRequest')
          ..add('field', field)
          ..add('detail', detail)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class ParentInboxRequestCorrectionRequestBuilder
    implements
        Builder<
          ParentInboxRequestCorrectionRequest,
          ParentInboxRequestCorrectionRequestBuilder
        > {
  _$ParentInboxRequestCorrectionRequest? _$v;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  ParentInboxRequestCorrectionRequestBuilder() {
    ParentInboxRequestCorrectionRequest._defaults(this);
  }

  ParentInboxRequestCorrectionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _field = $v.field;
      _detail = $v.detail;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxRequestCorrectionRequest other) {
    _$v = other as _$ParentInboxRequestCorrectionRequest;
  }

  @override
  void update(
    void Function(ParentInboxRequestCorrectionRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxRequestCorrectionRequest build() => _build();

  _$ParentInboxRequestCorrectionRequest _build() {
    final _$result =
        _$v ??
        _$ParentInboxRequestCorrectionRequest._(
          field: BuiltValueNullFieldError.checkNotNull(
            field,
            r'ParentInboxRequestCorrectionRequest',
            'field',
          ),
          detail: BuiltValueNullFieldError.checkNotNull(
            detail,
            r'ParentInboxRequestCorrectionRequest',
            'detail',
          ),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'ParentInboxRequestCorrectionRequest',
            'idempotencyKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
