// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_update_record_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollUpdateRecordRequest extends PayrollUpdateRecordRequest {
  @override
  final num? allowances;
  @override
  final num? deductions;
  @override
  final String reason;

  factory _$PayrollUpdateRecordRequest([
    void Function(PayrollUpdateRecordRequestBuilder)? updates,
  ]) => (PayrollUpdateRecordRequestBuilder()..update(updates))._build();

  _$PayrollUpdateRecordRequest._({
    this.allowances,
    this.deductions,
    required this.reason,
  }) : super._();
  @override
  PayrollUpdateRecordRequest rebuild(
    void Function(PayrollUpdateRecordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PayrollUpdateRecordRequestBuilder toBuilder() =>
      PayrollUpdateRecordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollUpdateRecordRequest &&
        allowances == other.allowances &&
        deductions == other.deductions &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, allowances.hashCode);
    _$hash = $jc(_$hash, deductions.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollUpdateRecordRequest')
          ..add('allowances', allowances)
          ..add('deductions', deductions)
          ..add('reason', reason))
        .toString();
  }
}

class PayrollUpdateRecordRequestBuilder
    implements
        Builder<PayrollUpdateRecordRequest, PayrollUpdateRecordRequestBuilder> {
  _$PayrollUpdateRecordRequest? _$v;

  num? _allowances;
  num? get allowances => _$this._allowances;
  set allowances(num? allowances) => _$this._allowances = allowances;

  num? _deductions;
  num? get deductions => _$this._deductions;
  set deductions(num? deductions) => _$this._deductions = deductions;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  PayrollUpdateRecordRequestBuilder() {
    PayrollUpdateRecordRequest._defaults(this);
  }

  PayrollUpdateRecordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _allowances = $v.allowances;
      _deductions = $v.deductions;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollUpdateRecordRequest other) {
    _$v = other as _$PayrollUpdateRecordRequest;
  }

  @override
  void update(void Function(PayrollUpdateRecordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollUpdateRecordRequest build() => _build();

  _$PayrollUpdateRecordRequest _build() {
    final _$result =
        _$v ??
        _$PayrollUpdateRecordRequest._(
          allowances: allowances,
          deductions: deductions,
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'PayrollUpdateRecordRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
