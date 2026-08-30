// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_settings_assign_component_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollSettingsAssignComponentRequest
    extends PayrollSettingsAssignComponentRequest {
  @override
  final int payrollComponentId;
  @override
  final num? amountOverride;
  @override
  final num? rateOverride;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveTo;
  @override
  final DateTime? oneTimePeriod;
  @override
  final String reason;

  factory _$PayrollSettingsAssignComponentRequest([
    void Function(PayrollSettingsAssignComponentRequestBuilder)? updates,
  ]) => (PayrollSettingsAssignComponentRequestBuilder()..update(updates))
      ._build();

  _$PayrollSettingsAssignComponentRequest._({
    required this.payrollComponentId,
    this.amountOverride,
    this.rateOverride,
    required this.effectiveFrom,
    this.effectiveTo,
    this.oneTimePeriod,
    required this.reason,
  }) : super._();
  @override
  PayrollSettingsAssignComponentRequest rebuild(
    void Function(PayrollSettingsAssignComponentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PayrollSettingsAssignComponentRequestBuilder toBuilder() =>
      PayrollSettingsAssignComponentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollSettingsAssignComponentRequest &&
        payrollComponentId == other.payrollComponentId &&
        amountOverride == other.amountOverride &&
        rateOverride == other.rateOverride &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo &&
        oneTimePeriod == other.oneTimePeriod &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, payrollComponentId.hashCode);
    _$hash = $jc(_$hash, amountOverride.hashCode);
    _$hash = $jc(_$hash, rateOverride.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jc(_$hash, oneTimePeriod.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'PayrollSettingsAssignComponentRequest',
          )
          ..add('payrollComponentId', payrollComponentId)
          ..add('amountOverride', amountOverride)
          ..add('rateOverride', rateOverride)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo)
          ..add('oneTimePeriod', oneTimePeriod)
          ..add('reason', reason))
        .toString();
  }
}

class PayrollSettingsAssignComponentRequestBuilder
    implements
        Builder<
          PayrollSettingsAssignComponentRequest,
          PayrollSettingsAssignComponentRequestBuilder
        > {
  _$PayrollSettingsAssignComponentRequest? _$v;

  int? _payrollComponentId;
  int? get payrollComponentId => _$this._payrollComponentId;
  set payrollComponentId(int? payrollComponentId) =>
      _$this._payrollComponentId = payrollComponentId;

  num? _amountOverride;
  num? get amountOverride => _$this._amountOverride;
  set amountOverride(num? amountOverride) =>
      _$this._amountOverride = amountOverride;

  num? _rateOverride;
  num? get rateOverride => _$this._rateOverride;
  set rateOverride(num? rateOverride) => _$this._rateOverride = rateOverride;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  DateTime? _oneTimePeriod;
  DateTime? get oneTimePeriod => _$this._oneTimePeriod;
  set oneTimePeriod(DateTime? oneTimePeriod) =>
      _$this._oneTimePeriod = oneTimePeriod;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  PayrollSettingsAssignComponentRequestBuilder() {
    PayrollSettingsAssignComponentRequest._defaults(this);
  }

  PayrollSettingsAssignComponentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _payrollComponentId = $v.payrollComponentId;
      _amountOverride = $v.amountOverride;
      _rateOverride = $v.rateOverride;
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _oneTimePeriod = $v.oneTimePeriod;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollSettingsAssignComponentRequest other) {
    _$v = other as _$PayrollSettingsAssignComponentRequest;
  }

  @override
  void update(
    void Function(PayrollSettingsAssignComponentRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PayrollSettingsAssignComponentRequest build() => _build();

  _$PayrollSettingsAssignComponentRequest _build() {
    final _$result =
        _$v ??
        _$PayrollSettingsAssignComponentRequest._(
          payrollComponentId: BuiltValueNullFieldError.checkNotNull(
            payrollComponentId,
            r'PayrollSettingsAssignComponentRequest',
            'payrollComponentId',
          ),
          amountOverride: amountOverride,
          rateOverride: rateOverride,
          effectiveFrom: BuiltValueNullFieldError.checkNotNull(
            effectiveFrom,
            r'PayrollSettingsAssignComponentRequest',
            'effectiveFrom',
          ),
          effectiveTo: effectiveTo,
          oneTimePeriod: oneTimePeriod,
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'PayrollSettingsAssignComponentRequest',
            'reason',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
