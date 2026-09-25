// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance364_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrStaffAttendance364Request extends HrStaffAttendance364Request {
  @override
  final BuiltList<HrStaffAttendance363RecordsParameterInner> records;

  factory _$HrStaffAttendance364Request([
    void Function(HrStaffAttendance364RequestBuilder)? updates,
  ]) => (HrStaffAttendance364RequestBuilder()..update(updates))._build();

  _$HrStaffAttendance364Request._({required this.records}) : super._();
  @override
  HrStaffAttendance364Request rebuild(
    void Function(HrStaffAttendance364RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance364RequestBuilder toBuilder() =>
      HrStaffAttendance364RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance364Request && records == other.records;
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
      r'HrStaffAttendance364Request',
    )..add('records', records)).toString();
  }
}

class HrStaffAttendance364RequestBuilder
    implements
        Builder<
          HrStaffAttendance364Request,
          HrStaffAttendance364RequestBuilder
        > {
  _$HrStaffAttendance364Request? _$v;

  ListBuilder<HrStaffAttendance363RecordsParameterInner>? _records;
  ListBuilder<HrStaffAttendance363RecordsParameterInner> get records =>
      _$this._records ??=
          ListBuilder<HrStaffAttendance363RecordsParameterInner>();
  set records(
    ListBuilder<HrStaffAttendance363RecordsParameterInner>? records,
  ) => _$this._records = records;

  HrStaffAttendance364RequestBuilder() {
    HrStaffAttendance364Request._defaults(this);
  }

  HrStaffAttendance364RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance364Request other) {
    _$v = other as _$HrStaffAttendance364Request;
  }

  @override
  void update(void Function(HrStaffAttendance364RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance364Request build() => _build();

  _$HrStaffAttendance364Request _build() {
    _$HrStaffAttendance364Request _$result;
    try {
      _$result =
          _$v ?? _$HrStaffAttendance364Request._(records: records.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrStaffAttendance364Request',
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
