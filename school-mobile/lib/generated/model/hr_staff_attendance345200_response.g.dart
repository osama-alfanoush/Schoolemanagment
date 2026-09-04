// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance345200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance345200ResponseMessageEnum
_$hrStaffAttendance345200ResponseMessageEnum_saved =
    const HrStaffAttendance345200ResponseMessageEnum._('saved');

HrStaffAttendance345200ResponseMessageEnum
_$hrStaffAttendance345200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance345200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance345200ResponseMessageEnum>
_$hrStaffAttendance345200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance345200ResponseMessageEnum>(
      const <HrStaffAttendance345200ResponseMessageEnum>[
        _$hrStaffAttendance345200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance345200ResponseMessageEnum>
_$hrStaffAttendance345200ResponseMessageEnumSerializer =
    _$HrStaffAttendance345200ResponseMessageEnumSerializer();

class _$HrStaffAttendance345200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance345200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance345200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance345200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance345200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance345200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance345200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance345200Response
    extends HrStaffAttendance345200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance345200Response([
    void Function(HrStaffAttendance345200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance345200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance345200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance345200Response rebuild(
    void Function(HrStaffAttendance345200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance345200ResponseBuilder toBuilder() =>
      HrStaffAttendance345200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance345200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance345200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance345200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance345200Response,
          HrStaffAttendance345200ResponseBuilder
        > {
  _$HrStaffAttendance345200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance345200ResponseBuilder() {
    HrStaffAttendance345200Response._defaults(this);
  }

  HrStaffAttendance345200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance345200Response other) {
    _$v = other as _$HrStaffAttendance345200Response;
  }

  @override
  void update(void Function(HrStaffAttendance345200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance345200Response build() => _build();

  _$HrStaffAttendance345200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance345200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance345200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
