// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance345_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance345RecordsParameterInnerStatusEnum
_$hrStaffAttendance345RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance345RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance345RecordsParameterInnerStatusEnum
_$hrStaffAttendance345RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance345RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance345RecordsParameterInnerStatusEnum
_$hrStaffAttendance345RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance345RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance345RecordsParameterInnerStatusEnum
_$hrStaffAttendance345RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance345RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance345RecordsParameterInnerStatusEnum
_$hrStaffAttendance345RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance345RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance345RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance345RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance345RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance345RecordsParameterInnerStatusEnum>
_$hrStaffAttendance345RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance345RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance345RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance345RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance345RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance345RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance345RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance345RecordsParameterInnerStatusEnum>
_$hrStaffAttendance345RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance345RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance345RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance345RecordsParameterInnerStatusEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'present': 'present',
    'absent': 'absent',
    'late_': 'late',
    'leave': 'leave',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'present': 'present',
    'absent': 'absent',
    'late': 'late_',
    'leave': 'leave',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance345RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance345RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance345RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance345RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance345RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance345RecordsParameterInner
    extends HrStaffAttendance345RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance345RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance345RecordsParameterInner([
    void Function(HrStaffAttendance345RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance345RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance345RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance345RecordsParameterInner rebuild(
    void Function(HrStaffAttendance345RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance345RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance345RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance345RecordsParameterInner &&
        staffUserId == other.staffUserId &&
        date == other.date &&
        status == other.status &&
        checkIn == other.checkIn &&
        checkOut == other.checkOut;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, staffUserId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, checkIn.hashCode);
    _$hash = $jc(_$hash, checkOut.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'HrStaffAttendance345RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance345RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance345RecordsParameterInner,
          HrStaffAttendance345RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance345RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance345RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance345RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance345RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance345RecordsParameterInnerBuilder() {
    HrStaffAttendance345RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance345RecordsParameterInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _staffUserId = $v.staffUserId;
      _date = $v.date;
      _status = $v.status;
      _checkIn = $v.checkIn;
      _checkOut = $v.checkOut;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance345RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance345RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance345RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance345RecordsParameterInner build() => _build();

  _$HrStaffAttendance345RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance345RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance345RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance345RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance345RecordsParameterInner',
            'status',
          ),
          checkIn: checkIn,
          checkOut: checkOut,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
