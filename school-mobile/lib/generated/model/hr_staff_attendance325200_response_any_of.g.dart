// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance325200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance325200ResponseAnyOfMessageEnum
_$hrStaffAttendance325200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance325200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance325200ResponseAnyOfMessageEnum
_$hrStaffAttendance325200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance325200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance325200ResponseAnyOfMessageEnum>
_$hrStaffAttendance325200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance325200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance325200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance325200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance325200ResponseAnyOfMessageEnum>
_$hrStaffAttendance325200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance325200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance325200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance325200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance325200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance325200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance325200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance325200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance325200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance325200ResponseAnyOf
    extends HrStaffAttendance325200ResponseAnyOf {
  @override
  final HrStaffAttendance325200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance325200ResponseAnyOf([
    void Function(HrStaffAttendance325200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance325200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance325200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance325200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance325200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance325200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance325200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance325200ResponseAnyOf &&
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
      r'HrStaffAttendance325200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance325200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance325200ResponseAnyOf,
          HrStaffAttendance325200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance325200ResponseAnyOf? _$v;

  HrStaffAttendance325200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance325200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance325200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance325200ResponseAnyOfBuilder() {
    HrStaffAttendance325200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance325200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance325200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance325200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance325200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance325200ResponseAnyOf build() => _build();

  _$HrStaffAttendance325200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance325200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance325200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
