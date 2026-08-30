// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance320_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance320Request extends HrStaffAttendance320Request {
  @override
  final BuiltList<HrStaffAttendance319RecordsParameterInner> records;

  factory _$HrStaffAttendance320Request([
    void Function(HrStaffAttendance320RequestBuilder)? updates,
  ]) => (HrStaffAttendance320RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance320Request._({required this.records}) : super._();
  @override
  HrStaffAttendance320Request rebuild(
    void Function(HrStaffAttendance320RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance320RequestBuilder toBuilder() =>
      HrStaffAttendance320RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance320Request && records == other.records;
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
      r'HrStaffAttendance320Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance320RequestBuilder
    implements
        Builder<
          HrStaffAttendance320Request,
          HrStaffAttendance320RequestBuilder
        > {
  _$HrStaffAttendance320Request? _$v;

  ListBuilder<HrStaffAttendance319RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance319RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance319RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance319RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance320RequestBuilder() {
    HrStaffAttendance320Request._defaults(this);
  }

  HrStaffAttendance320RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance320Request other) {
    _$v = other as _$HrStaffAttendance320Request;
  }

  @override
  void update(void Function(HrStaffAttendance320RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance320Request build() => _build();

  _$HrStaffAttendance320Request _build() {
    _$HrStaffAttendance320Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance320Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance320Request',
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
