// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_settings_update_general_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum
_$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_none =
    const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum._('none');
const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum
_$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_calendarDays =
    const PayrollSettingsUpdateGeneralRequestProrationPolicyEnum._(
      'calendarDays',
    );

PayrollSettingsUpdateGeneralRequestProrationPolicyEnum
_$payrollSettingsUpdateGeneralRequestProrationPolicyEnumValueOf(String name) {
  switch (name) {
    case 'none':
      return _$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_none;
    case 'calendarDays':
      return _$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_calendarDays;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PayrollSettingsUpdateGeneralRequestProrationPolicyEnum>
_$payrollSettingsUpdateGeneralRequestProrationPolicyEnumValues =
    BuiltSet<PayrollSettingsUpdateGeneralRequestProrationPolicyEnum>(
      const <PayrollSettingsUpdateGeneralRequestProrationPolicyEnum>[
        _$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_none,
        _$payrollSettingsUpdateGeneralRequestProrationPolicyEnum_calendarDays,
      ],
    );

const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum
_$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_block =
    const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum._('block');
const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum
_$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_allow =
    const PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum._('allow');

PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum
_$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumValueOf(String name) {
  switch (name) {
    case 'block':
      return _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_block;
    case 'allow':
      return _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_allow;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum>
_$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumValues =
    BuiltSet<PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum>(
      const <PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum>[
        _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_block,
        _$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum_allow,
      ],
    );

Serializer<PayrollSettingsUpdateGeneralRequestProrationPolicyEnum>
_$payrollSettingsUpdateGeneralRequestProrationPolicyEnumSerializer =
    _$PayrollSettingsUpdateGeneralRequestProrationPolicyEnumSerializer();
Serializer<PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum>
_$payrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumSerializer =
    _$PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumSerializer();

class _$PayrollSettingsUpdateGeneralRequestProrationPolicyEnumSerializer
    implements
        PrimitiveSerializer<
          PayrollSettingsUpdateGeneralRequestProrationPolicyEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'none',
    'calendarDays': 'calendar_days',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'none': 'none',
    'calendar_days': 'calendarDays',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PayrollSettingsUpdateGeneralRequestProrationPolicyEnum,
  ];
  @override
  final String wireName =
      'PayrollSettingsUpdateGeneralRequestProrationPolicyEnum';

  @override
  Object serialize(
    Serializers serializers,
    PayrollSettingsUpdateGeneralRequestProrationPolicyEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PayrollSettingsUpdateGeneralRequestProrationPolicyEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PayrollSettingsUpdateGeneralRequestProrationPolicyEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnumSerializer
    implements
        PrimitiveSerializer<
          PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'block': 'block',
    'allow': 'allow',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'block': 'block',
    'allow': 'allow',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum,
  ];
  @override
  final String wireName =
      'PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum';

  @override
  Object serialize(
    Serializers serializers,
    PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$PayrollSettingsUpdateGeneralRequest
    extends PayrollSettingsUpdateGeneralRequest {
  @override
  final BuiltList<int>? contractAlertDays;
  @override
  final PayrollSettingsUpdateGeneralRequestProrationPolicyEnum? prorationPolicy;
  @override
  final PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum?
  negativeNetPolicy;
  @override
  final String? currency;

  factory _$PayrollSettingsUpdateGeneralRequest([
    void Function(PayrollSettingsUpdateGeneralRequestBuilder)? updates,
  ]) =>
      (PayrollSettingsUpdateGeneralRequestBuilder()..update(updates))._build();

  _$PayrollSettingsUpdateGeneralRequest._({
    this.contractAlertDays,
    this.prorationPolicy,
    this.negativeNetPolicy,
    this.currency,
  }) : super._();
  @override
  PayrollSettingsUpdateGeneralRequest rebuild(
    void Function(PayrollSettingsUpdateGeneralRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PayrollSettingsUpdateGeneralRequestBuilder toBuilder() =>
      PayrollSettingsUpdateGeneralRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollSettingsUpdateGeneralRequest &&
        contractAlertDays == other.contractAlertDays &&
        prorationPolicy == other.prorationPolicy &&
        negativeNetPolicy == other.negativeNetPolicy &&
        currency == other.currency;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contractAlertDays.hashCode);
    _$hash = $jc(_$hash, prorationPolicy.hashCode);
    _$hash = $jc(_$hash, negativeNetPolicy.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollSettingsUpdateGeneralRequest')
          ..add('contractAlertDays', contractAlertDays)
          ..add('prorationPolicy', prorationPolicy)
          ..add('negativeNetPolicy', negativeNetPolicy)
          ..add('currency', currency))
        .toString();
  }
}

class PayrollSettingsUpdateGeneralRequestBuilder
    implements
        Builder<
          PayrollSettingsUpdateGeneralRequest,
          PayrollSettingsUpdateGeneralRequestBuilder
        > {
  _$PayrollSettingsUpdateGeneralRequest? _$v;

  ListBuilder<int>? _contractAlertDays;
  ListBuilder<int> get contractAlertDays =>
      _$this._contractAlertDays ??= ListBuilder<int>();
  set contractAlertDays(ListBuilder<int>? contractAlertDays) =>
      _$this._contractAlertDays = contractAlertDays;

  PayrollSettingsUpdateGeneralRequestProrationPolicyEnum? _prorationPolicy;
  PayrollSettingsUpdateGeneralRequestProrationPolicyEnum? get prorationPolicy =>
      _$this._prorationPolicy;
  set prorationPolicy(
    PayrollSettingsUpdateGeneralRequestProrationPolicyEnum? prorationPolicy,
  ) => _$this._prorationPolicy = prorationPolicy;

  PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum? _negativeNetPolicy;
  PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum?
  get negativeNetPolicy => _$this._negativeNetPolicy;
  set negativeNetPolicy(
    PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum? negativeNetPolicy,
  ) => _$this._negativeNetPolicy = negativeNetPolicy;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  PayrollSettingsUpdateGeneralRequestBuilder() {
    PayrollSettingsUpdateGeneralRequest._defaults(this);
  }

  PayrollSettingsUpdateGeneralRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contractAlertDays = $v.contractAlertDays?.toBuilder();
      _prorationPolicy = $v.prorationPolicy;
      _negativeNetPolicy = $v.negativeNetPolicy;
      _currency = $v.currency;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollSettingsUpdateGeneralRequest other) {
    _$v = other as _$PayrollSettingsUpdateGeneralRequest;
  }

  @override
  void update(
    void Function(PayrollSettingsUpdateGeneralRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  PayrollSettingsUpdateGeneralRequest build() => _build();

  _$PayrollSettingsUpdateGeneralRequest _build() {
    _$PayrollSettingsUpdateGeneralRequest _$result;
    try {
      _$result =
          _$v ??
          _$PayrollSettingsUpdateGeneralRequest._(
            contractAlertDays: _contractAlertDays?.build(),
            prorationPolicy: prorationPolicy,
            negativeNetPolicy: negativeNetPolicy,
            currency: currency,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contractAlertDays';
        _contractAlertDays?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PayrollSettingsUpdateGeneralRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
