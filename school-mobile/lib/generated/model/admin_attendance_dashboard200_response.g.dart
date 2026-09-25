// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_attendance_dashboard200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminAttendanceDashboard200Response
    extends AdminAttendanceDashboard200Response {
  @override
  final BuiltList<JsonObject?> today;
  @override
  final BuiltList<AttendanceRecord> byClass;

  factory _$AdminAttendanceDashboard200Response([
    void Function(AdminAttendanceDashboard200ResponseBuilder)? updates,
  ]) =>
      (AdminAttendanceDashboard200ResponseBuilder()..update(updates))._build();

  _$AdminAttendanceDashboard200Response._({
    required this.today,
    required this.byClass,
  }) : super._();
  @override
  AdminAttendanceDashboard200Response rebuild(
    void Function(AdminAttendanceDashboard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminAttendanceDashboard200ResponseBuilder toBuilder() =>
      AdminAttendanceDashboard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminAttendanceDashboard200Response &&
        today == other.today &&
        byClass == other.byClass;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, today.hashCode);
    _$hash = $jc(_$hash, byClass.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminAttendanceDashboard200Response')
          ..add('today', today)
          ..add('byClass', byClass))
        .toString();
  }
}

class AdminAttendanceDashboard200ResponseBuilder
    implements
        Builder<
          AdminAttendanceDashboard200Response,
          AdminAttendanceDashboard200ResponseBuilder
        > {
  _$AdminAttendanceDashboard200Response? _$v;

  ListBuilder<JsonObject?>? _today;
  ListBuilder<JsonObject?> get today =>
      _$this._today ??= ListBuilder<JsonObject?>();
  set today(ListBuilder<JsonObject?>? today) => _$this._today = today;

  ListBuilder<AttendanceRecord>? _byClass;
  ListBuilder<AttendanceRecord> get byClass =>
      _$this._byClass ??= ListBuilder<AttendanceRecord>();
  set byClass(ListBuilder<AttendanceRecord>? byClass) =>
      _$this._byClass = byClass;

  AdminAttendanceDashboard200ResponseBuilder() {
    AdminAttendanceDashboard200Response._defaults(this);
  }

  AdminAttendanceDashboard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _today = $v.today.toBuilder();
      _byClass = $v.byClass.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminAttendanceDashboard200Response other) {
    _$v = other as _$AdminAttendanceDashboard200Response;
  }

  @override
  void update(
    void Function(AdminAttendanceDashboard200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminAttendanceDashboard200Response build() => _build();

  _$AdminAttendanceDashboard200Response _build() {
    _$AdminAttendanceDashboard200Response _$result;
    try {
      _$result =
          _$v ??
          _$AdminAttendanceDashboard200Response._(
            today: today.build(),
            byClass: byClass.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'today';
        today.build();
        _$failedField = 'byClass';
        byClass.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AdminAttendanceDashboard200Response',
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
