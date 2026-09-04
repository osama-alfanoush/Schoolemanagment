// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance331200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance331200ResponseMessageEnum
_$hrStaffAttendance331200ResponseMessageEnum_saved =
    const HrStaffAttendance331200ResponseMessageEnum._('saved');

HrStaffAttendance331200ResponseMessageEnum
_$hrStaffAttendance331200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance331200ResponseMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance331200ResponseMessageEnum>
_$hrStaffAttendance331200ResponseMessageEnumValues =
    BuiltSet<HrStaffAttendance331200ResponseMessageEnum>(
      const <HrStaffAttendance331200ResponseMessageEnum>[
        _$hrStaffAttendance331200ResponseMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance331200ResponseMessageEnum>
_$hrStaffAttendance331200ResponseMessageEnumSerializer =
    _$HrStaffAttendance331200ResponseMessageEnumSerializer();

class _$HrStaffAttendance331200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<HrStaffAttendance331200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance331200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance331200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance331200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance331200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance331200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance331200Response
    extends HrStaffAttendance331200Response {
  @override
  final AnyOf anyOf;

  factory _$HrStaffAttendance331200Response([
    void Function(HrStaffAttendance331200ResponseBuilder)? updates,
  ]) => (HrStaffAttendance331200ResponseBuilder()..update(updates))._build();

  _$HrStaffAttendance331200Response._({required this.anyOf}) : super._();
  @override
  HrStaffAttendance331200Response rebuild(
    void Function(HrStaffAttendance331200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance331200ResponseBuilder toBuilder() =>
      HrStaffAttendance331200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance331200Response && anyOf == other.anyOf;
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
      r'HrStaffAttendance331200Response',
    )..add('anyOf', anyOf)).toString();
  }
}

class HrStaffAttendance331200ResponseBuilder
    implements
        Builder<
          HrStaffAttendance331200Response,
          HrStaffAttendance331200ResponseBuilder
        > {
  _$HrStaffAttendance331200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  HrStaffAttendance331200ResponseBuilder() {
    HrStaffAttendance331200Response._defaults(this);
  }

  HrStaffAttendance331200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance331200Response other) {
    _$v = other as _$HrStaffAttendance331200Response;
  }

  @override
  void update(void Function(HrStaffAttendance331200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance331200Response build() => _build();

  _$HrStaffAttendance331200Response _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance331200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'HrStaffAttendance331200Response',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
