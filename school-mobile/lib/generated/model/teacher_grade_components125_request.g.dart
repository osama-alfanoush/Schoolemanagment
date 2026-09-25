// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components125_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents125RequestTypeEnum
_$teacherGradeComponents125RequestTypeEnum_quiz =
    const TeacherGradeComponents125RequestTypeEnum._('quiz');
const TeacherGradeComponents125RequestTypeEnum
_$teacherGradeComponents125RequestTypeEnum_homework =
    const TeacherGradeComponents125RequestTypeEnum._('homework');
const TeacherGradeComponents125RequestTypeEnum
_$teacherGradeComponents125RequestTypeEnum_exam =
    const TeacherGradeComponents125RequestTypeEnum._('exam');

TeacherGradeComponents125RequestTypeEnum
_$teacherGradeComponents125RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents125RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents125RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents125RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents125RequestTypeEnum>
_$teacherGradeComponents125RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents125RequestTypeEnum>(
      const <TeacherGradeComponents125RequestTypeEnum>[
        _$teacherGradeComponents125RequestTypeEnum_quiz,
        _$teacherGradeComponents125RequestTypeEnum_homework,
        _$teacherGradeComponents125RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents125RequestTypeEnum>
_$teacherGradeComponents125RequestTypeEnumSerializer =
    _$TeacherGradeComponents125RequestTypeEnumSerializer();

class _$TeacherGradeComponents125RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents125RequestTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'quiz': 'quiz',
    'homework': 'homework',
    'exam': 'exam',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'quiz': 'quiz',
    'homework': 'homework',
    'exam': 'exam',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TeacherGradeComponents125RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents125RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents125RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents125RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents125RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents125Request
    extends TeacherGradeComponents125Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents125RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents125Request([
    void Function(TeacherGradeComponents125RequestBuilder)? updates,
  ]) => (TeacherGradeComponents125RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents125Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents125Request rebuild(
    void Function(TeacherGradeComponents125RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents125RequestBuilder toBuilder() =>
      TeacherGradeComponents125RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents125Request &&
        name == other.name &&
        type == other.type &&
        weight == other.weight &&
        maxScore == other.maxScore &&
        semesterId == other.semesterId &&
        gradingPeriodId == other.gradingPeriodId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, semesterId.hashCode);
    _$hash = $jc(_$hash, gradingPeriodId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents125Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents125RequestBuilder
    implements
        Builder<
          TeacherGradeComponents125Request,
          TeacherGradeComponents125RequestBuilder
        > {
  _$TeacherGradeComponents125Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents125RequestTypeEnum? _type;
  TeacherGradeComponents125RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents125RequestTypeEnum? type) =>
      _$this._type = type;

  num? _weight;
  num? get weight => _$this._weight;
  set weight(num? weight) => _$this._weight = weight;

  num? _maxScore;
  num? get maxScore => _$this._maxScore;
  set maxScore(num? maxScore) => _$this._maxScore = maxScore;

  int? _semesterId;
  int? get semesterId => _$this._semesterId;
  set semesterId(int? semesterId) => _$this._semesterId = semesterId;

  int? _gradingPeriodId;
  int? get gradingPeriodId => _$this._gradingPeriodId;
  set gradingPeriodId(int? gradingPeriodId) =>
      _$this._gradingPeriodId = gradingPeriodId;

  TeacherGradeComponents125RequestBuilder() {
    TeacherGradeComponents125Request._defaults(this);
  }

  TeacherGradeComponents125RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _type = $v.type;
      _weight = $v.weight;
      _maxScore = $v.maxScore;
      _semesterId = $v.semesterId;
      _gradingPeriodId = $v.gradingPeriodId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradeComponents125Request other) {
    _$v = other as _$TeacherGradeComponents125Request;
  }

  @override
  void update(void Function(TeacherGradeComponents125RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents125Request build() => _build();

  _$TeacherGradeComponents125Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents125Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents125Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents125Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents125Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents125Request',
            'maxScore',
          ),
          semesterId: semesterId,
          gradingPeriodId: gradingPeriodId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
