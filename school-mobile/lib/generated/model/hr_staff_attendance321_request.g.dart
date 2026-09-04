// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance321_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance321Request extends HrStaffAttendance321Request {
  @override
  final BuiltList<HrStaffAttendance320RecordsParameterInner> records;

  factory _$HrStaffAttendance321Request([
    void Function(HrStaffAttendance321RequestBuilder)? updates,
  ]) => (HrStaffAttendance321RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance321Request._({required this.records}) : super._();
  @override
  HrStaffAttendance321Request rebuild(
    void Function(HrStaffAttendance321RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance321RequestBuilder toBuilder() =>
      HrStaffAttendance321RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance321Request && records == other.records;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrStaffAttendance321Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance321RequestBuilder
    implements
        Builder<
          HrStaffAttendance321Request,
          HrStaffAttendance321RequestBuilder
        > {
  _$HrStaffAttendance321Request? _$v;

  ListBuilder<HrStaffAttendance320RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance320RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance320RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance320RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance321RequestBuilder() {
    HrStaffAttendance321Request._defaults(this);
  }

  HrStaffAttendance321RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance321Request other) {
    _$v = other as _$HrStaffAttendance321Request;
  }

  @override
  void update(void Function(HrStaffAttendance321RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance321Request build() => _build();

  _$HrStaffAttendance321Request _build() {
    _$HrStaffAttendance321Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance321Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance321Request',
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
