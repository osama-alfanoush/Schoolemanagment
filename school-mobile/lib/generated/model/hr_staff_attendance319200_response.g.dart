// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance319200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance319200ResponseMessageEnum
_$hrStaffAttendance319200ResponseMessageEnum_saved =
    const HrStaffAttendance319200ResponseMessageEnum._('saved');

HrStaffAttendance319200ResponseMessageEnum
_$hrStaffAttendance319200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance319200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance319200ResponseMessageEnum>
_$hrStaffAttendance319200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance319200ResponseMessageEnum>(
      const <HrStaffAttendance319200ResponseMessageEnum>[
        _$hrStaffAttendance319200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance319200ResponseMessageEnum>
_$hrStaffAttendance319200ResponseMessageEnumSerializer =
    _$HrStaffAttendance319200ResponseMessageEnumSerializer();

class _$HrStaffAttendance319200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance319200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance319200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance319200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance319200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance319200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance319200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance319200Response
    extends HrStaffAttendance319200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance319200Response([
    void Function(HrStaffAttendance319200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance319200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance319200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance319200Response rebuild(
    void Function(HrStaffAttendance319200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance319200ResponseBuilder toBuilder() =>
      HrStaffAttendance319200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance319200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance319200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance319200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance319200Response,
          HrStaffAttendance319200ResponseBuilder
        > {
  _$HrStaffAttendance319200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance319200ResponseBuilder() {
    HrStaffAttendance319200Response._defaults(this);
  }

  HrStaffAttendance319200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance319200Response other) {
    _$v = other as _$HrStaffAttendance319200Response;
  }

  @override
  void update(void Function(HrStaffAttendance319200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance319200Response build() => _build();

  _$HrStaffAttendance319200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance319200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance319200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
