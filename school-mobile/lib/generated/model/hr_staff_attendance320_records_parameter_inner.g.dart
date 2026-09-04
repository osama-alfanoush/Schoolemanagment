// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance320_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance320RecordsParameterInnerStatusEnum
_$hrStaffAttendance320RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance320RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance320RecordsParameterInnerStatusEnum
_$hrStaffAttendance320RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance320RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance320RecordsParameterInnerStatusEnum
_$hrStaffAttendance320RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance320RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance320RecordsParameterInnerStatusEnum
_$hrStaffAttendance320RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance320RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance320RecordsParameterInnerStatusEnum
_$hrStaffAttendance320RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance320RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance320RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance320RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance320RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance320RecordsParameterInnerStatusEnum>
_$hrStaffAttendance320RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance320RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance320RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance320RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance320RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance320RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance320RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance320RecordsParameterInnerStatusEnum>
_$hrStaffAttendance320RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance320RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance320RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance320RecordsParameterInnerStatusEnum
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
    HrStaffAttendance320RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance320RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance320RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance320RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance320RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance320RecordsParameterInner
    extends HrStaffAttendance320RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance320RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance320RecordsParameterInner([
    void Function(HrStaffAttendance320RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance320RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance320RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance320RecordsParameterInner rebuild(
    void Function(HrStaffAttendance320RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance320RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance320RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance320RecordsParameterInner &&
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
            r'HrStaffAttendance320RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance320RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance320RecordsParameterInner,
          HrStaffAttendance320RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance320RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance320RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance320RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance320RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance320RecordsParameterInnerBuilder() {
    HrStaffAttendance320RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance320RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance320RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance320RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance320RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance320RecordsParameterInner build() => _build();

  _$HrStaffAttendance320RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance320RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance320RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance320RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance320RecordsParameterInner',
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
