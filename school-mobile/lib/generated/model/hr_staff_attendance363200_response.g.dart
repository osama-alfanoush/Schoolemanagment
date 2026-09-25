// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance363200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance363200ResponseMessageEnum
_$hrStaffAttendance363200ResponseMessageEnum_saved =
    const HrStaffAttendance363200ResponseMessageEnum._('saved');

HrStaffAttendance363200ResponseMessageEnum
_$hrStaffAttendance363200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance363200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance363200ResponseMessageEnum>
_$hrStaffAttendance363200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance363200ResponseMessageEnum>(
      const <HrStaffAttendance363200ResponseMessageEnum>[
        _$hrStaffAttendance363200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance363200ResponseMessageEnum>
_$hrStaffAttendance363200ResponseMessageEnumSerializer =
    _$HrStaffAttendance363200ResponseMessageEnumSerializer();

class _$HrStaffAttendance363200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance363200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance363200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance363200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance363200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance363200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance363200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance363200Response
    extends HrStaffAttendance363200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance363200Response([
    void Function(HrStaffAttendance363200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance363200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance363200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance363200Response rebuild(
    void Function(HrStaffAttendance363200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance363200ResponseBuilder toBuilder() =>
      HrStaffAttendance363200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance363200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance363200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance363200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance363200Response,
          HrStaffAttendance363200ResponseBuilder
        > {
  _$HrStaffAttendance363200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance363200ResponseBuilder() {
    HrStaffAttendance363200Response._defaults(this);
  }

  HrStaffAttendance363200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance363200Response other) {
    _$v = other as _$HrStaffAttendance363200Response;
  }

  @override
  void update(void Function(HrStaffAttendance363200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance363200Response build() => _build();

  _$HrStaffAttendance363200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance363200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance363200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
