// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance322_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance322RecordsParameterInnerStatusEnum
_$hrStaffAttendance322RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance322RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance322RecordsParameterInnerStatusEnum
_$hrStaffAttendance322RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance322RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance322RecordsParameterInnerStatusEnum
_$hrStaffAttendance322RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance322RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance322RecordsParameterInnerStatusEnum
_$hrStaffAttendance322RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance322RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance322RecordsParameterInnerStatusEnum
_$hrStaffAttendance322RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance322RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance322RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance322RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance322RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance322RecordsParameterInnerStatusEnum>
_$hrStaffAttendance322RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance322RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance322RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance322RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance322RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance322RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance322RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance322RecordsParameterInnerStatusEnum>
_$hrStaffAttendance322RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance322RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance322RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance322RecordsParameterInnerStatusEnum
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
    HrStaffAttendance322RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance322RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance322RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance322RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance322RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance322RecordsParameterInner
    extends HrStaffAttendance322RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance322RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance322RecordsParameterInner([
    void Function(HrStaffAttendance322RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance322RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance322RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance322RecordsParameterInner rebuild(
    void Function(HrStaffAttendance322RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance322RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance322RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance322RecordsParameterInner &&
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
            r'HrStaffAttendance322RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance322RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance322RecordsParameterInner,
          HrStaffAttendance322RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance322RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance322RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance322RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance322RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance322RecordsParameterInnerBuilder() {
    HrStaffAttendance322RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance322RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance322RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance322RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance322RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance322RecordsParameterInner build() => _build();

  _$HrStaffAttendance322RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance322RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance322RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance322RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance322RecordsParameterInner',
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
