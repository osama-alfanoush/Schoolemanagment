// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance346_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance346Request extends HrStaffAttendance346Request {
  @override
  final BuiltList<HrStaffAttendance345RecordsParameterInner> records;

  factory _$HrStaffAttendance346Request([
    void Function(HrStaffAttendance346RequestBuilder)? updates,
  ]) => (HrStaffAttendance346RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance346Request._({required this.records}) : super._();
  @override
  HrStaffAttendance346Request rebuild(
    void Function(HrStaffAttendance346RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance346RequestBuilder toBuilder() =>
      HrStaffAttendance346RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance346Request && records == other.records;
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
      r'HrStaffAttendance346Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance346RequestBuilder
    implements
        Builder<
          HrStaffAttendance346Request,
          HrStaffAttendance346RequestBuilder
        > {
  _$HrStaffAttendance346Request? _$v;

  ListBuilder<HrStaffAttendance345RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance345RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance345RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance345RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance346RequestBuilder() {
    HrStaffAttendance346Request._defaults(this);
  }

  HrStaffAttendance346RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance346Request other) {
    _$v = other as _$HrStaffAttendance346Request;
  }

  @override
  void update(void Function(HrStaffAttendance346RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance346Request build() => _build();

  _$HrStaffAttendance346Request _build() {
    _$HrStaffAttendance346Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance346Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance346Request',
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
