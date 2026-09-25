// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance363200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance363200ResponseAnyOfMessageEnum
_$hrStaffAttendance363200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance363200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance363200ResponseAnyOfMessageEnum
_$hrStaffAttendance363200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance363200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance363200ResponseAnyOfMessageEnum>
_$hrStaffAttendance363200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance363200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance363200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance363200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance363200ResponseAnyOfMessageEnum>
_$hrStaffAttendance363200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance363200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance363200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance363200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance363200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance363200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance363200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance363200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance363200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance363200ResponseAnyOf
    extends HrStaffAttendance363200ResponseAnyOf {
  @override
  final HrStaffAttendance363200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance363200ResponseAnyOf([
    void Function(HrStaffAttendance363200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance363200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance363200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance363200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance363200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance363200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance363200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance363200ResponseAnyOf &&
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
      r'HrStaffAttendance363200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance363200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance363200ResponseAnyOf,
          HrStaffAttendance363200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance363200ResponseAnyOf? _$v;

  HrStaffAttendance363200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance363200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance363200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance363200ResponseAnyOfBuilder() {
    HrStaffAttendance363200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance363200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance363200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance363200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance363200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance363200ResponseAnyOf build() => _build();

  _$HrStaffAttendance363200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance363200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance363200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
