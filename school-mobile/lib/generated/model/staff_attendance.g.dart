// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_attendance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StaffAttendance extends StaffAttendance {
  @override
  final int id;
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final String status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$StaffAttendance([void Function(StaffAttendanceBuilder)? updates]) =>
      (StaffAttendanceBuilder()..update(updates))._build();

  _$StaffAttendance._({
    required this.id,
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  StaffAttendance rebuild(void Function(StaffAttendanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaffAttendanceBuilder toBuilder() => StaffAttendanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaffAttendance &&
        id == other.id &&
        staffUserId == other.staffUserId &&
        date == other.date &&
        status == other.status &&
        checkIn == other.checkIn &&
        checkOut == other.checkOut &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, staffUserId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, checkIn.hashCode);
    _$hash = $jc(_$hash, checkOut.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StaffAttendance')
          ..add('id', id)
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class StaffAttendanceBuilder
    implements Builder<StaffAttendance, StaffAttendanceBuilder> {
  _$StaffAttendance? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  StaffAttendanceBuilder() {
    StaffAttendance._defaults(this);
  }

  StaffAttendanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _staffUserId = $v.staffUserId;
      _date = $v.date;
      _status = $v.status;
      _checkIn = $v.checkIn;
      _checkOut = $v.checkOut;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaffAttendance other) {
    _$v = other as _$StaffAttendance;
  }

  @override
  void update(void Function(StaffAttendanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StaffAttendance build() => _build();

  _$StaffAttendance _build() {
    final _$result =
        _$v ??
        _$StaffAttendance._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'StaffAttendance',
            'id',
          ),
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'StaffAttendance',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'StaffAttendance',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'StaffAttendance',
            'status',
          ),
          checkIn: checkIn,
          checkOut: checkOut,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'StaffAttendance',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
