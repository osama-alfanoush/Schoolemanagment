// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request315_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest315RequestStatusEnum
_$hrReviewRequest315RequestStatusEnum_approved =
    const HrReviewRequest315RequestStatusEnum._('approved');
const HrReviewRequest315RequestStatusEnum
_$hrReviewRequest315RequestStatusEnum_rejected =
    const HrReviewRequest315RequestStatusEnum._('rejected');

HrReviewRequest315RequestStatusEnum
_$hrReviewRequest315RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest315RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest315RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest315RequestStatusEnum>
_$hrReviewRequest315RequestStatusEnumValues =
    BuiltSet<HrReviewRequest315RequestStatusEnum>(
      const <HrReviewRequest315RequestStatusEnum>[
        _$hrReviewRequest315RequestStatusEnum_approved,
        _$hrReviewRequest315RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest315RequestStatusEnum>
_$hrReviewRequest315RequestStatusEnumSerializer =
    _$HrReviewRequest315RequestStatusEnumSerializer();

class _$HrReviewRequest315RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest315RequestStatusEnum> {
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
    HrReviewRequest315RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest315RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest315RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest315RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest315RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest315Request extends HrReviewRequest315Request {
  @override
  final HrReviewRequest315RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest315Request([
    void Function(HrReviewRequest315RequestBuilder)? updates,
  ]) => (HrReviewRequest315RequestBuilder()..update(updates))._build();

  _$HrReviewRequest315Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest315Request rebuild(
    void Function(HrReviewRequest315RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest315RequestBuilder toBuilder() =>
      HrReviewRequest315RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest315Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest315Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest315RequestBuilder
    implements
        Builder<HrReviewRequest315Request, HrReviewRequest315RequestBuilder> {
  _$HrReviewRequest315Request? _$v;

  HrReviewRequest315RequestStatusEnum? _status;
  HrReviewRequest315RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest315RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest315RequestBuilder() {
    HrReviewRequest315Request._defaults(this);
  }

  HrReviewRequest315RequestBuilder get _$this {
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
  void replace(HrReviewRequest315Request other) {
    _$v = other as _$HrReviewRequest315Request;
  }

  @override
  void update(void Function(HrReviewRequest315RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest315Request build() => _build();

  _$HrReviewRequest315Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest315Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest315Request',
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
