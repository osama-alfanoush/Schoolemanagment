// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_submit_assignment403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StudentSubmitAssignment403ResponseMessageEnum
_$studentSubmitAssignment403ResponseMessageEnum_forbidden =
    const StudentSubmitAssignment403ResponseMessageEnum._('forbidden');

StudentSubmitAssignment403ResponseMessageEnum
_$studentSubmitAssignment403ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'forbidden':
      return _$studentSubmitAssignment403ResponseMessageEnum_forbidden;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<StudentSubmitAssignment403ResponseMessageEnum>
_$studentSubmitAssignment403ResponseMessageEnumValues =
    BuiltSet<StudentSubmitAssignment403ResponseMessageEnum>(
      const <StudentSubmitAssignment403ResponseMessageEnum>[
        _$studentSubmitAssignment403ResponseMessageEnum_forbidden,
      ],
    );

Serializer<StudentSubmitAssignment403ResponseMessageEnum>
_$studentSubmitAssignment403ResponseMessageEnumSerializer =
    _$StudentSubmitAssignment403ResponseMessageEnumSerializer();

class _$StudentSubmitAssignment403ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<StudentSubmitAssignment403ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'forbidden': 'Forbidden',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Forbidden': 'forbidden',
  };

  @override
  final Iterable<Type> types = const <Type>[
    StudentSubmitAssignment403ResponseMessageEnum,
  ];
  @override
  final String wireName = 'StudentSubmitAssignment403ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    StudentSubmitAssignment403ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  StudentSubmitAssignment403ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => StudentSubmitAssignment403ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$StudentSubmitAssignment403Response
    extends StudentSubmitAssignment403Response {
  @override
  final StudentSubmitAssignment403ResponseMessageEnum message;

  factory _$StudentSubmitAssignment403Response([
    void Function(StudentSubmitAssignment403ResponseBuilder)? updates,
  ]) => (StudentSubmitAssignment403ResponseBuilder()..update(updates))._build();

  _$StudentSubmitAssignment403Response._({required this.message}) : super._();
  @override
  StudentSubmitAssignment403Response rebuild(
    void Function(StudentSubmitAssignment403ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentSubmitAssignment403ResponseBuilder toBuilder() =>
      StudentSubmitAssignment403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentSubmitAssignment403Response &&
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
      r'StudentSubmitAssignment403Response',
    )..add('message', message)).toString();
  }
}

class StudentSubmitAssignment403ResponseBuilder
    implements
        Builder<
          StudentSubmitAssignment403Response,
          StudentSubmitAssignment403ResponseBuilder
        > {
  _$StudentSubmitAssignment403Response? _$v;

  StudentSubmitAssignment403ResponseMessageEnum? _message;
  StudentSubmitAssignment403ResponseMessageEnum? get message => _$this._message;
  set message(StudentSubmitAssignment403ResponseMessageEnum? message) =>
      _$this._message = message;

  StudentSubmitAssignment403ResponseBuilder() {
    StudentSubmitAssignment403Response._defaults(this);
  }

  StudentSubmitAssignment403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentSubmitAssignment403Response other) {
    _$v = other as _$StudentSubmitAssignment403Response;
  }

  @override
  void update(
    void Function(StudentSubmitAssignment403ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  StudentSubmitAssignment403Response build() => _build();

  _$StudentSubmitAssignment403Response _build() {
    final _$result =
        _$v ??
        _$StudentSubmitAssignment403Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'StudentSubmitAssignment403Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
