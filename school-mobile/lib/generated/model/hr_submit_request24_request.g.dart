// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_submit_request24_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrSubmitRequest24RequestTypeEnum
_$hrSubmitRequest24RequestTypeEnum_leaveSick =
    const HrSubmitRequest24RequestTypeEnum._('leaveSick');
const HrSubmitRequest24RequestTypeEnum
_$hrSubmitRequest24RequestTypeEnum_leaveAnnual =
    const HrSubmitRequest24RequestTypeEnum._('leaveAnnual');
const HrSubmitRequest24RequestTypeEnum
_$hrSubmitRequest24RequestTypeEnum_leaveEmergency =
    const HrSubmitRequest24RequestTypeEnum._('leaveEmergency');
const HrSubmitRequest24RequestTypeEnum
_$hrSubmitRequest24RequestTypeEnum_salaryAdvance =
    const HrSubmitRequest24RequestTypeEnum._('salaryAdvance');
const HrSubmitRequest24RequestTypeEnum
_$hrSubmitRequest24RequestTypeEnum_general =
    const HrSubmitRequest24RequestTypeEnum._('general');

HrSubmitRequest24RequestTypeEnum _$hrSubmitRequest24RequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'leaveSick':
      return _$hrSubmitRequest24RequestTypeEnum_leaveSick;
    case 'leaveAnnual':
      return _$hrSubmitRequest24RequestTypeEnum_leaveAnnual;
    case 'leaveEmergency':
      return _$hrSubmitRequest24RequestTypeEnum_leaveEmergency;
    case 'salaryAdvance':
      return _$hrSubmitRequest24RequestTypeEnum_salaryAdvance;
    case 'general':
      return _$hrSubmitRequest24RequestTypeEnum_general;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrSubmitRequest24RequestTypeEnum>
_$hrSubmitRequest24RequestTypeEnumValues =
    BuiltSet<HrSubmitRequest24RequestTypeEnum>(
      const <HrSubmitRequest24RequestTypeEnum>[
        _$hrSubmitRequest24RequestTypeEnum_leaveSick,
        _$hrSubmitRequest24RequestTypeEnum_leaveAnnual,
        _$hrSubmitRequest24RequestTypeEnum_leaveEmergency,
        _$hrSubmitRequest24RequestTypeEnum_salaryAdvance,
        _$hrSubmitRequest24RequestTypeEnum_general,
      ],
    );

Serializer<HrSubmitRequest24RequestTypeEnum>
_$hrSubmitRequest24RequestTypeEnumSerializer =
    _$HrSubmitRequest24RequestTypeEnumSerializer();

class _$HrSubmitRequest24RequestTypeEnumSerializer
    implements PrimitiveSerializer<HrSubmitRequest24RequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'leaveSick': 'leave_sick',
    'leaveAnnual': 'leave_annual',
    'leaveEmergency': 'leave_emergency',
    'salaryAdvance': 'salary_advance',
    'general': 'general',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'leave_sick': 'leaveSick',
    'leave_annual': 'leaveAnnual',
    'leave_emergency': 'leaveEmergency',
    'salary_advance': 'salaryAdvance',
    'general': 'general',
  };

  @override
  final Iterable<Type> types = const <Type>[HrSubmitRequest24RequestTypeEnum];
  @override
  final String wireName = 'HrSubmitRequest24RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest24RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrSubmitRequest24RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrSubmitRequest24RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrSubmitRequest24Request extends HrSubmitRequest24Request {
  @override
  final HrSubmitRequest24RequestTypeEnum type;
  @override
  final String subject;
  @override
  final String reason;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final num? amount;

  factory _$HrSubmitRequest24Request([
    void Function(HrSubmitRequest24RequestBuilder)? updates,
  ]) => (HrSubmitRequest24RequestBuilder()..update(updates))._build();

  _$HrSubmitRequest24Request._({
    required this.type,
    required this.subject,
    required this.reason,
    this.startDate,
    this.endDate,
    this.amount,
  }) : super._();
  @override
  HrSubmitRequest24Request rebuild(
    void Function(HrSubmitRequest24RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrSubmitRequest24RequestBuilder toBuilder() =>
      HrSubmitRequest24RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrSubmitRequest24Request &&
        type == other.type &&
        subject == other.subject &&
        reason == other.reason &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrSubmitRequest24Request')
          ..add('type', type)
          ..add('subject', subject)
          ..add('reason', reason)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('amount', amount))
        .toString();
  }
}

class HrSubmitRequest24RequestBuilder
    implements
        Builder<HrSubmitRequest24Request, HrSubmitRequest24RequestBuilder> {
  _$HrSubmitRequest24Request? _$v;

  HrSubmitRequest24RequestTypeEnum? _type;
  HrSubmitRequest24RequestTypeEnum? get type => _$this._type;
  set type(HrSubmitRequest24RequestTypeEnum? type) => _$this._type = type;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  HrSubmitRequest24RequestBuilder() {
    HrSubmitRequest24Request._defaults(this);
  }

  HrSubmitRequest24RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _subject = $v.subject;
      _reason = $v.reason;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrSubmitRequest24Request other) {
    _$v = other as _$HrSubmitRequest24Request;
  }

  @override
  void update(void Function(HrSubmitRequest24RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrSubmitRequest24Request build() => _build();

  _$HrSubmitRequest24Request _build() {
    final _$result =
        _$v ??
        _$HrSubmitRequest24Request._(
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'HrSubmitRequest24Request',
            'type',
          ),
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'HrSubmitRequest24Request',
            'subject',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'HrSubmitRequest24Request',
            'reason',
          ),
          startDate: startDate,
          endDate: endDate,
          amount: amount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
