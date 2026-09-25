// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_kpis200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminDashboardKpis200Response extends AdminDashboardKpis200Response {
  @override
  final AdminDashboardKpis200ResponseData data;
  @override
  final AdminDashboardKpis200ResponseSummary summary;

  factory _$AdminDashboardKpis200Response([
    void Function(AdminDashboardKpis200ResponseBuilder)? updates,
  ]) => (AdminDashboardKpis200ResponseBuilder()..update(updates))._build();

  _$AdminDashboardKpis200Response._({required this.data, required this.summary})
    : super._();
  @override
  AdminDashboardKpis200Response rebuild(
    void Function(AdminDashboardKpis200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminDashboardKpis200ResponseBuilder toBuilder() =>
      AdminDashboardKpis200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminDashboardKpis200Response &&
        data == other.data &&
        summary == other.summary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminDashboardKpis200Response')
          ..add('data', data)
          ..add('summary', summary))
        .toString();
  }
}

class AdminDashboardKpis200ResponseBuilder
    implements
        Builder<
          AdminDashboardKpis200Response,
          AdminDashboardKpis200ResponseBuilder
        > {
  _$AdminDashboardKpis200Response? _$v;

  AdminDashboardKpis200ResponseDataBuilder? _data;
  AdminDashboardKpis200ResponseDataBuilder get data =>
      _$this._data ??= AdminDashboardKpis200ResponseDataBuilder();
  set data(AdminDashboardKpis200ResponseDataBuilder? data) =>
      _$this._data = data;

  AdminDashboardKpis200ResponseSummaryBuilder? _summary;
  AdminDashboardKpis200ResponseSummaryBuilder get summary =>
      _$this._summary ??= AdminDashboardKpis200ResponseSummaryBuilder();
  set summary(AdminDashboardKpis200ResponseSummaryBuilder? summary) =>
      _$this._summary = summary;

  AdminDashboardKpis200ResponseBuilder() {
    AdminDashboardKpis200Response._defaults(this);
  }

  AdminDashboardKpis200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _summary = $v.summary.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminDashboardKpis200Response other) {
    _$v = other as _$AdminDashboardKpis200Response;
  }

  @override
  void update(void Function(AdminDashboardKpis200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminDashboardKpis200Response build() => _build();

  _$AdminDashboardKpis200Response _build() {
    _$AdminDashboardKpis200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminDashboardKpis200Response._(
            data: data.build(),
            summary: summary.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'summary';
        summary.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminDashboardKpis200Response',
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
