// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request332_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest332RequestStatusEnum
_$hrReviewRequest332RequestStatusEnum_approved =
    const HrReviewRequest332RequestStatusEnum._('approved');
const HrReviewRequest332RequestStatusEnum
_$hrReviewRequest332RequestStatusEnum_rejected =
    const HrReviewRequest332RequestStatusEnum._('rejected');

HrReviewRequest332RequestStatusEnum
_$hrReviewRequest332RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest332RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest332RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest332RequestStatusEnum>
_$hrReviewRequest332RequestStatusEnumValues =
    BuiltSet<HrReviewRequest332RequestStatusEnum>(
      const <HrReviewRequest332RequestStatusEnum>[
        _$hrReviewRequest332RequestStatusEnum_approved,
        _$hrReviewRequest332RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest332RequestStatusEnum>
_$hrReviewRequest332RequestStatusEnumSerializer =
    _$HrReviewRequest332RequestStatusEnumSerializer();

class _$HrReviewRequest332RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest332RequestStatusEnum> {
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
    HrReviewRequest332RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest332RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest332RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest332RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest332RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest332Request extends HrReviewRequest332Request {
  @override
  final HrReviewRequest332RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest332Request([
    void Function(HrReviewRequest332RequestBuilder)? updates,
  ]) => (HrReviewRequest332RequestBuilder()..update(updates))._build();

  _$HrReviewRequest332Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest332Request rebuild(
    void Function(HrReviewRequest332RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest332RequestBuilder toBuilder() =>
      HrReviewRequest332RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest332Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest332Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest332RequestBuilder
    implements
        Builder<HrReviewRequest332Request, HrReviewRequest332RequestBuilder> {
  _$HrReviewRequest332Request? _$v;

  HrReviewRequest332RequestStatusEnum? _status;
  HrReviewRequest332RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest332RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest332RequestBuilder() {
    HrReviewRequest332Request._defaults(this);
  }

  HrReviewRequest332RequestBuilder get _$this {
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
  void replace(HrReviewRequest332Request other) {
    _$v = other as _$HrReviewRequest332Request;
  }

  @override
  void update(void Function(HrReviewRequest332RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest332Request build() => _build();

  _$HrReviewRequest332Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest332Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest332Request',
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
