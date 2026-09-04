// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance331200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance331200ResponseAnyOfMessageEnum
_$hrStaffAttendance331200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance331200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance331200ResponseAnyOfMessageEnum
_$hrStaffAttendance331200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance331200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance331200ResponseAnyOfMessageEnum>
_$hrStaffAttendance331200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance331200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance331200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance331200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance331200ResponseAnyOfMessageEnum>
_$hrStaffAttendance331200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance331200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance331200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance331200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance331200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance331200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance331200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance331200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance331200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance331200ResponseAnyOf
    extends HrStaffAttendance331200ResponseAnyOf {
  @override
  final HrStaffAttendance331200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance331200ResponseAnyOf([
    void Function(HrStaffAttendance331200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance331200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance331200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance331200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance331200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance331200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance331200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance331200ResponseAnyOf &&
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
      r'HrStaffAttendance331200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance331200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance331200ResponseAnyOf,
          HrStaffAttendance331200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance331200ResponseAnyOf? _$v;

  HrStaffAttendance331200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance331200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance331200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance331200ResponseAnyOfBuilder() {
    HrStaffAttendance331200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance331200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance331200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance331200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance331200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance331200ResponseAnyOf build() => _build();

  _$HrStaffAttendance331200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance331200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance331200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
