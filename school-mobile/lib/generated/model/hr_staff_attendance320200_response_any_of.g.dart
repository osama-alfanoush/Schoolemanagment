// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance320200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance320200ResponseAnyOfMessageEnum
_$hrStaffAttendance320200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance320200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance320200ResponseAnyOfMessageEnum
_$hrStaffAttendance320200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance320200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance320200ResponseAnyOfMessageEnum>
_$hrStaffAttendance320200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance320200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance320200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance320200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance320200ResponseAnyOfMessageEnum>
_$hrStaffAttendance320200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance320200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance320200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance320200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance320200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance320200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance320200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance320200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance320200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance320200ResponseAnyOf
    extends HrStaffAttendance320200ResponseAnyOf {
  @override
  final HrStaffAttendance320200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance320200ResponseAnyOf([
    void Function(HrStaffAttendance320200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance320200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance320200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance320200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance320200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance320200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance320200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance320200ResponseAnyOf &&
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
      r'HrStaffAttendance320200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance320200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance320200ResponseAnyOf,
          HrStaffAttendance320200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance320200ResponseAnyOf? _$v;

  HrStaffAttendance320200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance320200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance320200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance320200ResponseAnyOfBuilder() {
    HrStaffAttendance320200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance320200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance320200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance320200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance320200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance320200ResponseAnyOf build() => _build();

  _$HrStaffAttendance320200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance320200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance320200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
