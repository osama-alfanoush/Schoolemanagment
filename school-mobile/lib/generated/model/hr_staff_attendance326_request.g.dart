// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance326_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance326Request extends HrStaffAttendance326Request {
  @override
  final BuiltList<HrStaffAttendance325RecordsParameterInner> records;

  factory _$HrStaffAttendance326Request([
    void Function(HrStaffAttendance326RequestBuilder)? updates,
  ]) => (HrStaffAttendance326RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance326Request._({required this.records}) : super._();
  @override
  HrStaffAttendance326Request rebuild(
    void Function(HrStaffAttendance326RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance326RequestBuilder toBuilder() =>
      HrStaffAttendance326RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance326Request && records == other.records;
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
      r'HrStaffAttendance326Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance326RequestBuilder
    implements
        Builder<
          HrStaffAttendance326Request,
          HrStaffAttendance326RequestBuilder
        > {
  _$HrStaffAttendance326Request? _$v;

  ListBuilder<HrStaffAttendance325RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance325RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance325RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance325RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance326RequestBuilder() {
    HrStaffAttendance326Request._defaults(this);
  }

  HrStaffAttendance326RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance326Request other) {
    _$v = other as _$HrStaffAttendance326Request;
  }

  @override
  void update(void Function(HrStaffAttendance326RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance326Request build() => _build();

  _$HrStaffAttendance326Request _build() {
    _$HrStaffAttendance326Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance326Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance326Request',
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
