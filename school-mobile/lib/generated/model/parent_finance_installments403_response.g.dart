// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_installments403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentFinanceInstallments403ResponseMessageEnum
_$parentFinanceInstallments403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod =
    const ParentFinanceInstallments403ResponseMessageEnum._(
      'youDoNotHaveAccessToThisRecordPeriod',
    );

ParentFinanceInstallments403ResponseMessageEnum
_$parentFinanceInstallments403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'youDoNotHaveAccessToThisRecordPeriod':
      return _$parentFinanceInstallments403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentFinanceInstallments403ResponseMessageEnum>
_$parentFinanceInstallments403ResponseMessageEnumValues =
    BuiltSet<ParentFinanceInstallments403ResponseMessageEnum>(const <
      ParentFinanceInstallments403ResponseMessageEnum
    >[
      _$parentFinanceInstallments403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod,
    ]);

Serializer<ParentFinanceInstallments403ResponseMessageEnum>
_$parentFinanceInstallments403ResponseMessageEnumSerializer =
    _$ParentFinanceInstallments403ResponseMessageEnumSerializer();

class _$ParentFinanceInstallments403ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<ParentFinanceInstallments403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'youDoNotHaveAccessToThisRecordPeriod':
        'You do not have access to this record.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'You do not have access to this record.':
        'youDoNotHaveAccessToThisRecordPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentFinanceInstallments403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ParentFinanceInstallments403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInstallments403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentFinanceInstallments403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentFinanceInstallments403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentFinanceInstallments403Response
    extends ParentFinanceInstallments403Response {
  @override
  final ParentFinanceInstallments403ResponseMessageEnum message;
  @override
  final String errors;

  factory _$ParentFinanceInstallments403Response([
    void Function(ParentFinanceInstallments403ResponseBuilder)? updates,
  ]) =>
      (ParentFinanceInstallments403ResponseBuilder()..update(updates))._build();

  _$ParentFinanceInstallments403Response._({
    required this.message,
    required this.errors,
  }) : super._();
  @override
  ParentFinanceInstallments403Response rebuild(
    void Function(ParentFinanceInstallments403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceInstallments403ResponseBuilder toBuilder() =>
      ParentFinanceInstallments403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceInstallments403Response &&
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
    return (newBuiltValueToStringHelper(r'ParentFinanceInstallments403Response')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class ParentFinanceInstallments403ResponseBuilder
    implements
        Builder<
          ParentFinanceInstallments403Response,
          ParentFinanceInstallments403ResponseBuilder
        > {
  _$ParentFinanceInstallments403Response? _$v;

  ParentFinanceInstallments403ResponseMessageEnum? _message;
  ParentFinanceInstallments403ResponseMessageEnum? get message =>
      _$this._message;
  set message(ParentFinanceInstallments403ResponseMessageEnum? message) =>
      _$this._message = message;

  String? _errors;
  String? get errors => _$this._errors;
  set errors(String? errors) => _$this._errors = errors;

  ParentFinanceInstallments403ResponseBuilder() {
    ParentFinanceInstallments403Response._defaults(this);
  }

  ParentFinanceInstallments403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentFinanceInstallments403Response other) {
    _$v = other as _$ParentFinanceInstallments403Response;
  }

  @override
  void update(
    void Function(ParentFinanceInstallments403ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceInstallments403Response build() => _build();

  _$ParentFinanceInstallments403Response _build() {
    final _$result =
        _$v ??
        _$ParentFinanceInstallments403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'ParentFinanceInstallments403Response',
            'message',
          ),
          errors: BuiltValueNullFieldError.checkNotNull(
            errors,
            r'ParentFinanceInstallments403Response',
            'errors',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
