// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance322200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance322200ResponseAnyOfMessageEnum
_$hrStaffAttendance322200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance322200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance322200ResponseAnyOfMessageEnum
_$hrStaffAttendance322200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance322200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance322200ResponseAnyOfMessageEnum>
_$hrStaffAttendance322200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance322200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance322200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance322200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance322200ResponseAnyOfMessageEnum>
_$hrStaffAttendance322200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance322200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance322200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance322200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance322200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance322200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance322200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance322200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance322200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance322200ResponseAnyOf
    extends HrStaffAttendance322200ResponseAnyOf {
  @override
  final HrStaffAttendance322200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance322200ResponseAnyOf([
    void Function(HrStaffAttendance322200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance322200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance322200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance322200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance322200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance322200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance322200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance322200ResponseAnyOf &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HrStaffAttendance322200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance322200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance322200ResponseAnyOf,
          HrStaffAttendance322200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance322200ResponseAnyOf? _$v;

  HrStaffAttendance322200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance322200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance322200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance322200ResponseAnyOfBuilder() {
    HrStaffAttendance322200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance322200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance322200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance322200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance322200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance322200ResponseAnyOf build() => _build();

  _$HrStaffAttendance322200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance322200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance322200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
