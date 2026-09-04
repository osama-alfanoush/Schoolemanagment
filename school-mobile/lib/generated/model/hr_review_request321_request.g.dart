// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request321_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest321RequestStatusEnum
_$hrReviewRequest321RequestStatusEnum_approved =
    const HrReviewRequest321RequestStatusEnum._('approved');
const HrReviewRequest321RequestStatusEnum
_$hrReviewRequest321RequestStatusEnum_rejected =
    const HrReviewRequest321RequestStatusEnum._('rejected');

HrReviewRequest321RequestStatusEnum
_$hrReviewRequest321RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest321RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest321RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest321RequestStatusEnum>
_$hrReviewRequest321RequestStatusEnumValues =
    BuiltSet<HrReviewRequest321RequestStatusEnum>(
      const <HrReviewRequest321RequestStatusEnum>[
        _$hrReviewRequest321RequestStatusEnum_approved,
        _$hrReviewRequest321RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest321RequestStatusEnum>
_$hrReviewRequest321RequestStatusEnumSerializer =
    _$HrReviewRequest321RequestStatusEnumSerializer();

class _$HrReviewRequest321RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest321RequestStatusEnum> {
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
    HrReviewRequest321RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest321RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest321RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest321RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest321RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest321Request extends HrReviewRequest321Request {
  @override
  final HrReviewRequest321RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest321Request([
    void Function(HrReviewRequest321RequestBuilder)? updates,
  ]) => (HrReviewRequest321RequestBuilder()..update(updates))._build();

  _$HrReviewRequest321Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest321Request rebuild(
    void Function(HrReviewRequest321RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest321RequestBuilder toBuilder() =>
      HrReviewRequest321RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest321Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest321Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest321RequestBuilder
    implements
        Builder<HrReviewRequest321Request, HrReviewRequest321RequestBuilder> {
  _$HrReviewRequest321Request? _$v;

  HrReviewRequest321RequestStatusEnum? _status;
  HrReviewRequest321RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest321RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest321RequestBuilder() {
    HrReviewRequest321Request._defaults(this);
  }

  HrReviewRequest321RequestBuilder get _$this {
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
  void replace(HrReviewRequest321Request other) {
    _$v = other as _$HrReviewRequest321Request;
  }

  @override
  void update(void Function(HrReviewRequest321RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest321Request build() => _build();

  _$HrReviewRequest321Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest321Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest321Request',
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
