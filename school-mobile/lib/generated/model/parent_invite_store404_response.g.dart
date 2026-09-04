// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_store404_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentInviteStore404ResponseMessageEnum
_$parentInviteStore404ResponseMessageEnum_guardianNotFoundPeriod =
    const ParentInviteStore404ResponseMessageEnum._('guardianNotFoundPeriod');

ParentInviteStore404ResponseMessageEnum
_$parentInviteStore404ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'guardianNotFoundPeriod':
      return _$parentInviteStore404ResponseMessageEnum_guardianNotFoundPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentInviteStore404ResponseMessageEnum>
_$parentInviteStore404ResponseMessageEnumValues =
    BuiltSet<ParentInviteStore404ResponseMessageEnum>(
      const <ParentInviteStore404ResponseMessageEnum>[
        _$parentInviteStore404ResponseMessageEnum_guardianNotFoundPeriod,
      ],
    );

Serializer<ParentInviteStore404ResponseMessageEnum>
_$parentInviteStore404ResponseMessageEnumSerializer =
    _$ParentInviteStore404ResponseMessageEnumSerializer();

class _$ParentInviteStore404ResponseMessageEnumSerializer
    implements PrimitiveSerializer<ParentInviteStore404ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'guardianNotFoundPeriod': 'Guardian not found.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Guardian not found.': 'guardianNotFoundPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentInviteStore404ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentInviteStore404ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteStore404ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentInviteStore404ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentInviteStore404ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentInviteStore404Response extends ParentInviteStore404Response {
  @override
  final ParentInviteStore404ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentInviteStore404Response([
    void Function(ParentInviteStore404ResponseBuilder)? updates,
  ]) => (ParentInviteStore404ResponseBuilder()..update(updates))._build();

  _$ParentInviteStore404Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentInviteStore404Response rebuild(
    void Function(ParentInviteStore404ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteStore404ResponseBuilder toBuilder() =>
      ParentInviteStore404ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteStore404Response &&
        message == other.message &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInviteStore404Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentInviteStore404ResponseBuilder
    implements
        Builder<
          ParentInviteStore404Response,
          ParentInviteStore404ResponseBuilder
        > {
  _$ParentInviteStore404Response? _$v;

  ParentInviteStore404ResponseMessageEnum? _message;
  ParentInviteStore404ResponseMessageEnum? get message => _$this._message;
  set message(ParentInviteStore404ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentInviteStore404ResponseBuilder() {
    ParentInviteStore404Response._defaults(this);
  }

  ParentInviteStore404ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteStore404Response other) {
    _$v = other as _$ParentInviteStore404Response;
  }

  @override
  void update(void Function(ParentInviteStore404ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteStore404Response build() => _build();

  _$ParentInviteStore404Response _build() {
    final _$result =
        _$v ??
        _$ParentInviteStore404Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentInviteStore404Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentInviteStore404Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
