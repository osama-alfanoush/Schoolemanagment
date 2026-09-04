// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_review_request316_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrReviewRequest316RequestStatusEnum
_$hrReviewRequest316RequestStatusEnum_approved =
    const HrReviewRequest316RequestStatusEnum._('approved');
const HrReviewRequest316RequestStatusEnum
_$hrReviewRequest316RequestStatusEnum_rejected =
    const HrReviewRequest316RequestStatusEnum._('rejected');

HrReviewRequest316RequestStatusEnum
_$hrReviewRequest316RequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'approved':
      return _$hrReviewRequest316RequestStatusEnum_approved;
    case 'rejected':
      return _$hrReviewRequest316RequestStatusEnum_rejected;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrReviewRequest316RequestStatusEnum>
_$hrReviewRequest316RequestStatusEnumValues =
    BuiltSet<HrReviewRequest316RequestStatusEnum>(
      const <HrReviewRequest316RequestStatusEnum>[
        _$hrReviewRequest316RequestStatusEnum_approved,
        _$hrReviewRequest316RequestStatusEnum_rejected,
      ],
    );

Serializer<HrReviewRequest316RequestStatusEnum>
_$hrReviewRequest316RequestStatusEnumSerializer =
    _$HrReviewRequest316RequestStatusEnumSerializer();

class _$HrReviewRequest316RequestStatusEnumSerializer
    implements PrimitiveSerializer<HrReviewRequest316RequestStatusEnum> {
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
    HrReviewRequest316RequestStatusEnum,
  ];
  @override
  final String wireName = 'HrReviewRequest316RequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrReviewRequest316RequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrReviewRequest316RequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrReviewRequest316RequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrReviewRequest316Request extends HrReviewRequest316Request {
  @override
  final HrReviewRequest316RequestStatusEnum status;
  @override
  final String? response;
  @override
  final String? adminResponse;

  factory _$HrReviewRequest316Request([
    void Function(HrReviewRequest316RequestBuilder)? updates,
  ]) => (HrReviewRequest316RequestBuilder()..update(updates))._build();

  _$HrReviewRequest316Request._({
    required this.status,
    this.response,
    this.adminResponse,
  }) : super._();
  @override
  HrReviewRequest316Request rebuild(
    void Function(HrReviewRequest316RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrReviewRequest316RequestBuilder toBuilder() =>
      HrReviewRequest316RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrReviewRequest316Request &&
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
    return (newBuiltValueToStringHelper(r'HrReviewRequest316Request')
          ..add('status', status)
          ..add('response', response)
          ..add('adminResponse', adminResponse))
        .toString();
  }
}

class HrReviewRequest316RequestBuilder
    implements
        Builder<HrReviewRequest316Request, HrReviewRequest316RequestBuilder> {
  _$HrReviewRequest316Request? _$v;

  HrReviewRequest316RequestStatusEnum? _status;
  HrReviewRequest316RequestStatusEnum? get status => _$this._status;
  set status(HrReviewRequest316RequestStatusEnum? status) =>
      _$this._status = status;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  String? _adminResponse;
  String? get adminResponse => _$this._adminResponse;
  set adminResponse(String? adminResponse) =>
      _$this._adminResponse = adminResponse;

  HrReviewRequest316RequestBuilder() {
    HrReviewRequest316Request._defaults(this);
  }

  HrReviewRequest316RequestBuilder get _$this {
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
  void replace(HrReviewRequest316Request other) {
    _$v = other as _$HrReviewRequest316Request;
  }

  @override
  void update(void Function(HrReviewRequest316RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrReviewRequest316Request build() => _build();

  _$HrReviewRequest316Request _build() {
    final _$result =
        _$v ??
        _$HrReviewRequest316Request._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'HrReviewRequest316Request',
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
