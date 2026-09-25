// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_disable200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MfaDisable200ResponseMessageEnum
_$mfaDisable200ResponseMessageEnum_mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod =
    const MfaDisable200ResponseMessageEnum._(
      'mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod',
    );

MfaDisable200ResponseMessageEnum _$mfaDisable200ResponseMessageEnumValueOf(
  String name,
) {
  switch (name) {
    case 'mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod':
      return _$mfaDisable200ResponseMessageEnum_mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MfaDisable200ResponseMessageEnum>
_$mfaDisable200ResponseMessageEnumValues =
    BuiltSet<MfaDisable200ResponseMessageEnum>(const <
      MfaDisable200ResponseMessageEnum
    >[
      _$mfaDisable200ResponseMessageEnum_mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod,
    ]);

Serializer<MfaDisable200ResponseMessageEnum>
_$mfaDisable200ResponseMessageEnumSerializer =
    _$MfaDisable200ResponseMessageEnumSerializer();

class _$MfaDisable200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<MfaDisable200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod':
        'MFA disabled. A required account must enroll again at its next login.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MFA disabled. A required account must enroll again at its next login.':
        'mFADisabledPeriodARequiredAccountMustEnrollAgainAtItsNextLoginPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[MfaDisable200ResponseMessageEnum];
  @override
  final String wireName = 'MfaDisable200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    MfaDisable200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MfaDisable200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MfaDisable200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MfaDisable200Response extends MfaDisable200Response {
  @override
  final MfaDisable200ResponseMessageEnum message;

  factory _$MfaDisable200Response([
    void Function(MfaDisable200ResponseBuilder)? updates,
  ]) => (MfaDisable200ResponseBuilder()..update(updates))._build();

  _$MfaDisable200Response._({required this.message}) : super._();
  @override
  MfaDisable200Response rebuild(
    void Function(MfaDisable200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MfaDisable200ResponseBuilder toBuilder() =>
      MfaDisable200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaDisable200Response && message == other.message;
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
      r'MfaDisable200Response',
    )..add('message', message)).toString();
  }
}

class MfaDisable200ResponseBuilder
    implements Builder<MfaDisable200Response, MfaDisable200ResponseBuilder> {
  _$MfaDisable200Response? _$v;

  MfaDisable200ResponseMessageEnum? _message;
  MfaDisable200ResponseMessageEnum? get message => _$this._message;
  set message(MfaDisable200ResponseMessageEnum? message) =>
      _$this._message = message;

  MfaDisable200ResponseBuilder() {
    MfaDisable200Response._defaults(this);
  }

  MfaDisable200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaDisable200Response other) {
    _$v = other as _$MfaDisable200Response;
  }

  @override
  void update(void Function(MfaDisable200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaDisable200Response build() => _build();

  _$MfaDisable200Response _build() {
    final _$result =
        _$v ??
        _$MfaDisable200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'MfaDisable200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
