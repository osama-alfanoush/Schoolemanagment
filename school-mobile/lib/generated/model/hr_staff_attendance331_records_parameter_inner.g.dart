// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance331_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance331RecordsParameterInnerStatusEnum
_$hrStaffAttendance331RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance331RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance331RecordsParameterInnerStatusEnum
_$hrStaffAttendance331RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance331RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance331RecordsParameterInnerStatusEnum
_$hrStaffAttendance331RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance331RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance331RecordsParameterInnerStatusEnum
_$hrStaffAttendance331RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance331RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance331RecordsParameterInnerStatusEnum
_$hrStaffAttendance331RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance331RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance331RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance331RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance331RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance331RecordsParameterInnerStatusEnum>
_$hrStaffAttendance331RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance331RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance331RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance331RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance331RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance331RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance331RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance331RecordsParameterInnerStatusEnum>
_$hrStaffAttendance331RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance331RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance331RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance331RecordsParameterInnerStatusEnum
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
    HrStaffAttendance331RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance331RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance331RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance331RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance331RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance331RecordsParameterInner
    extends HrStaffAttendance331RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance331RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance331RecordsParameterInner([
    void Function(HrStaffAttendance331RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance331RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance331RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance331RecordsParameterInner rebuild(
    void Function(HrStaffAttendance331RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance331RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance331RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance331RecordsParameterInner &&
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
            r'HrStaffAttendance331RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance331RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance331RecordsParameterInner,
          HrStaffAttendance331RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance331RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance331RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance331RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance331RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance331RecordsParameterInnerBuilder() {
    HrStaffAttendance331RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance331RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance331RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance331RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance331RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance331RecordsParameterInner build() => _build();

  _$HrStaffAttendance331RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance331RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance331RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance331RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance331RecordsParameterInner',
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
