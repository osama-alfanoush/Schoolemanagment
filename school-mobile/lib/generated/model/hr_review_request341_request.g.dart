// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request341_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest341RequestStatusEnum
_$hrReviewRequest341RequestStatusEnum_approved =
    const HrReviewRequest341RequestStatusEnum._('approved');
const HrReviewRequest341RequestStatusEnum
_$hrReviewRequest341RequestStatusEnum_rejected =
    const HrReviewRequest341RequestStatusEnum._('rejected');

HrReviewRequest341RequestStatusEnum
_$hrReviewRequest341RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest341RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest341RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest341RequestStatusEnum>
_$hrReviewRequest341RequestStatusEnumValues =
    BuiltSet<HrReviewRequest341RequestStatusEnum>(
      const <HrReviewRequest341RequestStatusEnum>[
        _$hrReviewRequest341RequestStatusEnum_approved,
        _$hrReviewRequest341RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest341RequestStatusEnum>
_$hrReviewRequest341RequestStatusEnumSerializer =
    _$HrReviewRequest341RequestStatusEnumSerializer();

class _$HrReviewRequest341RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest341RequestStatusEnum> {
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
    HrReviewRequest341RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest341RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest341RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest341RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest341RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest341Request extends HrReviewRequest341Request {
  @override
  final HrReviewRequest341RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest341Request([
    void Function(HrReviewRequest341RequestBuilder)? updates,
  ]) => (HrReviewRequest341RequestBuilder()..update(updates))._build();

  _$HrReviewRequest341Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest341Request rebuild(
    void Function(HrReviewRequest341RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest341RequestBuilder toBuilder() =>
      HrReviewRequest341RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest341Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest341Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest341RequestBuilder
    implements
        Builder<HrReviewRequest341Request, HrReviewRequest341RequestBuilder> {
  _$HrReviewRequest341Request? _$v;

  HrReviewRequest341RequestStatusEnum? _status;
  HrReviewRequest341RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest341RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest341RequestBuilder() {
    HrReviewRequest341Request._defaults(this);
  }

  HrReviewRequest341RequestBuilder get _$this {
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
  void replace(HrReviewRequest341Request other) {
    _$v = other as _$HrReviewRequest341Request;
  }

  @override
  void update(void Function(HrReviewRequest341RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest341Request build() => _build();

  _$HrReviewRequest341Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest341Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest341Request',
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
