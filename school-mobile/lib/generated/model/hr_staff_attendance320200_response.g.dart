// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance320200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance320200ResponseMessageEnum
_$hrStaffAttendance320200ResponseMessageEnum_saved =
    const HrStaffAttendance320200ResponseMessageEnum._('saved');

HrStaffAttendance320200ResponseMessageEnum
_$hrStaffAttendance320200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance320200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance320200ResponseMessageEnum>
_$hrStaffAttendance320200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance320200ResponseMessageEnum>(
      const <HrStaffAttendance320200ResponseMessageEnum>[
        _$hrStaffAttendance320200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance320200ResponseMessageEnum>
_$hrStaffAttendance320200ResponseMessageEnumSerializer =
    _$HrStaffAttendance320200ResponseMessageEnumSerializer();

class _$HrStaffAttendance320200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance320200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance320200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance320200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance320200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance320200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance320200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance320200Response
    extends HrStaffAttendance320200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance320200Response([
    void Function(HrStaffAttendance320200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance320200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance320200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance320200Response rebuild(
    void Function(HrStaffAttendance320200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance320200ResponseBuilder toBuilder() =>
      HrStaffAttendance320200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance320200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance320200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance320200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance320200Response,
          HrStaffAttendance320200ResponseBuilder
        > {
  _$HrStaffAttendance320200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance320200ResponseBuilder() {
    HrStaffAttendance320200Response._defaults(this);
  }

  HrStaffAttendance320200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance320200Response other) {
    _$v = other as _$HrStaffAttendance320200Response;
  }

  @override
  void update(void Function(HrStaffAttendance320200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance320200Response build() => _build();

  _$HrStaffAttendance320200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance320200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance320200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
