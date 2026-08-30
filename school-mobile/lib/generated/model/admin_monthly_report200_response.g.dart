// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_monthly_report200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminMonthlyReport200Response extends AdminMonthlyReport200Response {
  @override
  final int month;
  @override
  final int year;
  @override
  final BuiltList<JsonObject?> attendance;
  @override
  final AdminMonthlyReport200ResponseFinance finance;
  @override
  final int hrPending;

  factory _$AdminMonthlyReport200Response([
    void Function(AdminMonthlyReport200ResponseBuilder)? updates,
  ]) => (AdminMonthlyReport200ResponseBuilder()..update(updates))._build();

  _$AdminMonthlyReport200Response._({
    required this.month,
    required this.year,
    required this.attendance,
    required this.finance,
    required this.hrPending,
  }) : super._();
  @override
  AdminMonthlyReport200Response rebuild(
    void Function(AdminMonthlyReport200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminMonthlyReport200ResponseBuilder toBuilder() =>
      AdminMonthlyReport200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminMonthlyReport200Response &&
        month == other.month &&
        year == other.year &&
        attendance == other.attendance &&
        finance == other.finance &&
        hrPending == other.hrPending;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, attendance.hashCode);
    _$hash = $jc(_$hash, finance.hashCode);
    _$hash = $jc(_$hash, hrPending.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminMonthlyReport200Response')
          ..add('month', month)
          ..add('year', year)
          ..add('attendance', attendance)
          ..add('finance', finance)
          ..add('hrPending', hrPending))
        .toString();
  }
}

class AdminMonthlyReport200ResponseBuilder
    implements
        Builder<
          AdminMonthlyReport200Response,
          AdminMonthlyReport200ResponseBuilder
        > {
  _$AdminMonthlyReport200Response? _$v;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  ListBuilder<JsonObject?>? _attendance;
  ListBuilder<JsonObject?> get attendance =>
      _$this._attendance ??= ListBuilder<JsonObject?>();
  set attendance(ListBuilder<JsonObject?>? attendance) =>
      _$this._attendance = attendance;

  AdminMonthlyReport200ResponseFinanceBuilder? _finance;
  AdminMonthlyReport200ResponseFinanceBuilder get finance =>
      _$this._finance ??= AdminMonthlyReport200ResponseFinanceBuilder();
  set finance(AdminMonthlyReport200ResponseFinanceBuilder? finance) =>
      _$this._finance = finance;

  int? _hrPending;
  int? get hrPending => _$this._hrPending;
  set hrPending(int? hrPending) => _$this._hrPending = hrPending;

  AdminMonthlyReport200ResponseBuilder() {
    AdminMonthlyReport200Response._defaults(this);
  }

  AdminMonthlyReport200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _year = $v.year;
      _attendance = $v.attendance.toBuilder();
      _finance = $v.finance.toBuilder();
      _hrPending = $v.hrPending;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminMonthlyReport200Response other) {
    _$v = other as _$AdminMonthlyReport200Response;
  }

  @override
  void update(void Function(AdminMonthlyReport200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminMonthlyReport200Response build() => _build();

  _$AdminMonthlyReport200Response _build() {
    _$AdminMonthlyReport200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminMonthlyReport200Response._(
            month: BuiltValueNullFieldError.checkNotNull(
              month,
              r'AdminMonthlyReport200Response',
              'month',
            ),
            year: BuiltValueNullFieldError.checkNotNull(
              year,
              r'AdminMonthlyReport200Response',
              'year',
            ),
            attendance: attendance.build(),
            finance: finance.build(),
            hrPending: BuiltValueNullFieldError.checkNotNull(
              hrPending,
              r'AdminMonthlyReport200Response',
              'hrPending',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attendance';
        attendance.build();
        _$failedField = 'finance';
        finance.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminMonthlyReport200Response',
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
