// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance332_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance332Request extends HrStaffAttendance332Request {
  @override
  final BuiltList<HrStaffAttendance331RecordsParameterInner> records;

  factory _$HrStaffAttendance332Request([
    void Function(HrStaffAttendance332RequestBuilder)? updates,
  ]) => (HrStaffAttendance332RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance332Request._({required this.records}) : super._();
  @override
  HrStaffAttendance332Request rebuild(
    void Function(HrStaffAttendance332RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance332RequestBuilder toBuilder() =>
      HrStaffAttendance332RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance332Request && records == other.records;
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
      r'HrStaffAttendance332Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance332RequestBuilder
    implements
        Builder<
          HrStaffAttendance332Request,
          HrStaffAttendance332RequestBuilder
        > {
  _$HrStaffAttendance332Request? _$v;

  ListBuilder<HrStaffAttendance331RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance331RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance331RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance331RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance332RequestBuilder() {
    HrStaffAttendance332Request._defaults(this);
  }

  HrStaffAttendance332RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance332Request other) {
    _$v = other as _$HrStaffAttendance332Request;
  }

  @override
  void update(void Function(HrStaffAttendance332RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance332Request build() => _build();

  _$HrStaffAttendance332Request _build() {
    _$HrStaffAttendance332Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance332Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance332Request',
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
