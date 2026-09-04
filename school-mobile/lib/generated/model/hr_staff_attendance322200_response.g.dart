// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance322200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance322200ResponseMessageEnum
_$hrStaffAttendance322200ResponseMessageEnum_saved =
    const HrStaffAttendance322200ResponseMessageEnum._('saved');

HrStaffAttendance322200ResponseMessageEnum
_$hrStaffAttendance322200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance322200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance322200ResponseMessageEnum>
_$hrStaffAttendance322200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance322200ResponseMessageEnum>(
      const <HrStaffAttendance322200ResponseMessageEnum>[
        _$hrStaffAttendance322200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance322200ResponseMessageEnum>
_$hrStaffAttendance322200ResponseMessageEnumSerializer =
    _$HrStaffAttendance322200ResponseMessageEnumSerializer();

class _$HrStaffAttendance322200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance322200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance322200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance322200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance322200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance322200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance322200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance322200Response
    extends HrStaffAttendance322200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance322200Response([
    void Function(HrStaffAttendance322200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance322200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance322200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance322200Response rebuild(
    void Function(HrStaffAttendance322200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance322200ResponseBuilder toBuilder() =>
      HrStaffAttendance322200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance322200Response && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrStaffAttendance322200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance322200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance322200Response,
          HrStaffAttendance322200ResponseBuilder
        > {
  _$HrStaffAttendance322200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance322200ResponseBuilder() {
    HrStaffAttendance322200Response._defaults(this);
  }

  HrStaffAttendance322200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance322200Response other) {
    _$v = other as _$HrStaffAttendance322200Response;
  }

  @override
  void update(void Function(HrStaffAttendance322200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance322200Response build() => _build();

  _$HrStaffAttendance322200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance322200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance322200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
