// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components84_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents84RequestTypeEnum
_$teacherGradeComponents84RequestTypeEnum_quiz =
    const TeacherGradeComponents84RequestTypeEnum._('quiz');
const TeacherGradeComponents84RequestTypeEnum
_$teacherGradeComponents84RequestTypeEnum_homework =
    const TeacherGradeComponents84RequestTypeEnum._('homework');
const TeacherGradeComponents84RequestTypeEnum
_$teacherGradeComponents84RequestTypeEnum_exam =
    const TeacherGradeComponents84RequestTypeEnum._('exam');

TeacherGradeComponents84RequestTypeEnum
_$teacherGradeComponents84RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents84RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents84RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents84RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents84RequestTypeEnum>
_$teacherGradeComponents84RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents84RequestTypeEnum>(
      const <TeacherGradeComponents84RequestTypeEnum>[
        _$teacherGradeComponents84RequestTypeEnum_quiz,
        _$teacherGradeComponents84RequestTypeEnum_homework,
        _$teacherGradeComponents84RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents84RequestTypeEnum>
_$teacherGradeComponents84RequestTypeEnumSerializer =
    _$TeacherGradeComponents84RequestTypeEnumSerializer();

class _$TeacherGradeComponents84RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents84RequestTypeEnum> {
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
    TeacherGradeComponents84RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents84RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents84RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents84RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents84RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents84Request
    extends TeacherGradeComponents84Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents84RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents84Request([
    void Function(TeacherGradeComponents84RequestBuilder)? updates,
  ]) => (TeacherGradeComponents84RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents84Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents84Request rebuild(
    void Function(TeacherGradeComponents84RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents84RequestBuilder toBuilder() =>
      TeacherGradeComponents84RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents84Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents84Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents84RequestBuilder
    implements
        Builder<
          TeacherGradeComponents84Request,
          TeacherGradeComponents84RequestBuilder
        > {
  _$TeacherGradeComponents84Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents84RequestTypeEnum? _type;
  TeacherGradeComponents84RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents84RequestTypeEnum? type) =>
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

  TeacherGradeComponents84RequestBuilder() {
    TeacherGradeComponents84Request._defaults(this);
  }

  TeacherGradeComponents84RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents84Request other) {
    _$v = other as _$TeacherGradeComponents84Request;
  }

  @override
  void update(void Function(TeacherGradeComponents84RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents84Request build() => _build();

  _$TeacherGradeComponents84Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents84Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents84Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents84Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents84Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents84Request',
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
