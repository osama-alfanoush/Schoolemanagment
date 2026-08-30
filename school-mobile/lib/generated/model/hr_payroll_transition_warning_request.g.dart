// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_transition_warning_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollTransitionWarningRequest
    extends HrPayrollTransitionWarningRequest {
  @override
  final String employeeComments;

  factory _$HrPayrollTransitionWarningRequest([
    void Function(HrPayrollTransitionWarningRequestBuilder)? updates,
  ]) => (HrPayrollTransitionWarningRequestBuilder()..update(updates))._build();

  _$HrPayrollTransitionWarningRequest._({required this.employeeComments})
    : super._();
  @override
  HrPayrollTransitionWarningRequest rebuild(
    void Function(HrPayrollTransitionWarningRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrPayrollTransitionWarningRequestBuilder toBuilder() =>
      HrPayrollTransitionWarningRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollTransitionWarningRequest &&
        employeeComments == other.employeeComments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, employeeComments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrPayrollTransitionWarningRequest',
    )..add('employeeComments', employeeComments)).toString();
  }
}

class HrPayrollTransitionWarningRequestBuilder
    implements
        Builder<
          HrPayrollTransitionWarningRequest,
          HrPayrollTransitionWarningRequestBuilder
        > {
  _$HrPayrollTransitionWarningRequest? _$v;

  String? _employeeComments;
  String? get employeeComments => _$this._employeeComments;
  set employeeComments(String? employeeComments) =>
      _$this._employeeComments = employeeComments;

  HrPayrollTransitionWarningRequestBuilder() {
    HrPayrollTransitionWarningRequest._defaults(this);
  }

  HrPayrollTransitionWarningRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _employeeComments = $v.employeeComments;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollTransitionWarningRequest other) {
    _$v = other as _$HrPayrollTransitionWarningRequest;
  }

  @override
  void update(
    void Function(HrPayrollTransitionWarningRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollTransitionWarningRequest build() => _build();

  _$HrPayrollTransitionWarningRequest _build() {
    final _$result =
        _$v ??
        _$HrPayrollTransitionWarningRequest._(
          employeeComments: BuiltValueNullFieldError.checkNotNull(
            employeeComments,
            r'HrPayrollTransitionWarningRequest',
            'employeeComments',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
