// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request318_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest318RequestStatusEnum
_$hrReviewRequest318RequestStatusEnum_approved =
    const HrReviewRequest318RequestStatusEnum._('approved');
const HrReviewRequest318RequestStatusEnum
_$hrReviewRequest318RequestStatusEnum_rejected =
    const HrReviewRequest318RequestStatusEnum._('rejected');

HrReviewRequest318RequestStatusEnum
_$hrReviewRequest318RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest318RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest318RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest318RequestStatusEnum>
_$hrReviewRequest318RequestStatusEnumValues =
    BuiltSet<HrReviewRequest318RequestStatusEnum>(
      const <HrReviewRequest318RequestStatusEnum>[
        _$hrReviewRequest318RequestStatusEnum_approved,
        _$hrReviewRequest318RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest318RequestStatusEnum>
_$hrReviewRequest318RequestStatusEnumSerializer =
    _$HrReviewRequest318RequestStatusEnumSerializer();

class _$HrReviewRequest318RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest318RequestStatusEnum> {
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
    HrReviewRequest318RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest318RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest318RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest318RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest318RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest318Request extends HrReviewRequest318Request {
  @override
  final HrReviewRequest318RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest318Request([
    void Function(HrReviewRequest318RequestBuilder)? updates,
  ]) => (HrReviewRequest318RequestBuilder()..update(updates))._build();

  _$HrReviewRequest318Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest318Request rebuild(
    void Function(HrReviewRequest318RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest318RequestBuilder toBuilder() =>
      HrReviewRequest318RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest318Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest318Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest318RequestBuilder
    implements
        Builder<HrReviewRequest318Request, HrReviewRequest318RequestBuilder> {
  _$HrReviewRequest318Request? _$v;

  HrReviewRequest318RequestStatusEnum? _status;
  HrReviewRequest318RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest318RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest318RequestBuilder() {
    HrReviewRequest318Request._defaults(this);
  }

  HrReviewRequest318RequestBuilder get _$this {
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
  void replace(HrReviewRequest318Request other) {
    _$v = other as _$HrReviewRequest318Request;
  }

  @override
  void update(void Function(HrReviewRequest318RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest318Request build() => _build();

  _$HrReviewRequest318Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest318Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest318Request',
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
