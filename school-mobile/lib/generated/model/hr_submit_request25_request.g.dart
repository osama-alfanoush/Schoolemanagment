// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_submit_request25_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrSubmitRequest25RequestTypeEnum
_$hrSubmitRequest25RequestTypeEnum_leaveSick =
    const HrSubmitRequest25RequestTypeEnum._('leaveSick');
const HrSubmitRequest25RequestTypeEnum
_$hrSubmitRequest25RequestTypeEnum_leaveAnnual =
    const HrSubmitRequest25RequestTypeEnum._('leaveAnnual');
const HrSubmitRequest25RequestTypeEnum
_$hrSubmitRequest25RequestTypeEnum_leaveEmergency =
    const HrSubmitRequest25RequestTypeEnum._('leaveEmergency');
const HrSubmitRequest25RequestTypeEnum
_$hrSubmitRequest25RequestTypeEnum_salaryAdvance =
    const HrSubmitRequest25RequestTypeEnum._('salaryAdvance');
const HrSubmitRequest25RequestTypeEnum
_$hrSubmitRequest25RequestTypeEnum_general =
    const HrSubmitRequest25RequestTypeEnum._('general');

HrSubmitRequest25RequestTypeEnum _$hrSubmitRequest25RequestTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'leaveSick':
      return _$hrSubmitRequest25RequestTypeEnum_leaveSick;
    case 'leaveAnnual':
      return _$hrSubmitRequest25RequestTypeEnum_leaveAnnual;
    case 'leaveEmergency':
      return _$hrSubmitRequest25RequestTypeEnum_leaveEmergency;
    case 'salaryAdvance':
      return _$hrSubmitRequest25RequestTypeEnum_salaryAdvance;
    case 'general':
      return _$hrSubmitRequest25RequestTypeEnum_general;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrSubmitRequest25RequestTypeEnum>
_$hrSubmitRequest25RequestTypeEnumValues =
    BuiltSet<HrSubmitRequest25RequestTypeEnum>(
      const <HrSubmitRequest25RequestTypeEnum>[
        _$hrSubmitRequest25RequestTypeEnum_leaveSick,
        _$hrSubmitRequest25RequestTypeEnum_leaveAnnual,
        _$hrSubmitRequest25RequestTypeEnum_leaveEmergency,
        _$hrSubmitRequest25RequestTypeEnum_salaryAdvance,
        _$hrSubmitRequest25RequestTypeEnum_general,
      ],
    );

Serializer<HrSubmitRequest25RequestTypeEnum>
_$hrSubmitRequest25RequestTypeEnumSerializer =
    _$HrSubmitRequest25RequestTypeEnumSerializer();

class _$HrSubmitRequest25RequestTypeEnumSerializer
    implements PrimitiveSerializer<HrSubmitRequest25RequestTypeEnum> {
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
  final Iterable<Type> types = const <Type>[HrSubmitRequest25RequestTypeEnum];
  @override
  final String wireName = 'HrSubmitRequest25RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest25RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrSubmitRequest25RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrSubmitRequest25RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrSubmitRequest25Request extends HrSubmitRequest25Request {
  @override
  final HrSubmitRequest25RequestTypeEnum type;
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

  factory _$HrSubmitRequest25Request([
    void Function(HrSubmitRequest25RequestBuilder)? updates,
  ]) => (HrSubmitRequest25RequestBuilder()..update(updates))._build();

  _$HrSubmitRequest25Request._({
    required this.type,
    required this.subject,
    required this.reason,
    this.startDate,
    this.endDate,
    this.amount,
  }) : super._();
  @override
  HrSubmitRequest25Request rebuild(
    void Function(HrSubmitRequest25RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrSubmitRequest25RequestBuilder toBuilder() =>
      HrSubmitRequest25RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrSubmitRequest25Request &&
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
    return (newBuiltValueToStringHelper(r'HrSubmitRequest25Request')
          ..add('type', type)
          ..add('subject', subject)
          ..add('reason', reason)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('amount', amount))
        .toString();
  }
}

class HrSubmitRequest25RequestBuilder
    implements
        Builder<HrSubmitRequest25Request, HrSubmitRequest25RequestBuilder> {
  _$HrSubmitRequest25Request? _$v;

  HrSubmitRequest25RequestTypeEnum? _type;
  HrSubmitRequest25RequestTypeEnum? get type => _$this._type;
  set type(HrSubmitRequest25RequestTypeEnum? type) => _$this._type = type;

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

  HrSubmitRequest25RequestBuilder() {
    HrSubmitRequest25Request._defaults(this);
  }

  HrSubmitRequest25RequestBuilder get _$this {
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
  void replace(HrSubmitRequest25Request other) {
    _$v = other as _$HrSubmitRequest25Request;
  }

  @override
  void update(void Function(HrSubmitRequest25RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrSubmitRequest25Request build() => _build();

  _$HrSubmitRequest25Request _build() {
    final _$result =
        _$v ??
        _$HrSubmitRequest25Request._(
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'HrSubmitRequest25Request',
            'type',
          ),
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'HrSubmitRequest25Request',
            'subject',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'HrSubmitRequest25Request',
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
