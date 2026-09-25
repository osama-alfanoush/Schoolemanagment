// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_process_payroll410_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceProcessPayroll410ResponseMessageEnum
_$financeProcessPayroll410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod =
    const FinanceProcessPayroll410ResponseMessageEnum._(
      'thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod',
    );

FinanceProcessPayroll410ResponseMessageEnum
_$financeProcessPayroll410ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod':
      return _$financeProcessPayroll410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceProcessPayroll410ResponseMessageEnum>
_$financeProcessPayroll410ResponseMessageEnumValues =
    BuiltSet<FinanceProcessPayroll410ResponseMessageEnum>(const <
      FinanceProcessPayroll410ResponseMessageEnum
    >[
      _$financeProcessPayroll410ResponseMessageEnum_thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod,
    ]);

const FinanceProcessPayroll410ResponseCodeEnum
_$financeProcessPayroll410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED =
    const FinanceProcessPayroll410ResponseCodeEnum._(
      'LEGACY_PAYROLL_WRITE_DISABLED',
    );

FinanceProcessPayroll410ResponseCodeEnum
_$financeProcessPayroll410ResponseCodeEnumValueOf(String name) {
  switch (name) {
    case 'LEGACY_PAYROLL_WRITE_DISABLED':
      return _$financeProcessPayroll410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceProcessPayroll410ResponseCodeEnum>
_$financeProcessPayroll410ResponseCodeEnumValues =
    BuiltSet<FinanceProcessPayroll410ResponseCodeEnum>(const <
      FinanceProcessPayroll410ResponseCodeEnum
    >[
      _$financeProcessPayroll410ResponseCodeEnum_LEGACY_PAYROLL_WRITE_DISABLED,
    ]);

Serializer<FinanceProcessPayroll410ResponseMessageEnum>
_$financeProcessPayroll410ResponseMessageEnumSerializer =
    _$FinanceProcessPayroll410ResponseMessageEnumSerializer();
Serializer<FinanceProcessPayroll410ResponseCodeEnum>
_$financeProcessPayroll410ResponseCodeEnumSerializer =
    _$FinanceProcessPayroll410ResponseCodeEnumSerializer();

class _$FinanceProcessPayroll410ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<FinanceProcessPayroll410ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod': 'This legacy payroll writer is no longer supported. Use POST /api/finance/payroll/runs and the run workflow.',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'This legacy payroll writer is no longer supported. Use POST /api/finance/payroll/runs and the run workflow.': 'thisLegacyPayrollWriterIsNoLongerSupportedPeriodUsePOSTSlashApiSlashFinanceSlashPayrollSlashRunsAndTheRunWorkflowPeriod',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinanceProcessPayroll410ResponseMessageEnum,
  ];
  @override
  final String wireName = 'FinanceProcessPayroll410ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceProcessPayroll410ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceProcessPayroll410ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceProcessPayroll410ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceProcessPayroll410ResponseCodeEnumSerializer
    implements PrimitiveSerializer<FinanceProcessPayroll410ResponseCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LEGACY_PAYROLL_WRITE_DISABLED': 'LEGACY_PAYROLL_WRITE_DISABLED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LEGACY_PAYROLL_WRITE_DISABLED': 'LEGACY_PAYROLL_WRITE_DISABLED',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinanceProcessPayroll410ResponseCodeEnum,
  ];
  @override
  final String wireName = 'FinanceProcessPayroll410ResponseCodeEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceProcessPayroll410ResponseCodeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceProcessPayroll410ResponseCodeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceProcessPayroll410ResponseCodeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceProcessPayroll410Response
    extends FinanceProcessPayroll410Response {
  @override
  final FinanceProcessPayroll410ResponseMessageEnum message;
  @override
  final FinanceProcessPayroll410ResponseCodeEnum code;

  factory _$FinanceProcessPayroll410Response([
    void Function(FinanceProcessPayroll410ResponseBuilder)? updates,
  ]) => (FinanceProcessPayroll410ResponseBuilder()..update(updates))._build();

  _$FinanceProcessPayroll410Response._({
    required this.message,
    required this.code,
  }) : super._();
  @override
  FinanceProcessPayroll410Response rebuild(
    void Function(FinanceProcessPayroll410ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceProcessPayroll410ResponseBuilder toBuilder() =>
      FinanceProcessPayroll410ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceProcessPayroll410Response &&
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
    return (newBuiltValueToStringHelper(r'FinanceProcessPayroll410Response')
          ..add('message', message)
          ..add('code', code))
        .toString();
  }
}

class FinanceProcessPayroll410ResponseBuilder
    implements
        Builder<
          FinanceProcessPayroll410Response,
          FinanceProcessPayroll410ResponseBuilder
        > {
  _$FinanceProcessPayroll410Response? _$v;

  FinanceProcessPayroll410ResponseMessageEnum? _message;
  FinanceProcessPayroll410ResponseMessageEnum? get message => _$this._message;
  set message(FinanceProcessPayroll410ResponseMessageEnum? message) =>
      _$this._message = message;

  FinanceProcessPayroll410ResponseCodeEnum? _code;
  FinanceProcessPayroll410ResponseCodeEnum? get code => _$this._code;
  set code(FinanceProcessPayroll410ResponseCodeEnum? code) =>
      _$this._code = code;

  FinanceProcessPayroll410ResponseBuilder() {
    FinanceProcessPayroll410Response._defaults(this);
  }

  FinanceProcessPayroll410ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceProcessPayroll410Response other) {
    _$v = other as _$FinanceProcessPayroll410Response;
  }

  @override
  void update(void Function(FinanceProcessPayroll410ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceProcessPayroll410Response build() => _build();

  _$FinanceProcessPayroll410Response _build() {
    final _$result =
        _$v ??
        _$FinanceProcessPayroll410Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'FinanceProcessPayroll410Response',
            'message',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'FinanceProcessPayroll410Response',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
