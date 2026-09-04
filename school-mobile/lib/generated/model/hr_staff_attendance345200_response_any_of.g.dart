// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance345200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance345200ResponseAnyOfMessageEnum
_$hrStaffAttendance345200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance345200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance345200ResponseAnyOfMessageEnum
_$hrStaffAttendance345200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance345200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance345200ResponseAnyOfMessageEnum>
_$hrStaffAttendance345200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance345200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance345200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance345200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance345200ResponseAnyOfMessageEnum>
_$hrStaffAttendance345200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance345200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance345200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance345200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance345200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance345200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance345200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance345200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance345200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance345200ResponseAnyOf
    extends HrStaffAttendance345200ResponseAnyOf {
  @override
  final HrStaffAttendance345200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance345200ResponseAnyOf([
    void Function(HrStaffAttendance345200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance345200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance345200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance345200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance345200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance345200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance345200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance345200ResponseAnyOf &&
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
      r'HrStaffAttendance345200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance345200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance345200ResponseAnyOf,
          HrStaffAttendance345200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance345200ResponseAnyOf? _$v;

  HrStaffAttendance345200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance345200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance345200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance345200ResponseAnyOfBuilder() {
    HrStaffAttendance345200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance345200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance345200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance345200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance345200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance345200ResponseAnyOf build() => _build();

  _$HrStaffAttendance345200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance345200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance345200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
