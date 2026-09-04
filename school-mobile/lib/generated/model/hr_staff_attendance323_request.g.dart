// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance323_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance323Request extends HrStaffAttendance323Request {
  @override
  final BuiltList<HrStaffAttendance322RecordsParameterInner> records;

  factory _$HrStaffAttendance323Request([
    void Function(HrStaffAttendance323RequestBuilder)? updates,
  ]) => (HrStaffAttendance323RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance323Request._({required this.records}) : super._();
  @override
  HrStaffAttendance323Request rebuild(
    void Function(HrStaffAttendance323RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance323RequestBuilder toBuilder() =>
      HrStaffAttendance323RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance323Request && records == other.records;
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
      r'HrStaffAttendance323Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance323RequestBuilder
    implements
        Builder<
          HrStaffAttendance323Request,
          HrStaffAttendance323RequestBuilder
        > {
  _$HrStaffAttendance323Request? _$v;

  ListBuilder<HrStaffAttendance322RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance322RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance322RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance322RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance323RequestBuilder() {
    HrStaffAttendance323Request._defaults(this);
  }

  HrStaffAttendance323RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance323Request other) {
    _$v = other as _$HrStaffAttendance323Request;
  }

  @override
  void update(void Function(HrStaffAttendance323RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance323Request build() => _build();

  _$HrStaffAttendance323Request _build() {
    _$HrStaffAttendance323Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance323Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance323Request',
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
