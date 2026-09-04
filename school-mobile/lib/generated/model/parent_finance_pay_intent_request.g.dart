// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_pay_intent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinancePayIntentRequest extends ParentFinancePayIntentRequest {
  @override
  final String idempotencyKey;

  factory _$ParentFinancePayIntentRequest([
    void Function(ParentFinancePayIntentRequestBuilder)? updates,
  ]) => (ParentFinancePayIntentRequestBuilder()..update(updates))._build();

  _$ParentFinancePayIntentRequest._({required this.idempotencyKey}) : super._();
  @override
  ParentFinancePayIntentRequest rebuild(
    void Function(ParentFinancePayIntentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinancePayIntentRequestBuilder toBuilder() =>
      ParentFinancePayIntentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinancePayIntentRequest &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentFinancePayIntentRequest',
    )..add('idempotencyKey', idempotencyKey)).toString();
  }
}

class ParentFinancePayIntentRequestBuilder
    implements
        Builder<
          ParentFinancePayIntentRequest,
          ParentFinancePayIntentRequestBuilder
        > {
  _$ParentFinancePayIntentRequest? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  ParentFinancePayIntentRequestBuilder() {
    ParentFinancePayIntentRequest._defaults(this);
  }

  ParentFinancePayIntentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinancePayIntentRequest other) {
    _$v = other as _$ParentFinancePayIntentRequest;
  }

  @override
  void update(void Function(ParentFinancePayIntentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinancePayIntentRequest build() => _build();

  _$ParentFinancePayIntentRequest _build() {
    final _$result =
        _$v ??
        _$ParentFinancePayIntentRequest._(
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'ParentFinancePayIntentRequest',
            'idempotencyKey',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
