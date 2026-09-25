// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_audit_trail200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingAuditTrail200Response
    extends AccountingAuditTrail200Response {
  @override
  final AccountingAuditTrail200ResponseData data;

  factory _$AccountingAuditTrail200Response([
    void Function(AccountingAuditTrail200ResponseBuilder)? updates,
  ]) => (AccountingAuditTrail200ResponseBuilder()..update(updates))._build();

  _$AccountingAuditTrail200Response._({required this.data}) : super._();
  @override
  AccountingAuditTrail200Response rebuild(
    void Function(AccountingAuditTrail200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingAuditTrail200ResponseBuilder toBuilder() =>
      AccountingAuditTrail200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingAuditTrail200Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AccountingAuditTrail200Response',
    )..add('data', data)).toString();
  }
}

class AccountingAuditTrail200ResponseBuilder
    implements
        Builder<
          AccountingAuditTrail200Response,
          AccountingAuditTrail200ResponseBuilder
        > {
  _$AccountingAuditTrail200Response? _$v;

  AccountingAuditTrail200ResponseDataBuilder? _data;
  AccountingAuditTrail200ResponseDataBuilder get data =>
      _$this._data ??= AccountingAuditTrail200ResponseDataBuilder();
  set data(AccountingAuditTrail200ResponseDataBuilder? data) =>
      _$this._data = data;

  AccountingAuditTrail200ResponseBuilder() {
    AccountingAuditTrail200Response._defaults(this);
  }

  AccountingAuditTrail200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingAuditTrail200Response other) {
    _$v = other as _$AccountingAuditTrail200Response;
  }

  @override
  void update(void Function(AccountingAuditTrail200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountingAuditTrail200Response build() => _build();

  _$AccountingAuditTrail200Response _build() {
    _$AccountingAuditTrail200Response _$result;
    try {
      _$result = _$v ?? _$AccountingAuditTrail200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingAuditTrail200Response',
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
