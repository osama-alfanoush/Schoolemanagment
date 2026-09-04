// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_submit_request25403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrSubmitRequest25403ResponseMessageEnum
_$hrSubmitRequest25403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod =
    const HrSubmitRequest25403ResponseMessageEnum._(
      'onlyStaffCanSubmitHRRequestsPeriod',
    );

HrSubmitRequest25403ResponseMessageEnum
_$hrSubmitRequest25403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'onlyStaffCanSubmitHRRequestsPeriod':
      return _$hrSubmitRequest25403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrSubmitRequest25403ResponseMessageEnum>
_$hrSubmitRequest25403ResponseMessageEnumValues =
    BuiltSet<HrSubmitRequest25403ResponseMessageEnum>(const <
      HrSubmitRequest25403ResponseMessageEnum
    >[
      _$hrSubmitRequest25403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod,
    ]);

Serializer<HrSubmitRequest25403ResponseMessageEnum>
_$hrSubmitRequest25403ResponseMessageEnumSerializer =
    _$HrSubmitRequest25403ResponseMessageEnumSerializer();

class _$HrSubmitRequest25403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrSubmitRequest25403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'onlyStaffCanSubmitHRRequestsPeriod': 'Only staff can submit HR requests.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Only staff can submit HR requests.': 'onlyStaffCanSubmitHRRequestsPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrSubmitRequest25403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrSubmitRequest25403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest25403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrSubmitRequest25403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrSubmitRequest25403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrSubmitRequest25403Response extends HrSubmitRequest25403Response {
  @override
  final HrSubmitRequest25403ResponseMessageEnum message;

  factory _$HrSubmitRequest25403Response([
    void Function(HrSubmitRequest25403ResponseBuilder)? updates,
  ]) => (HrSubmitRequest25403ResponseBuilder()..update(updates))._build();

  _$HrSubmitRequest25403Response._({required this.message}) : super._();
  @override
  HrSubmitRequest25403Response rebuild(
    void Function(HrSubmitRequest25403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrSubmitRequest25403ResponseBuilder toBuilder() =>
      HrSubmitRequest25403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrSubmitRequest25403Response && message == other.message;
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
      r'HrSubmitRequest25403Response',
    )..add('message', message)).toString();
  }
}

class HrSubmitRequest25403ResponseBuilder
    implements
        Builder<
          HrSubmitRequest25403Response,
          HrSubmitRequest25403ResponseBuilder
        > {
  _$HrSubmitRequest25403Response? _$v;

  HrSubmitRequest25403ResponseMessageEnum? _message;
  HrSubmitRequest25403ResponseMessageEnum? get message => _$this._message;
  set message(HrSubmitRequest25403ResponseMessageEnum? message) =>
      _$this._message = message;

  HrSubmitRequest25403ResponseBuilder() {
    HrSubmitRequest25403Response._defaults(this);
  }

  HrSubmitRequest25403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrSubmitRequest25403Response other) {
    _$v = other as _$HrSubmitRequest25403Response;
  }

  @override
  void update(void Function(HrSubmitRequest25403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrSubmitRequest25403Response build() => _build();

  _$HrSubmitRequest25403Response _build() {
    final _$result =
        _$v ??
        _$HrSubmitRequest25403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrSubmitRequest25403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
