// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance337_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance337Request extends HrStaffAttendance337Request {
  @override
  final BuiltList<HrStaffAttendance336RecordsParameterInner> records;

  factory _$HrStaffAttendance337Request([
    void Function(HrStaffAttendance337RequestBuilder)? updates,
  ]) => (HrStaffAttendance337RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance337Request._({required this.records}) : super._();
  @override
  HrStaffAttendance337Request rebuild(
    void Function(HrStaffAttendance337RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance337RequestBuilder toBuilder() =>
      HrStaffAttendance337RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance337Request && records == other.records;
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
      r'HrStaffAttendance337Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance337RequestBuilder
    implements
        Builder<
          HrStaffAttendance337Request,
          HrStaffAttendance337RequestBuilder
        > {
  _$HrStaffAttendance337Request? _$v;

  ListBuilder<HrStaffAttendance336RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance336RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance336RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance336RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance337RequestBuilder() {
    HrStaffAttendance337Request._defaults(this);
  }

  HrStaffAttendance337RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance337Request other) {
    _$v = other as _$HrStaffAttendance337Request;
  }

  @override
  void update(void Function(HrStaffAttendance337RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance337Request build() => _build();

  _$HrStaffAttendance337Request _build() {
    _$HrStaffAttendance337Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance337Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance337Request',
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
