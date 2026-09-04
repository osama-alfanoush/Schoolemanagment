// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request327_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest327RequestStatusEnum
_$hrReviewRequest327RequestStatusEnum_approved =
    const HrReviewRequest327RequestStatusEnum._('approved');
const HrReviewRequest327RequestStatusEnum
_$hrReviewRequest327RequestStatusEnum_rejected =
    const HrReviewRequest327RequestStatusEnum._('rejected');

HrReviewRequest327RequestStatusEnum
_$hrReviewRequest327RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest327RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest327RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest327RequestStatusEnum>
_$hrReviewRequest327RequestStatusEnumValues =
    BuiltSet<HrReviewRequest327RequestStatusEnum>(
      const <HrReviewRequest327RequestStatusEnum>[
        _$hrReviewRequest327RequestStatusEnum_approved,
        _$hrReviewRequest327RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest327RequestStatusEnum>
_$hrReviewRequest327RequestStatusEnumSerializer =
    _$HrReviewRequest327RequestStatusEnumSerializer();

class _$HrReviewRequest327RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest327RequestStatusEnum> {
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
    HrReviewRequest327RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest327RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest327RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest327RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest327RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest327Request extends HrReviewRequest327Request {
  @override
  final HrReviewRequest327RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest327Request([
    void Function(HrReviewRequest327RequestBuilder)? updates,
  ]) => (HrReviewRequest327RequestBuilder()..update(updates))._build();

  _$HrReviewRequest327Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest327Request rebuild(
    void Function(HrReviewRequest327RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest327RequestBuilder toBuilder() =>
      HrReviewRequest327RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest327Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest327Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest327RequestBuilder
    implements
        Builder<HrReviewRequest327Request, HrReviewRequest327RequestBuilder> {
  _$HrReviewRequest327Request? _$v;

  HrReviewRequest327RequestStatusEnum? _status;
  HrReviewRequest327RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest327RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest327RequestBuilder() {
    HrReviewRequest327Request._defaults(this);
  }

  HrReviewRequest327RequestBuilder get _$this {
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
  void replace(HrReviewRequest327Request other) {
    _$v = other as _$HrReviewRequest327Request;
  }

  @override
  void update(void Function(HrReviewRequest327RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest327Request build() => _build();

  _$HrReviewRequest327Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest327Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest327Request',
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
