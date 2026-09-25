// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_delta403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SyncDelta403ResponseMessageEnum
_$syncDelta403ResponseMessageEnum_thisRoleHasNoMobileSyncFeedPeriod =
    const SyncDelta403ResponseMessageEnum._(
      'thisRoleHasNoMobileSyncFeedPeriod',
    );

SyncDelta403ResponseMessageEnum _$syncDelta403ResponseMessageEnumValueOf(
  String name,
) {
  switch (name) {
    case 'thisRoleHasNoMobileSyncFeedPeriod':
      return _$syncDelta403ResponseMessageEnum_thisRoleHasNoMobileSyncFeedPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SyncDelta403ResponseMessageEnum>
_$syncDelta403ResponseMessageEnumValues =
    BuiltSet<SyncDelta403ResponseMessageEnum>(
      const <SyncDelta403ResponseMessageEnum>[
        _$syncDelta403ResponseMessageEnum_thisRoleHasNoMobileSyncFeedPeriod,
      ],
    );

Serializer<SyncDelta403ResponseMessageEnum>
_$syncDelta403ResponseMessageEnumSerializer =
    _$SyncDelta403ResponseMessageEnumSerializer();

class _$SyncDelta403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<SyncDelta403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'thisRoleHasNoMobileSyncFeedPeriod': 'This role has no mobile sync feed.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'This role has no mobile sync feed.': 'thisRoleHasNoMobileSyncFeedPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[SyncDelta403ResponseMessageEnum];
  @override
  final String wireName = 'SyncDelta403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    SyncDelta403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SyncDelta403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SyncDelta403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SyncDelta403Response extends SyncDelta403Response {
  @override
  final SyncDelta403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$SyncDelta403Response([
    void Function(SyncDelta403ResponseBuilder)? updates,
  ]) => (SyncDelta403ResponseBuilder()..update(updates))._build();

  _$SyncDelta403Response._({required this.message, required this.errors})
    : super._();
  @override
  SyncDelta403Response rebuild(
    void Function(SyncDelta403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SyncDelta403ResponseBuilder toBuilder() =>
      SyncDelta403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncDelta403Response &&
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
    return (newBuiltValueToStringHelper(r'SyncDelta403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class SyncDelta403ResponseBuilder
    implements Builder<SyncDelta403Response, SyncDelta403ResponseBuilder> {
  _$SyncDelta403Response? _$v;

  SyncDelta403ResponseMessageEnum? _message;
  SyncDelta403ResponseMessageEnum? get message => _$this._message;
  set message(SyncDelta403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  SyncDelta403ResponseBuilder() {
    SyncDelta403Response._defaults(this);
  }

  SyncDelta403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncDelta403Response other) {
    _$v = other as _$SyncDelta403Response;
  }

  @override
  void update(void Function(SyncDelta403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncDelta403Response build() => _build();

  _$SyncDelta403Response _build() {
    final _$result =
        _$v ??
        _$SyncDelta403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'SyncDelta403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'SyncDelta403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
