// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance325_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance325RecordsParameterInnerStatusEnum
_$hrStaffAttendance325RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance325RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance325RecordsParameterInnerStatusEnum
_$hrStaffAttendance325RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance325RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance325RecordsParameterInnerStatusEnum
_$hrStaffAttendance325RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance325RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance325RecordsParameterInnerStatusEnum
_$hrStaffAttendance325RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance325RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance325RecordsParameterInnerStatusEnum
_$hrStaffAttendance325RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance325RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance325RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance325RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance325RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance325RecordsParameterInnerStatusEnum>
_$hrStaffAttendance325RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance325RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance325RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance325RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance325RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance325RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance325RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance325RecordsParameterInnerStatusEnum>
_$hrStaffAttendance325RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance325RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance325RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance325RecordsParameterInnerStatusEnum
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
    HrStaffAttendance325RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance325RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance325RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance325RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance325RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance325RecordsParameterInner
    extends HrStaffAttendance325RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance325RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance325RecordsParameterInner([
    void Function(HrStaffAttendance325RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance325RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance325RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance325RecordsParameterInner rebuild(
    void Function(HrStaffAttendance325RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance325RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance325RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance325RecordsParameterInner &&
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
            r'HrStaffAttendance325RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance325RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance325RecordsParameterInner,
          HrStaffAttendance325RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance325RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance325RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance325RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance325RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance325RecordsParameterInnerBuilder() {
    HrStaffAttendance325RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance325RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance325RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance325RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance325RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance325RecordsParameterInner build() => _build();

  _$HrStaffAttendance325RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance325RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance325RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance325RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance325RecordsParameterInner',
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
