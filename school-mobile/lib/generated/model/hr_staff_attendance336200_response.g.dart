// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance336200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance336200ResponseMessageEnum
_$hrStaffAttendance336200ResponseMessageEnum_saved =
    const HrStaffAttendance336200ResponseMessageEnum._('saved');

HrStaffAttendance336200ResponseMessageEnum
_$hrStaffAttendance336200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance336200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance336200ResponseMessageEnum>
_$hrStaffAttendance336200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance336200ResponseMessageEnum>(
      const <HrStaffAttendance336200ResponseMessageEnum>[
        _$hrStaffAttendance336200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance336200ResponseMessageEnum>
_$hrStaffAttendance336200ResponseMessageEnumSerializer =
    _$HrStaffAttendance336200ResponseMessageEnumSerializer();

class _$HrStaffAttendance336200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance336200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance336200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance336200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance336200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance336200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance336200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance336200Response
    extends HrStaffAttendance336200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance336200Response([
    void Function(HrStaffAttendance336200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance336200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance336200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance336200Response rebuild(
    void Function(HrStaffAttendance336200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance336200ResponseBuilder toBuilder() =>
      HrStaffAttendance336200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance336200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance336200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance336200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance336200Response,
          HrStaffAttendance336200ResponseBuilder
        > {
  _$HrStaffAttendance336200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance336200ResponseBuilder() {
    HrStaffAttendance336200Response._defaults(this);
  }

  HrStaffAttendance336200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance336200Response other) {
    _$v = other as _$HrStaffAttendance336200Response;
  }

  @override
  void update(void Function(HrStaffAttendance336200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance336200Response build() => _build();

  _$HrStaffAttendance336200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance336200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance336200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
