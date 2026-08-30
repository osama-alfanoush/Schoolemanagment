// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_kpis200_response_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminDashboardKpis200ResponseSummary
    extends AdminDashboardKpis200ResponseSummary {
  @override
  final String generatedAt;

  factory _$AdminDashboardKpis200ResponseSummary([
    void Function(AdminDashboardKpis200ResponseSummaryBuilder)? updates,
  ]) =>
      (AdminDashboardKpis200ResponseSummaryBuilder()..update(updates))._build();

  _$AdminDashboardKpis200ResponseSummary._({required this.generatedAt})
    : super._();
  @override
  AdminDashboardKpis200ResponseSummary rebuild(
    void Function(AdminDashboardKpis200ResponseSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminDashboardKpis200ResponseSummaryBuilder toBuilder() =>
      AdminDashboardKpis200ResponseSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminDashboardKpis200ResponseSummary &&
        generatedAt == other.generatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminDashboardKpis200ResponseSummary',
    )..add('generatedAt', generatedAt)).toString();
  }
}

class AdminDashboardKpis200ResponseSummaryBuilder
    implements
        Builder<
          AdminDashboardKpis200ResponseSummary,
          AdminDashboardKpis200ResponseSummaryBuilder
        > {
  _$AdminDashboardKpis200ResponseSummary? _$v;

  String? _generatedAt;
  String? get generatedAt => _$this._generatedAt;
  set generatedAt(String? generatedAt) => _$this._generatedAt = generatedAt;

  AdminDashboardKpis200ResponseSummaryBuilder() {
    AdminDashboardKpis200ResponseSummary._defaults(this);
  }

  AdminDashboardKpis200ResponseSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _generatedAt = $v.generatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminDashboardKpis200ResponseSummary other) {
    _$v = other as _$AdminDashboardKpis200ResponseSummary;
  }

  @override
  void update(
    void Function(AdminDashboardKpis200ResponseSummaryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminDashboardKpis200ResponseSummary build() => _build();

  _$AdminDashboardKpis200ResponseSummary _build() {
    final _$result =
        _$v ??
        _$AdminDashboardKpis200ResponseSummary._(
          generatedAt: BuiltValueNullFieldError.checkNotNull(
            generatedAt,
            r'AdminDashboardKpis200ResponseSummary',
            'generatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
