// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_submit_request24403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrSubmitRequest24403ResponseMessageEnum
_$hrSubmitRequest24403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod =
    const HrSubmitRequest24403ResponseMessageEnum._(
      'onlyStaffCanSubmitHRRequestsPeriod',
    );

HrSubmitRequest24403ResponseMessageEnum
_$hrSubmitRequest24403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'onlyStaffCanSubmitHRRequestsPeriod':
      return _$hrSubmitRequest24403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrSubmitRequest24403ResponseMessageEnum>
_$hrSubmitRequest24403ResponseMessageEnumValues =
    BuiltSet<HrSubmitRequest24403ResponseMessageEnum>(const <
      HrSubmitRequest24403ResponseMessageEnum
    >[
      _$hrSubmitRequest24403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod,
    ]);

Serializer<HrSubmitRequest24403ResponseMessageEnum>
_$hrSubmitRequest24403ResponseMessageEnumSerializer =
    _$HrSubmitRequest24403ResponseMessageEnumSerializer();

class _$HrSubmitRequest24403ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrSubmitRequest24403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'onlyStaffCanSubmitHRRequestsPeriod': 'Only staff can submit HR requests.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Only staff can submit HR requests.': 'onlyStaffCanSubmitHRRequestsPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrSubmitRequest24403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrSubmitRequest24403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest24403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrSubmitRequest24403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrSubmitRequest24403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrSubmitRequest24403Response extends HrSubmitRequest24403Response {
  @override
  final HrSubmitRequest24403ResponseMessageEnum message;

  factory _$HrSubmitRequest24403Response([
    void Function(HrSubmitRequest24403ResponseBuilder)? updates,
  ]) => (HrSubmitRequest24403ResponseBuilder()..update(updates))._build();

  _$HrSubmitRequest24403Response._({required this.message}) : super._();
  @override
  HrSubmitRequest24403Response rebuild(
    void Function(HrSubmitRequest24403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrSubmitRequest24403ResponseBuilder toBuilder() =>
      HrSubmitRequest24403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrSubmitRequest24403Response && message == other.message;
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
      r'HrSubmitRequest24403Response',
    )..add('message', message)).toString();
  }
}

class HrSubmitRequest24403ResponseBuilder
    implements
        Builder<
          HrSubmitRequest24403Response,
          HrSubmitRequest24403ResponseBuilder
        > {
  _$HrSubmitRequest24403Response? _$v;

  HrSubmitRequest24403ResponseMessageEnum? _message;
  HrSubmitRequest24403ResponseMessageEnum? get message => _$this._message;
  set message(HrSubmitRequest24403ResponseMessageEnum? message) =>
      _$this._message = message;

  HrSubmitRequest24403ResponseBuilder() {
    HrSubmitRequest24403Response._defaults(this);
  }

  HrSubmitRequest24403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrSubmitRequest24403Response other) {
    _$v = other as _$HrSubmitRequest24403Response;
  }

  @override
  void update(void Function(HrSubmitRequest24403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrSubmitRequest24403Response build() => _build();

  _$HrSubmitRequest24403Response _build() {
    final _$result =
        _$v ??
        _$HrSubmitRequest24403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrSubmitRequest24403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
