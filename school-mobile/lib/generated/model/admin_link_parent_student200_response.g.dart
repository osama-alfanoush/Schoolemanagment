// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_link_parent_student200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminLinkParentStudent200ResponseMessageEnum
_$adminLinkParentStudent200ResponseMessageEnum_linked =
    const AdminLinkParentStudent200ResponseMessageEnum._('linked');

AdminLinkParentStudent200ResponseMessageEnum
_$adminLinkParentStudent200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'linked':
      return _$adminLinkParentStudent200ResponseMessageEnum_linked;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminLinkParentStudent200ResponseMessageEnum>
_$adminLinkParentStudent200ResponseMessageEnumValues =
    BuiltSet<AdminLinkParentStudent200ResponseMessageEnum>(
      const <AdminLinkParentStudent200ResponseMessageEnum>[
        _$adminLinkParentStudent200ResponseMessageEnum_linked,
      ],
    );

Serializer<AdminLinkParentStudent200ResponseMessageEnum>
_$adminLinkParentStudent200ResponseMessageEnumSerializer =
    _$AdminLinkParentStudent200ResponseMessageEnumSerializer();

class _$AdminLinkParentStudent200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<AdminLinkParentStudent200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'linked': 'Linked',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Linked': 'linked',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminLinkParentStudent200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AdminLinkParentStudent200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminLinkParentStudent200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminLinkParentStudent200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminLinkParentStudent200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminLinkParentStudent200Response
    extends AdminLinkParentStudent200Response {
  @override
  final AdminLinkParentStudent200ResponseMessageEnum message;

  factory _$AdminLinkParentStudent200Response([
    void Function(AdminLinkParentStudent200ResponseBuilder)? updates,
  ]) => (AdminLinkParentStudent200ResponseBuilder()..update(updates))._build();

  _$AdminLinkParentStudent200Response._({required this.message}) : super._();
  @override
  AdminLinkParentStudent200Response rebuild(
    void Function(AdminLinkParentStudent200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminLinkParentStudent200ResponseBuilder toBuilder() =>
      AdminLinkParentStudent200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminLinkParentStudent200Response &&
        message == other.message;
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
      r'AdminLinkParentStudent200Response',
    )..add('message', message)).toString();
  }
}

class AdminLinkParentStudent200ResponseBuilder
    implements
        Builder<
          AdminLinkParentStudent200Response,
          AdminLinkParentStudent200ResponseBuilder
        > {
  _$AdminLinkParentStudent200Response? _$v;

  AdminLinkParentStudent200ResponseMessageEnum? _message;
  AdminLinkParentStudent200ResponseMessageEnum? get message => _$this._message;
  set message(AdminLinkParentStudent200ResponseMessageEnum? message) =>
      _$this._message = message;

  AdminLinkParentStudent200ResponseBuilder() {
    AdminLinkParentStudent200Response._defaults(this);
  }

  AdminLinkParentStudent200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminLinkParentStudent200Response other) {
    _$v = other as _$AdminLinkParentStudent200Response;
  }

  @override
  void update(
    void Function(AdminLinkParentStudent200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminLinkParentStudent200Response build() => _build();

  _$AdminLinkParentStudent200Response _build() {
    final _$result =
        _$v ??
        _$AdminLinkParentStudent200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AdminLinkParentStudent200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
