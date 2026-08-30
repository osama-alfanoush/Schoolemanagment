// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_update_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InstallmentUpdatePlanRequestStatusEnum
_$installmentUpdatePlanRequestStatusEnum_active =
    const InstallmentUpdatePlanRequestStatusEnum._('active');
const InstallmentUpdatePlanRequestStatusEnum
_$installmentUpdatePlanRequestStatusEnum_defaulted =
    const InstallmentUpdatePlanRequestStatusEnum._('defaulted');

InstallmentUpdatePlanRequestStatusEnum
_$installmentUpdatePlanRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'active':
      return _$installmentUpdatePlanRequestStatusEnum_active;
    case 'defaulted':
      return _$installmentUpdatePlanRequestStatusEnum_defaulted;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InstallmentUpdatePlanRequestStatusEnum>
_$installmentUpdatePlanRequestStatusEnumValues =
    BuiltSet<InstallmentUpdatePlanRequestStatusEnum>(
      const <InstallmentUpdatePlanRequestStatusEnum>[
        _$installmentUpdatePlanRequestStatusEnum_active,
        _$installmentUpdatePlanRequestStatusEnum_defaulted,
      ],
    );

Serializer<InstallmentUpdatePlanRequestStatusEnum>
_$installmentUpdatePlanRequestStatusEnumSerializer =
    _$InstallmentUpdatePlanRequestStatusEnumSerializer();

class _$InstallmentUpdatePlanRequestStatusEnumSerializer
    implements PrimitiveSerializer<InstallmentUpdatePlanRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'defaulted': 'defaulted',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'defaulted': 'defaulted',
  };

  @override
  final Iterable<Type> types = const <Type>[
    InstallmentUpdatePlanRequestStatusEnum,
  ];
  @override
  final String wireName = 'InstallmentUpdatePlanRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    InstallmentUpdatePlanRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InstallmentUpdatePlanRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InstallmentUpdatePlanRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InstallmentUpdatePlanRequest extends InstallmentUpdatePlanRequest {
  @override
  final int? shiftDays;
  @override
  final InstallmentUpdatePlanRequestStatusEnum? status;

  factory _$InstallmentUpdatePlanRequest([
    void Function(InstallmentUpdatePlanRequestBuilder)? updates,
  ]) => (InstallmentUpdatePlanRequestBuilder()..update(updates))._build();

  _$InstallmentUpdatePlanRequest._({this.shiftDays, this.status}) : super._();
  @override
  InstallmentUpdatePlanRequest rebuild(
    void Function(InstallmentUpdatePlanRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InstallmentUpdatePlanRequestBuilder toBuilder() =>
      InstallmentUpdatePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstallmentUpdatePlanRequest &&
        shiftDays == other.shiftDays &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, shiftDays.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InstallmentUpdatePlanRequest')
          ..add('shiftDays', shiftDays)
          ..add('status', status))
        .toString();
  }
}

class InstallmentUpdatePlanRequestBuilder
    implements
        Builder<
          InstallmentUpdatePlanRequest,
          InstallmentUpdatePlanRequestBuilder
        > {
  _$InstallmentUpdatePlanRequest? _$v;

  int? _shiftDays;
  int? get shiftDays => _$this._shiftDays;
  set shiftDays(int? shiftDays) => _$this._shiftDays = shiftDays;

  InstallmentUpdatePlanRequestStatusEnum? _status;
  InstallmentUpdatePlanRequestStatusEnum? get status => _$this._status;
  set status(InstallmentUpdatePlanRequestStatusEnum? status) =>
      _$this._status = status;

  InstallmentUpdatePlanRequestBuilder() {
    InstallmentUpdatePlanRequest._defaults(this);
  }

  InstallmentUpdatePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shiftDays = $v.shiftDays;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InstallmentUpdatePlanRequest other) {
    _$v = other as _$InstallmentUpdatePlanRequest;
  }

  @override
  void update(void Function(InstallmentUpdatePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InstallmentUpdatePlanRequest build() => _build();

  _$InstallmentUpdatePlanRequest _build() {
    final _$result =
        _$v ??
        _$InstallmentUpdatePlanRequest._(shiftDays: shiftDays, status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
