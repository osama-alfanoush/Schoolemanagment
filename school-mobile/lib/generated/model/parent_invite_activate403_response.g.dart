// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_invite_activate403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentInviteActivate403ResponseMessageEnum
_$parentInviteActivate403ResponseMessageEnum_thisAccountHasNoActiveSchoolAssignmentPeriod =
    const ParentInviteActivate403ResponseMessageEnum._(
      'thisAccountHasNoActiveSchoolAssignmentPeriod',
    );

ParentInviteActivate403ResponseMessageEnum
_$parentInviteActivate403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'thisAccountHasNoActiveSchoolAssignmentPeriod':
      return _$parentInviteActivate403ResponseMessageEnum_thisAccountHasNoActiveSchoolAssignmentPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentInviteActivate403ResponseMessageEnum>
_$parentInviteActivate403ResponseMessageEnumValues =
    BuiltSet<ParentInviteActivate403ResponseMessageEnum>(const <
      ParentInviteActivate403ResponseMessageEnum
    >[
      _$parentInviteActivate403ResponseMessageEnum_thisAccountHasNoActiveSchoolAssignmentPeriod,
    ]);

Serializer<ParentInviteActivate403ResponseMessageEnum>
_$parentInviteActivate403ResponseMessageEnumSerializer =
    _$ParentInviteActivate403ResponseMessageEnumSerializer();

class _$ParentInviteActivate403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<ParentInviteActivate403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'thisAccountHasNoActiveSchoolAssignmentPeriod':
        'This account has no active school assignment.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'This account has no active school assignment.':
        'thisAccountHasNoActiveSchoolAssignmentPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentInviteActivate403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentInviteActivate403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentInviteActivate403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentInviteActivate403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentInviteActivate403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentInviteActivate403Response
    extends ParentInviteActivate403Response {
  @override
  final ParentInviteActivate403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentInviteActivate403Response([
    void Function(ParentInviteActivate403ResponseBuilder)? updates,
  ]) => (ParentInviteActivate403ResponseBuilder()..update(updates))._build();

  _$ParentInviteActivate403Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentInviteActivate403Response rebuild(
    void Function(ParentInviteActivate403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInviteActivate403ResponseBuilder toBuilder() =>
      ParentInviteActivate403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInviteActivate403Response &&
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
    return (newBuiltValueToStringHelper(r'ParentInviteActivate403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentInviteActivate403ResponseBuilder
    implements
        Builder<
          ParentInviteActivate403Response,
          ParentInviteActivate403ResponseBuilder
        > {
  _$ParentInviteActivate403Response? _$v;

  ParentInviteActivate403ResponseMessageEnum? _message;
  ParentInviteActivate403ResponseMessageEnum? get message => _$this._message;
  set message(ParentInviteActivate403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentInviteActivate403ResponseBuilder() {
    ParentInviteActivate403Response._defaults(this);
  }

  ParentInviteActivate403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInviteActivate403Response other) {
    _$v = other as _$ParentInviteActivate403Response;
  }

  @override
  void update(void Function(ParentInviteActivate403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInviteActivate403Response build() => _build();

  _$ParentInviteActivate403Response _build() {
    final _$result =
        _$v ??
        _$ParentInviteActivate403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentInviteActivate403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentInviteActivate403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
