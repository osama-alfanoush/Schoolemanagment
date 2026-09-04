// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance325200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance325200ResponseMessageEnum
_$hrStaffAttendance325200ResponseMessageEnum_saved =
    const HrStaffAttendance325200ResponseMessageEnum._('saved');

HrStaffAttendance325200ResponseMessageEnum
_$hrStaffAttendance325200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance325200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance325200ResponseMessageEnum>
_$hrStaffAttendance325200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance325200ResponseMessageEnum>(
      const <HrStaffAttendance325200ResponseMessageEnum>[
        _$hrStaffAttendance325200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance325200ResponseMessageEnum>
_$hrStaffAttendance325200ResponseMessageEnumSerializer =
    _$HrStaffAttendance325200ResponseMessageEnumSerializer();

class _$HrStaffAttendance325200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance325200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance325200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance325200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance325200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance325200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance325200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance325200Response
    extends HrStaffAttendance325200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance325200Response([
    void Function(HrStaffAttendance325200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance325200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance325200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance325200Response rebuild(
    void Function(HrStaffAttendance325200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance325200ResponseBuilder toBuilder() =>
      HrStaffAttendance325200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance325200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance325200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance325200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance325200Response,
          HrStaffAttendance325200ResponseBuilder
        > {
  _$HrStaffAttendance325200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance325200ResponseBuilder() {
    HrStaffAttendance325200Response._defaults(this);
  }

  HrStaffAttendance325200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance325200Response other) {
    _$v = other as _$HrStaffAttendance325200Response;
  }

  @override
  void update(void Function(HrStaffAttendance325200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance325200Response build() => _build();

  _$HrStaffAttendance325200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance325200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance325200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
