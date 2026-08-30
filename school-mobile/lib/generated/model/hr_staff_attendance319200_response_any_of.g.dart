// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_staff_attendance319200_response_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const HrStaffAttendance319200ResponseAnyOfMessageEnum
_$hrStaffAttendance319200ResponseAnyOfMessageEnum_saved =
    const HrStaffAttendance319200ResponseAnyOfMessageEnum._('saved');

HrStaffAttendance319200ResponseAnyOfMessageEnum
_$hrStaffAttendance319200ResponseAnyOfMessageEnumValueOf(String name) {
  switch (name) {
    case 'saved':
      return _$hrStaffAttendance319200ResponseAnyOfMessageEnum_saved;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<HrStaffAttendance319200ResponseAnyOfMessageEnum>
_$hrStaffAttendance319200ResponseAnyOfMessageEnumValues =
    BuiltSet<HrStaffAttendance319200ResponseAnyOfMessageEnum>(
      const <HrStaffAttendance319200ResponseAnyOfMessageEnum>[
        _$hrStaffAttendance319200ResponseAnyOfMessageEnum_saved,
      ],
    );

Serializer<HrStaffAttendance319200ResponseAnyOfMessageEnum>
_$hrStaffAttendance319200ResponseAnyOfMessageEnumSerializer =
    _$HrStaffAttendance319200ResponseAnyOfMessageEnumSerializer();

class _$HrStaffAttendance319200ResponseAnyOfMessageEnumSerializer
    implements
        PrimitiveSerializer<HrStaffAttendance319200ResponseAnyOfMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'saved': 'Saved',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Saved': 'saved',
  };

  @override
  final Iterable<Type> types = const <Type>[
    HrStaffAttendance319200ResponseAnyOfMessageEnum,
  ];
  @override
  final String wireName = 'HrStaffAttendance319200ResponseAnyOfMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance319200ResponseAnyOfMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  HrStaffAttendance319200ResponseAnyOfMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => HrStaffAttendance319200ResponseAnyOfMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$HrStaffAttendance319200ResponseAnyOf
    extends HrStaffAttendance319200ResponseAnyOf {
  @override
  final HrStaffAttendance319200ResponseAnyOfMessageEnum message;

  factory _$HrStaffAttendance319200ResponseAnyOf([
    void Function(HrStaffAttendance319200ResponseAnyOfBuilder)? updates,
  ]) =>
      (HrStaffAttendance319200ResponseAnyOfBuilder()..update(updates))._build();

  _$HrStaffAttendance319200ResponseAnyOf._({required this.message}) : super._();
  @override
  HrStaffAttendance319200ResponseAnyOf rebuild(
    void Function(HrStaffAttendance319200ResponseAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HrStaffAttendance319200ResponseAnyOfBuilder toBuilder() =>
      HrStaffAttendance319200ResponseAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrStaffAttendance319200ResponseAnyOf &&
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
      r'HrStaffAttendance319200ResponseAnyOf',
    )..add('message', message)).toString();
  }
}

class HrStaffAttendance319200ResponseAnyOfBuilder
    implements
        Builder<
          HrStaffAttendance319200ResponseAnyOf,
          HrStaffAttendance319200ResponseAnyOfBuilder
        > {
  _$HrStaffAttendance319200ResponseAnyOf? _$v;

  HrStaffAttendance319200ResponseAnyOfMessageEnum? _message;
  HrStaffAttendance319200ResponseAnyOfMessageEnum? get message =>
      _$this._message;
  set message(HrStaffAttendance319200ResponseAnyOfMessageEnum? message) =>
      _$this._message = message;

  HrStaffAttendance319200ResponseAnyOfBuilder() {
    HrStaffAttendance319200ResponseAnyOf._defaults(this);
  }

  HrStaffAttendance319200ResponseAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrStaffAttendance319200ResponseAnyOf other) {
    _$v = other as _$HrStaffAttendance319200ResponseAnyOf;
  }

  @override
  void update(
    void Function(HrStaffAttendance319200ResponseAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  HrStaffAttendance319200ResponseAnyOf build() => _build();

  _$HrStaffAttendance319200ResponseAnyOf _build() {
    final _$result =
        _$v ??
        _$HrStaffAttendance319200ResponseAnyOf._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'HrStaffAttendance319200ResponseAnyOf',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
