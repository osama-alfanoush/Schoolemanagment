// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_update_application_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrUpdateApplicationStatusRequestStatusEnum
_$hrUpdateApplicationStatusRequestStatusEnum_new_ =
    const HrUpdateApplicationStatusRequestStatusEnum._('new_');
const HrUpdateApplicationStatusRequestStatusEnum
_$hrUpdateApplicationStatusRequestStatusEnum_reviewing =
    const HrUpdateApplicationStatusRequestStatusEnum._('reviewing');
const HrUpdateApplicationStatusRequestStatusEnum
_$hrUpdateApplicationStatusRequestStatusEnum_interviewed =
    const HrUpdateApplicationStatusRequestStatusEnum._('interviewed');
const HrUpdateApplicationStatusRequestStatusEnum
_$hrUpdateApplicationStatusRequestStatusEnum_accepted =
    const HrUpdateApplicationStatusRequestStatusEnum._('accepted');
const HrUpdateApplicationStatusRequestStatusEnum
_$hrUpdateApplicationStatusRequestStatusEnum_rejected =
    const HrUpdateApplicationStatusRequestStatusEnum._('rejected');

HrUpdateApplicationStatusRequestStatusEnum
_$hrUpdateApplicationStatusRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'new_':
      return _$hrUpdateApplicationStatusRequestStatusEnum_new_;
    case 'reviewing':
      return _$hrUpdateApplicationStatusRequestStatusEnum_reviewing;
    case 'interviewed':
      return _$hrUpdateApplicationStatusRequestStatusEnum_interviewed;
    case 'accepted':
      return _$hrUpdateApplicationStatusRequestStatusEnum_accepted;
    case 'rejected':
      return _$hrUpdateApplicationStatusRequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrUpdateApplicationStatusRequestStatusEnum>
_$hrUpdateApplicationStatusRequestStatusEnumValues =
    BuiltSet<HrUpdateApplicationStatusRequestStatusEnum>(
      const <HrUpdateApplicationStatusRequestStatusEnum>[
        _$hrUpdateApplicationStatusRequestStatusEnum_new_,
        _$hrUpdateApplicationStatusRequestStatusEnum_reviewing,
        _$hrUpdateApplicationStatusRequestStatusEnum_interviewed,
        _$hrUpdateApplicationStatusRequestStatusEnum_accepted,
        _$hrUpdateApplicationStatusRequestStatusEnum_rejected,
      ],
    );

Serializer<HrUpdateApplicationStatusRequestStatusEnum>
_$hrUpdateApplicationStatusRequestStatusEnumSerializer =
    _$HrUpdateApplicationStatusRequestStatusEnumSerializer();

class _$HrUpdateApplicationStatusRequestStatusEnumSerializer
    implements PrimitiveSerializer<HrUpdateApplicationStatusRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'new_': 'new',
    'reviewing': 'reviewing',
    'interviewed': 'interviewed',
    'accepted': 'accepted',
    'rejected': 'rejected',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'new': 'new_',
    'reviewing': 'reviewing',
    'interviewed': 'interviewed',
    'accepted': 'accepted',
    'rejected': 'rejected',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrUpdateApplicationStatusRequestStatusEnum,
  ];
  @override
  final String wireName = 'HrUpdateApplicationStatusRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrUpdateApplicationStatusRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrUpdateApplicationStatusRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrUpdateApplicationStatusRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrUpdateApplicationStatusRequest
    extends HrUpdateApplicationStatusRequest {
  @override
  final HrUpdateApplicationStatusRequestStatusEnum status;
  @override
  final String? notes;
  @override
  final DateTime? interviewDate;

  factory _$HrUpdateApplicationStatusRequest([
    void Function(HrUpdateApplicationStatusRequestBuilder)? updates,
  ]) => (HrUpdateApplicationStatusRequestBuilder()..update(updates))._build();

  _$HrUpdateApplicationStatusRequest._({
    required this.status,
    this.notes,
    this.interviewDate,
  }) : super._();
  @override
  HrUpdateApplicationStatusRequest rebuild(
    void Function(HrUpdateApplicationStatusRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrUpdateApplicationStatusRequestBuilder toBuilder() =>
      HrUpdateApplicationStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrUpdateApplicationStatusRequest &&
        status == other.status &&
        notes == other.notes &&
        interviewDate == other.interviewDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, interviewDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrUpdateApplicationStatusRequest')
          ..add('status', status)
          ..add('notes', notes)
          ..add('interviewDate', interviewDate))
        .toString();
  }
}

class HrUpdateApplicationStatusRequestBuilder
    implements
        Builder<
          HrUpdateApplicationStatusRequest,
          HrUpdateApplicationStatusRequestBuilder
        > {
  _$HrUpdateApplicationStatusRequest? _$v;

  HrUpdateApplicationStatusRequestStatusEnum? _status;
  HrUpdateApplicationStatusRequestStatusEnum? get status => _$this._status;
  set status(HrUpdateApplicationStatusRequestStatusEnum? status) =>
      _$this._status = status;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DateTime? _interviewDate;
  DateTime? get interviewDate => _$this._interviewDate;
  set interviewDate(DateTime? interviewDate) =>
      _$this._interviewDate = interviewDate;

  HrUpdateApplicationStatusRequestBuilder() {
    HrUpdateApplicationStatusRequest._defaults(this);
  }

  HrUpdateApplicationStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _notes = $v.notes;
      _interviewDate = $v.interviewDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrUpdateApplicationStatusRequest other) {
    _$v = other as _$HrUpdateApplicationStatusRequest;
  }

  @override
  void update(void Function(HrUpdateApplicationStatusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrUpdateApplicationStatusRequest build() => _build();

  _$HrUpdateApplicationStatusRequest _build() {
    final _$result =
        _$v ??
        _$HrUpdateApplicationStatusRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrUpdateApplicationStatusRequest',
            'status',
          ),
          notes: notes,
          interviewDate: interviewDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
