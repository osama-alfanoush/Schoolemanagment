// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_payment_history200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentPaymentHistory200Response
    extends ParentPaymentHistory200Response {
  @override
  final BuiltList<Payment> data;

  factory _$ParentPaymentHistory200Response([
    void Function(ParentPaymentHistory200ResponseBuilder)? updates,
  ]) => (ParentPaymentHistory200ResponseBuilder()..update(updates))._build();

  _$ParentPaymentHistory200Response._({required this.data}) : super._();
  @override
  ParentPaymentHistory200Response rebuild(
    void Function(ParentPaymentHistory200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentPaymentHistory200ResponseBuilder toBuilder() =>
      ParentPaymentHistory200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentPaymentHistory200Response && data == other.data;
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
      r'ParentPaymentHistory200Response',
    )..add('data', data)).toString();
  }
}

class ParentPaymentHistory200ResponseBuilder
    implements
        Builder<
          ParentPaymentHistory200Response,
          ParentPaymentHistory200ResponseBuilder
        > {
  _$ParentPaymentHistory200Response? _$v;

  ListBuilder<Payment>? _data;
  ListBuilder<Payment> get data => _$this._data ??= ListBuilder<Payment>();
  set data(ListBuilder<Payment>? data) => _$this._data = data;

  ParentPaymentHistory200ResponseBuilder() {
    ParentPaymentHistory200Response._defaults(this);
  }

  ParentPaymentHistory200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentPaymentHistory200Response other) {
    _$v = other as _$ParentPaymentHistory200Response;
  }

  @override
  void update(void Function(ParentPaymentHistory200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentPaymentHistory200Response build() => _build();

  _$ParentPaymentHistory200Response _build() {
    _$ParentPaymentHistory200Response _$result;
    try {
      _$result = _$v ?? _$ParentPaymentHistory200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentPaymentHistory200Response',
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
