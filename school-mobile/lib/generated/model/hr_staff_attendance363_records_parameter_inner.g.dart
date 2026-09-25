// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance363_records_parameter_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance363RecordsParameterInnerStatusEnum
_$hrStaffAttendance363RecordsParameterInnerStatusEnum_present =
    const HrStaffAttendance363RecordsParameterInnerStatusEnum._('present');
const HrStaffAttendance363RecordsParameterInnerStatusEnum
_$hrStaffAttendance363RecordsParameterInnerStatusEnum_absent =
    const HrStaffAttendance363RecordsParameterInnerStatusEnum._('absent');
const HrStaffAttendance363RecordsParameterInnerStatusEnum
_$hrStaffAttendance363RecordsParameterInnerStatusEnum_late_ =
    const HrStaffAttendance363RecordsParameterInnerStatusEnum._('late_');
const HrStaffAttendance363RecordsParameterInnerStatusEnum
_$hrStaffAttendance363RecordsParameterInnerStatusEnum_leave =
    const HrStaffAttendance363RecordsParameterInnerStatusEnum._('leave');

HrStaffAttendance363RecordsParameterInnerStatusEnum
_$hrStaffAttendance363RecordsParameterInnerStatusEnumValueOf(String name) {
  switch (name) {
    case 'present':
      return _$hrStaffAttendance363RecordsParameterInnerStatusEnum_present;
    case 'absent':
      return _$hrStaffAttendance363RecordsParameterInnerStatusEnum_absent;
    case 'late_':
      return _$hrStaffAttendance363RecordsParameterInnerStatusEnum_late_;
    case 'leave':
      return _$hrStaffAttendance363RecordsParameterInnerStatusEnum_leave;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance363RecordsParameterInnerStatusEnum>
_$hrStaffAttendance363RecordsParameterInnerStatusEnumValues =
    BuiltSet<HrStaffAttendance363RecordsParameterInnerStatusEnum>(
      const <HrStaffAttendance363RecordsParameterInnerStatusEnum>[
        _$hrStaffAttendance363RecordsParameterInnerStatusEnum_present,
        _$hrStaffAttendance363RecordsParameterInnerStatusEnum_absent,
        _$hrStaffAttendance363RecordsParameterInnerStatusEnum_late_,
        _$hrStaffAttendance363RecordsParameterInnerStatusEnum_leave,
      ],
    );

Serializer<HrStaffAttendance363RecordsParameterInnerStatusEnum>
_$hrStaffAttendance363RecordsParameterInnerStatusEnumSerializer =
    _$HrStaffAttendance363RecordsParameterInnerStatusEnumSerializer();

class _$HrStaffAttendance363RecordsParameterInnerStatusEnumSerializer
    implements
        PrimitiveSerializer<
          HrStaffAttendance363RecordsParameterInnerStatusEnum
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
    HrStaffAttendance363RecordsParameterInnerStatusEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance363RecordsParameterInnerStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance363RecordsParameterInnerStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance363RecordsParameterInnerStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance363RecordsParameterInnerStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance363RecordsParameterInner
    extends HrStaffAttendance363RecordsParameterInner {
  @override
  final int staffUserId;
  @override
  final DateTime date;
  @override
  final HrStaffAttendance363RecordsParameterInnerStatusEnum status;
  @override
  final String? checkIn;
  @override
  final String? checkOut;

  factory _$HrStaffAttendance363RecordsParameterInner([
    void Function(HrStaffAttendance363RecordsParameterInnerBuilder)? updates,
  ]) => (HrStaffAttendance363RecordsParameterInnerBuilder()..update(updates))
      ._build();

  _$HrStaffAttendance363RecordsParameterInner._({
    required this.staffUserId,
    required this.date,
    required this.status,
    this.checkIn,
    this.checkOut,
  }) : super._();
  @override
  HrStaffAttendance363RecordsParameterInner rebuild(
    void Function(HrStaffAttendance363RecordsParameterInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance363RecordsParameterInnerBuilder toBuilder() =>
      HrStaffAttendance363RecordsParameterInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance363RecordsParameterInner &&
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
            r'HrStaffAttendance363RecordsParameterInner',
          )
          ..add('staffUserId', staffUserId)
          ..add('date', date)
          ..add('status', status)
          ..add('checkIn', checkIn)
          ..add('checkOut', checkOut))
        .toString();
  }
}

class HrStaffAttendance363RecordsParameterInnerBuilder
    implements
        Builder<
          HrStaffAttendance363RecordsParameterInner,
          HrStaffAttendance363RecordsParameterInnerBuilder
        > {
  _$HrStaffAttendance363RecordsParameterInner? _$v;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  HrStaffAttendance363RecordsParameterInnerStatusEnum? _status;
  HrStaffAttendance363RecordsParameterInnerStatusEnum? get status =>
      _$this._status;
  set status(HrStaffAttendance363RecordsParameterInnerStatusEnum? status) =>
      _$this._status = status;

  String? _checkIn;
  String? get checkIn => _$this._checkIn;
  set checkIn(String? checkIn) => _$this._checkIn = checkIn;

  String? _checkOut;
  String? get checkOut => _$this._checkOut;
  set checkOut(String? checkOut) => _$this._checkOut = checkOut;

  HrStaffAttendance363RecordsParameterInnerBuilder() {
    HrStaffAttendance363RecordsParameterInner._defaults(this);
  }

  HrStaffAttendance363RecordsParameterInnerBuilder get _$this {
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
  void replace(HrStaffAttendance363RecordsParameterInner other) {
    _$v = other as _$HrStaffAttendance363RecordsParameterInner;
  }

  @override
  void update(
    void Function(HrStaffAttendance363RecordsParameterInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance363RecordsParameterInner build() => _build();

  _$HrStaffAttendance363RecordsParameterInner _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance363RecordsParameterInner._(
          staffUserId: BuiltValueNullFieldError.checkNotNull(
            staffUserId,
            r'HrStaffAttendance363RecordsParameterInner',
            'staffUserId',
          ),
          date: BuiltValueNullFieldError.checkNotNull(
            date,
            r'HrStaffAttendance363RecordsParameterInner',
            'date',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrStaffAttendance363RecordsParameterInner',
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
