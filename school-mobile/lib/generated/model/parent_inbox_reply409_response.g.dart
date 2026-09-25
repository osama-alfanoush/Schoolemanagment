// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_reply409_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentInboxReply409ResponseMessageEnum
_$parentInboxReply409ResponseMessageEnum_messagesCanOnlyBeSentDuringSchoolHoursPeriod =
    const ParentInboxReply409ResponseMessageEnum._(
      'messagesCanOnlyBeSentDuringSchoolHoursPeriod',
    );

ParentInboxReply409ResponseMessageEnum
_$parentInboxReply409ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'messagesCanOnlyBeSentDuringSchoolHoursPeriod':
      return _$parentInboxReply409ResponseMessageEnum_messagesCanOnlyBeSentDuringSchoolHoursPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentInboxReply409ResponseMessageEnum>
_$parentInboxReply409ResponseMessageEnumValues =
    BuiltSet<ParentInboxReply409ResponseMessageEnum>(const <
      ParentInboxReply409ResponseMessageEnum
    >[
      _$parentInboxReply409ResponseMessageEnum_messagesCanOnlyBeSentDuringSchoolHoursPeriod,
    ]);

Serializer<ParentInboxReply409ResponseMessageEnum>
_$parentInboxReply409ResponseMessageEnumSerializer =
    _$ParentInboxReply409ResponseMessageEnumSerializer();

class _$ParentInboxReply409ResponseMessageEnumSerializer
    implements PrimitiveSerializer<ParentInboxReply409ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'messagesCanOnlyBeSentDuringSchoolHoursPeriod':
        'Messages can only be sent during school hours.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Messages can only be sent during school hours.':
        'messagesCanOnlyBeSentDuringSchoolHoursPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentInboxReply409ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentInboxReply409ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxReply409ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentInboxReply409ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentInboxReply409ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentInboxReply409Response extends ParentInboxReply409Response {
  @override
  final ParentInboxReply409ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentInboxReply409Response([
    void Function(ParentInboxReply409ResponseBuilder)? updates,
  ]) => (ParentInboxReply409ResponseBuilder()..update(updates))._build();

  _$ParentInboxReply409Response._({required this.message, required this.errors})
    : super._();
  @override
  ParentInboxReply409Response rebuild(
    void Function(ParentInboxReply409ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxReply409ResponseBuilder toBuilder() =>
      ParentInboxReply409ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxReply409Response &&
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
    return (newBuiltValueToStringHelper(r'ParentInboxReply409Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentInboxReply409ResponseBuilder
    implements
        Builder<
          ParentInboxReply409Response,
          ParentInboxReply409ResponseBuilder
        > {
  _$ParentInboxReply409Response? _$v;

  ParentInboxReply409ResponseMessageEnum? _message;
  ParentInboxReply409ResponseMessageEnum? get message => _$this._message;
  set message(ParentInboxReply409ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentInboxReply409ResponseBuilder() {
    ParentInboxReply409Response._defaults(this);
  }

  ParentInboxReply409ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxReply409Response other) {
    _$v = other as _$ParentInboxReply409Response;
  }

  @override
  void update(void Function(ParentInboxReply409ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxReply409Response build() => _build();

  _$ParentInboxReply409Response _build() {
    final _$result =
        _$v ??
        _$ParentInboxReply409Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentInboxReply409Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentInboxReply409Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
