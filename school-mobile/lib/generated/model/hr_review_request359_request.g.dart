// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request359_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest359RequestStatusEnum
_$hrReviewRequest359RequestStatusEnum_approved =
    const HrReviewRequest359RequestStatusEnum._('approved');
const HrReviewRequest359RequestStatusEnum
_$hrReviewRequest359RequestStatusEnum_rejected =
    const HrReviewRequest359RequestStatusEnum._('rejected');

HrReviewRequest359RequestStatusEnum
_$hrReviewRequest359RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest359RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest359RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest359RequestStatusEnum>
_$hrReviewRequest359RequestStatusEnumValues =
    BuiltSet<HrReviewRequest359RequestStatusEnum>(
      const <HrReviewRequest359RequestStatusEnum>[
        _$hrReviewRequest359RequestStatusEnum_approved,
        _$hrReviewRequest359RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest359RequestStatusEnum>
_$hrReviewRequest359RequestStatusEnumSerializer =
    _$HrReviewRequest359RequestStatusEnumSerializer();

class _$HrReviewRequest359RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest359RequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'approved': 'approved',
    'rejected': 'rejected',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'approved': 'approved',
    'rejected': 'rejected',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrReviewRequest359RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest359RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest359RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest359RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest359RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest359Request extends HrReviewRequest359Request {
  @override
  final HrReviewRequest359RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest359Request([
    void Function(HrReviewRequest359RequestBuilder)? updates,
  ]) => (HrReviewRequest359RequestBuilder()..update(updates))._build();

  _$HrReviewRequest359Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest359Request rebuild(
    void Function(HrReviewRequest359RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest359RequestBuilder toBuilder() =>
      HrReviewRequest359RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest359Request &&
        status == other.status &&
        response == other.response &&
        adminResponse == other.adminResponse;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, response.hashCode);
    _$hash = $jc(_$hash, adminResponse.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrReviewRequest359Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest359RequestBuilder
    implements
        Builder<HrReviewRequest359Request, HrReviewRequest359RequestBuilder> {
  _$HrReviewRequest359Request? _$v;

  HrReviewRequest359RequestStatusEnum? _status;
  HrReviewRequest359RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest359RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest359RequestBuilder() {
    HrReviewRequest359Request._defaults(this);
  }

  HrReviewRequest359RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _response = $v.response;
      _adminResponse = $v.adminResponse;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrReviewRequest359Request other) {
    _$v = other as _$HrReviewRequest359Request;
  }

  @override
  void update(void Function(HrReviewRequest359RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest359Request build() => _build();

  _$HrReviewRequest359Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest359Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest359Request',
            'status',
          ),
          response: response,
          adminResponse: adminResponse,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
