// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance336_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance336RecordsParameterInnerStatusEnum
_$hrStaffAttendance336RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance336RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance336RecordsParameterInnerStatusEnum
_$hrStaffAttendance336RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance336RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance336RecordsParameterInnerStatusEnum
_$hrStaffAttendance336RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance336RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance336RecordsParameterInnerStatusEnum
_$hrStaffAttendance336RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance336RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance336RecordsParameterInnerStatusEnum
_$hrStaffAttendance336RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance336RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance336RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance336RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance336RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance336RecordsParameterInnerStatusEnum>
_$hrStaffAttendance336RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance336RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance336RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance336RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance336RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance336RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance336RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance336RecordsParameterInnerStatusEnum>
_$hrStaffAttendance336RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance336RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance336RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance336RecordsParameterInnerStatusEnum
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
    HrStaffAttendance336RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance336RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance336RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance336RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance336RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance336RecordsParameterInner
    extends HrStaffAttendance336RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance336RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance336RecordsParameterInner([
    void Function(HrStaffAttendance336RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance336RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance336RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance336RecordsParameterInner rebuild(
    void Function(HrStaffAttendance336RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance336RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance336RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance336RecordsParameterInner &&
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
            r'HrStaffAttendance336RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance336RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance336RecordsParameterInner,
          HrStaffAttendance336RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance336RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance336RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance336RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance336RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance336RecordsParameterInnerBuilder() {
    HrStaffAttendance336RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance336RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance336RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance336RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance336RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance336RecordsParameterInner build() => _build();

  _$HrStaffAttendance336RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance336RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance336RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance336RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance336RecordsParameterInner',
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
