// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_due200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InstallmentDue200Response extends InstallmentDue200Response {
  @override
  final BuiltList<Installment> data;

  factory _$InstallmentDue200Response([
    void Function(InstallmentDue200ResponseBuilder)? updates,
  ]) => (InstallmentDue200ResponseBuilder()..update(updates))._build();

  _$InstallmentDue200Response._({required this.data}) : super._();
  @override
  InstallmentDue200Response rebuild(
    void Function(InstallmentDue200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InstallmentDue200ResponseBuilder toBuilder() =>
      InstallmentDue200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstallmentDue200Response && data == other.data;
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
      r'InstallmentDue200Response',
    )..add('data', data)).toString();
  }
}

class InstallmentDue200ResponseBuilder
    implements
        Builder<InstallmentDue200Response, InstallmentDue200ResponseBuilder> {
  _$InstallmentDue200Response? _$v;

  ListBuilder<Installment>? _data;
  ListBuilder<Installment> get data =>
      _$this._data ??= ListBuilder<Installment>();
  set data(ListBuilder<Installment>? data) => _$this._data = data;

  InstallmentDue200ResponseBuilder() {
    InstallmentDue200Response._defaults(this);
  }

  InstallmentDue200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InstallmentDue200Response other) {
    _$v = other as _$InstallmentDue200Response;
  }

  @override
  void update(void Function(InstallmentDue200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InstallmentDue200Response build() => _build();

  _$InstallmentDue200Response _build() {
    _$InstallmentDue200Response _$result;
    try {
      _$result = _$v ?? _$InstallmentDue200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'InstallmentDue200Response',
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
