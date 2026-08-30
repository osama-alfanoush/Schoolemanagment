// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance319_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance319RecordsParameterInnerStatusEnum
_$hrStaffAttendance319RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance319RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance319RecordsParameterInnerStatusEnum
_$hrStaffAttendance319RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance319RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance319RecordsParameterInnerStatusEnum
_$hrStaffAttendance319RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance319RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance319RecordsParameterInnerStatusEnum
_$hrStaffAttendance319RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance319RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance319RecordsParameterInnerStatusEnum
_$hrStaffAttendance319RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance319RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance319RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance319RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance319RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance319RecordsParameterInnerStatusEnum>
_$hrStaffAttendance319RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance319RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance319RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance319RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance319RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance319RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance319RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance319RecordsParameterInnerStatusEnum>
_$hrStaffAttendance319RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance319RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance319RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance319RecordsParameterInnerStatusEnum
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
    HrStaffAttendance319RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance319RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance319RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance319RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance319RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance319RecordsParameterInner
    extends HrStaffAttendance319RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance319RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance319RecordsParameterInner([
    void Function(HrStaffAttendance319RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance319RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance319RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance319RecordsParameterInner rebuild(
    void Function(HrStaffAttendance319RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance319RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance319RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance319RecordsParameterInner &&
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
            r'HrStaffAttendance319RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance319RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance319RecordsParameterInner,
          HrStaffAttendance319RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance319RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance319RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance319RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance319RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance319RecordsParameterInnerBuilder() {
    HrStaffAttendance319RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance319RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance319RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance319RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance319RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance319RecordsParameterInner build() => _build();

  _$HrStaffAttendance319RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance319RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance319RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance319RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance319RecordsParameterInner',
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
