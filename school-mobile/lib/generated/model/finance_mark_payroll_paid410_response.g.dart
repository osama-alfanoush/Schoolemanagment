// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_mark_payroll_paid410_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceMarkPayrollPaid410ResponseMessageEnum
_$financeMarkPayrollPaid410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod =
    const FinanceMarkPayrollPaid410ResponseMessageEnum._(
      'thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod',
    );

FinanceMarkPayrollPaid410ResponseMessageEnum
_$financeMarkPayrollPaid410ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod':
      return _$financeMarkPayrollPaid410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceMarkPayrollPaid410ResponseMessageEnum>
_$financeMarkPayrollPaid410ResponseMessageEnumValues =
    BuiltSet<FinanceMarkPayrollPaid410ResponseMessageEnum>(const <
      FinanceMarkPayrollPaid410ResponseMessageEnum
    >[
      _$financeMarkPayrollPaid410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod,
    ]);

const FinanceMarkPayrollPaid410ResponseCodeEnum
_$financeMarkPayrollPaid410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED =
    const FinanceMarkPayrollPaid410ResponseCodeEnum._(
      'LEGACY_PAYROLL_WRITE_DISABLED',
    );

FinanceMarkPayrollPaid410ResponseCodeEnum
_$financeMarkPayrollPaid410ResponseCodeEnumValueOf(String name) {
  switch (name) {
    case 'LEGACY_PAYROLL_WRITE_DISABLED':
      return _$financeMarkPayrollPaid410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceMarkPayrollPaid410ResponseCodeEnum>
_$financeMarkPayrollPaid410ResponseCodeEnumValues =
    BuiltSet<FinanceMarkPayrollPaid410ResponseCodeEnum>(const <
      FinanceMarkPayrollPaid410ResponseCodeEnum
    >[
      _$financeMarkPayrollPaid410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED,
    ]);

Serializer<FinanceMarkPayrollPaid410ResponseMessageEnum>
_$financeMarkPayrollPaid410ResponseMessageEnumSerializer =
    _$FinanceMarkPayrollPaid410ResponseMessageEnumSerializer();
Serializer<FinanceMarkPayrollPaid410ResponseCodeEnum>
_$financeMarkPayrollPaid410ResponseCodeEnumSerializer =
    _$FinanceMarkPayrollPaid410ResponseCodeEnumSerializer();

class _$FinanceMarkPayrollPaid410ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<FinanceMarkPayrollPaid410ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod': 'This legacy payroll writer is no longer supported. Pay the owning payroll run instead.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'This legacy payroll writer is no longer supported. Pay the owning payroll run instead.': 'thisLegacyPayrollWriterIsNoLongerSupportedPeriodPayTheOwningPayrollRunInsteadPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinanceMarkPayrollPaid410ResponseMessageEnum,
  ];
  @override
  final String wireName = 'FinanceMarkPayrollPaid410ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceMarkPayrollPaid410ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceMarkPayrollPaid410ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceMarkPayrollPaid410ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceMarkPayrollPaid410ResponseCodeEnumSerializer
    implements PrimitiveSerializer<FinanceMarkPayrollPaid410ResponseCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LEGACY_PAYROLL_WRITE_DISABLED': 'LEGACY_PAYROLL_WRITE_DISABLED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LEGACY_PAYROLL_WRITE_DISABLED': 'LEGACY_PAYROLL_WRITE_DISABLED',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinanceMarkPayrollPaid410ResponseCodeEnum,
  ];
  @override
  final String wireName = 'FinanceMarkPayrollPaid410ResponseCodeEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceMarkPayrollPaid410ResponseCodeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceMarkPayrollPaid410ResponseCodeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceMarkPayrollPaid410ResponseCodeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceMarkPayrollPaid410Response
    extends FinanceMarkPayrollPaid410Response {
  @override
  final FinanceMarkPayrollPaid410ResponseMessageEnum message;
  @override
  final FinanceMarkPayrollPaid410ResponseCodeEnum code;

  factory _$FinanceMarkPayrollPaid410Response([
    void Function(FinanceMarkPayrollPaid410ResponseBuilder)? updates,
  ]) => (FinanceMarkPayrollPaid410ResponseBuilder()..update(updates))._build();

  _$FinanceMarkPayrollPaid410Response._({
    required this.message,
    required this.code,
  }) : super._();
  @override
  FinanceMarkPayrollPaid410Response rebuild(
    void Function(FinanceMarkPayrollPaid410ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceMarkPayrollPaid410ResponseBuilder toBuilder() =>
      FinanceMarkPayrollPaid410ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceMarkPayrollPaid410Response &&
        message == other.message &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceMarkPayrollPaid410Response')
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class FinanceMarkPayrollPaid410ResponseBuilder
    implements
        Builder<
          FinanceMarkPayrollPaid410Response,
          FinanceMarkPayrollPaid410ResponseBuilder
        > {
  _$FinanceMarkPayrollPaid410Response? _$v;

  FinanceMarkPayrollPaid410ResponseMessageEnum? _message;
  FinanceMarkPayrollPaid410ResponseMessageEnum? get message => _$this._message;
  set message(FinanceMarkPayrollPaid410ResponseMessageEnum? message) =>
      _$this._message = message;

  FinanceMarkPayrollPaid410ResponseCodeEnum? _code;
  FinanceMarkPayrollPaid410ResponseCodeEnum? get code => _$this._code;
  set code(FinanceMarkPayrollPaid410ResponseCodeEnum? code) =>
      _$this._code = code;

  FinanceMarkPayrollPaid410ResponseBuilder() {
    FinanceMarkPayrollPaid410Response._defaults(this);
  }

  FinanceMarkPayrollPaid410ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceMarkPayrollPaid410Response other) {
    _$v = other as _$FinanceMarkPayrollPaid410Response;
  }

  @override
  void update(
    void Function(FinanceMarkPayrollPaid410ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  FinanceMarkPayrollPaid410Response build() => _build();

  _$FinanceMarkPayrollPaid410Response _build() {
    final _$result =
        _$v ??
        _$FinanceMarkPayrollPaid410Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'FinanceMarkPayrollPaid410Response',
            'message',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'FinanceMarkPayrollPaid410Response',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
