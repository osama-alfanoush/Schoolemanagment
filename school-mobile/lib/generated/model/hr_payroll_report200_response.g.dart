// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_report200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollReport200Response extends HrPayrollReport200Response {
  @override
  final AnyOf anyOf;

  factory _$HrPayrollReport200Response([
    void Function(HrPayrollReport200ResponseBuilder)? updates,
  ]) => (HrPayrollReport200ResponseBuilder()..update(updates))._build();

  _$HrPayrollReport200Response._({required this.anyOf}) : super._();
  @override
  HrPayrollReport200Response rebuild(
    void Function(HrPayrollReport200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollReport200ResponseBuilder toBuilder() =>
      HrPayrollReport200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollReport200Response && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrPayrollReport200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrPayrollReport200ResponseBuilder
    implements
        Builder<HrPayrollReport200Response, HrPayrollReport200ResponseBuilder> {
  _$HrPayrollReport200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrPayrollReport200ResponseBuilder() {
    HrPayrollReport200Response._defaults(this);
  }

  HrPayrollReport200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollReport200Response other) {
    _$v = other as _$HrPayrollReport200Response;
  }

  @override
  void update(void Function(HrPayrollReport200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollReport200Response build() => _build();

  _$HrPayrollReport200Response _build() {
    final _$result =
        _$v ??
        _$HrPayrollReport200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrPayrollReport200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
