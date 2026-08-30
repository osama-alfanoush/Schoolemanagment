// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_review_hr_request403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminReviewHrRequest403ResponseMessageEnum
_$adminReviewHrRequest403ResponseMessageEnum_onlyHRCanReviewHRRequestsPeriod =
    const AdminReviewHrRequest403ResponseMessageEnum._(
      'onlyHRCanReviewHRRequestsPeriod',
    );

AdminReviewHrRequest403ResponseMessageEnum
_$adminReviewHrRequest403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'onlyHRCanReviewHRRequestsPeriod':
      return _$adminReviewHrRequest403ResponseMessageEnum_onlyHRCanReviewHRRequestsPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminReviewHrRequest403ResponseMessageEnum>
_$adminReviewHrRequest403ResponseMessageEnumValues =
    BuiltSet<AdminReviewHrRequest403ResponseMessageEnum>(const <
      AdminReviewHrRequest403ResponseMessageEnum
    >[
      _$adminReviewHrRequest403ResponseMessageEnum_onlyHRCanReviewHRRequestsPeriod,
    ]);

Serializer<AdminReviewHrRequest403ResponseMessageEnum>
_$adminReviewHrRequest403ResponseMessageEnumSerializer =
    _$AdminReviewHrRequest403ResponseMessageEnumSerializer();

class _$AdminReviewHrRequest403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<AdminReviewHrRequest403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'onlyHRCanReviewHRRequestsPeriod': 'Only HR can review HR requests.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Only HR can review HR requests.': 'onlyHRCanReviewHRRequestsPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminReviewHrRequest403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AdminReviewHrRequest403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminReviewHrRequest403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminReviewHrRequest403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminReviewHrRequest403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminReviewHrRequest403Response
    extends AdminReviewHrRequest403Response {
  @override
  final AdminReviewHrRequest403ResponseMessageEnum message;

  factory _$AdminReviewHrRequest403Response([
    void Function(AdminReviewHrRequest403ResponseBuilder)? updates,
  ]) => (AdminReviewHrRequest403ResponseBuilder()..update(updates))._build();

  _$AdminReviewHrRequest403Response._({required this.message}) : super._();
  @override
  AdminReviewHrRequest403Response rebuild(
    void Function(AdminReviewHrRequest403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminReviewHrRequest403ResponseBuilder toBuilder() =>
      AdminReviewHrRequest403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminReviewHrRequest403Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AdminReviewHrRequest403Response',
    )..add('message', message)).toString();
  }
}

class AdminReviewHrRequest403ResponseBuilder
    implements
        Builder<
          AdminReviewHrRequest403Response,
          AdminReviewHrRequest403ResponseBuilder
        > {
  _$AdminReviewHrRequest403Response? _$v;

  AdminReviewHrRequest403ResponseMessageEnum? _message;
  AdminReviewHrRequest403ResponseMessageEnum? get message => _$this._message;
  set message(AdminReviewHrRequest403ResponseMessageEnum? message) =>
      _$this._message = message;

  AdminReviewHrRequest403ResponseBuilder() {
    AdminReviewHrRequest403Response._defaults(this);
  }

  AdminReviewHrRequest403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminReviewHrRequest403Response other) {
    _$v = other as _$AdminReviewHrRequest403Response;
  }

  @override
  void update(void Function(AdminReviewHrRequest403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminReviewHrRequest403Response build() => _build();

  _$AdminReviewHrRequest403Response _build() {
    final _$result =
        _$v ??
        _$AdminReviewHrRequest403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AdminReviewHrRequest403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
