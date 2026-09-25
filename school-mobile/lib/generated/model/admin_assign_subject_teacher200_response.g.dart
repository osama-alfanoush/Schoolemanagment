// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_assign_subject_teacher200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AdminAssignSubjectTeacher200ResponseMessageEnum
_$adminAssignSubjectTeacher200ResponseMessageEnum_assigned =
    const AdminAssignSubjectTeacher200ResponseMessageEnum._('assigned');

AdminAssignSubjectTeacher200ResponseMessageEnum
_$adminAssignSubjectTeacher200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'assigned':
      return _$adminAssignSubjectTeacher200ResponseMessageEnum_assigned;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AdminAssignSubjectTeacher200ResponseMessageEnum>
_$adminAssignSubjectTeacher200ResponseMessageEnumValues =
    BuiltSet<AdminAssignSubjectTeacher200ResponseMessageEnum>(
      const <AdminAssignSubjectTeacher200ResponseMessageEnum>[
        _$adminAssignSubjectTeacher200ResponseMessageEnum_assigned,
      ],
    );

Serializer<AdminAssignSubjectTeacher200ResponseMessageEnum>
_$adminAssignSubjectTeacher200ResponseMessageEnumSerializer =
    _$AdminAssignSubjectTeacher200ResponseMessageEnumSerializer();

class _$AdminAssignSubjectTeacher200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<AdminAssignSubjectTeacher200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'assigned': 'Assigned',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Assigned': 'assigned',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AdminAssignSubjectTeacher200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'AdminAssignSubjectTeacher200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    AdminAssignSubjectTeacher200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AdminAssignSubjectTeacher200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AdminAssignSubjectTeacher200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AdminAssignSubjectTeacher200Response
    extends AdminAssignSubjectTeacher200Response {
  @override
  final AdminAssignSubjectTeacher200ResponseMessageEnum message;

  factory _$AdminAssignSubjectTeacher200Response([
    void Function(AdminAssignSubjectTeacher200ResponseBuilder)? updates,
  ]) =>
      (AdminAssignSubjectTeacher200ResponseBuilder()..update(updates))._build();

  _$AdminAssignSubjectTeacher200Response._({required this.message}) : super._();
  @override
  AdminAssignSubjectTeacher200Response rebuild(
    void Function(AdminAssignSubjectTeacher200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminAssignSubjectTeacher200ResponseBuilder toBuilder() =>
      AdminAssignSubjectTeacher200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminAssignSubjectTeacher200Response &&
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
      r'AdminAssignSubjectTeacher200Response',
    )..add('message', message)).toString();
  }
}

class AdminAssignSubjectTeacher200ResponseBuilder
    implements
        Builder<
          AdminAssignSubjectTeacher200Response,
          AdminAssignSubjectTeacher200ResponseBuilder
        > {
  _$AdminAssignSubjectTeacher200Response? _$v;

  AdminAssignSubjectTeacher200ResponseMessageEnum? _message;
  AdminAssignSubjectTeacher200ResponseMessageEnum? get message =>
      _$this._message;
  set message(AdminAssignSubjectTeacher200ResponseMessageEnum? message) =>
      _$this._message = message;

  AdminAssignSubjectTeacher200ResponseBuilder() {
    AdminAssignSubjectTeacher200Response._defaults(this);
  }

  AdminAssignSubjectTeacher200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminAssignSubjectTeacher200Response other) {
    _$v = other as _$AdminAssignSubjectTeacher200Response;
  }

  @override
  void update(
    void Function(AdminAssignSubjectTeacher200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminAssignSubjectTeacher200Response build() => _build();

  _$AdminAssignSubjectTeacher200Response _build() {
    final _$result =
        _$v ??
        _$AdminAssignSubjectTeacher200Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'AdminAssignSubjectTeacher200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
