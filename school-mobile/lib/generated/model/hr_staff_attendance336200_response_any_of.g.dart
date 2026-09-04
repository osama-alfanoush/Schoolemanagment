// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance336200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance336200ResponseAnyOfMessageEnum
_$hrStaffAttendance336200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance336200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance336200ResponseAnyOfMessageEnum
_$hrStaffAttendance336200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance336200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance336200ResponseAnyOfMessageEnum>
_$hrStaffAttendance336200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance336200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance336200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance336200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance336200ResponseAnyOfMessageEnum>
_$hrStaffAttendance336200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance336200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance336200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance336200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance336200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance336200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance336200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance336200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance336200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance336200ResponseAnyOf
    extends HrStaffAttendance336200ResponseAnyOf {
  @override
  final HrStaffAttendance336200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance336200ResponseAnyOf([
    void Function(HrStaffAttendance336200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance336200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance336200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance336200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance336200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance336200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance336200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance336200ResponseAnyOf &&
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
      r'HrStaffAttendance336200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance336200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance336200ResponseAnyOf,
          HrStaffAttendance336200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance336200ResponseAnyOf? _$v;

  HrStaffAttendance336200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance336200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance336200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance336200ResponseAnyOfBuilder() {
    HrStaffAttendance336200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance336200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance336200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance336200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance336200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance336200ResponseAnyOf build() => _build();

  _$HrStaffAttendance336200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance336200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance336200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
