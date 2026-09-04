// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components93_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents93RequestTypeEnum
_$teacherGradeComponents93RequestTypeEnum_quiz =
    const TeacherGradeComponents93RequestTypeEnum._('quiz');
const TeacherGradeComponents93RequestTypeEnum
_$teacherGradeComponents93RequestTypeEnum_homework =
    const TeacherGradeComponents93RequestTypeEnum._('homework');
const TeacherGradeComponents93RequestTypeEnum
_$teacherGradeComponents93RequestTypeEnum_exam =
    const TeacherGradeComponents93RequestTypeEnum._('exam');

TeacherGradeComponents93RequestTypeEnum
_$teacherGradeComponents93RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents93RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents93RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents93RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents93RequestTypeEnum>
_$teacherGradeComponents93RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents93RequestTypeEnum>(
      const <TeacherGradeComponents93RequestTypeEnum>[
        _$teacherGradeComponents93RequestTypeEnum_quiz,
        _$teacherGradeComponents93RequestTypeEnum_homework,
        _$teacherGradeComponents93RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents93RequestTypeEnum>
_$teacherGradeComponents93RequestTypeEnumSerializer =
    _$TeacherGradeComponents93RequestTypeEnumSerializer();

class _$TeacherGradeComponents93RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents93RequestTypeEnum> {
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
    TeacherGradeComponents93RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents93RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents93RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents93RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents93RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents93Request
    extends TeacherGradeComponents93Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents93RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents93Request([
    void Function(TeacherGradeComponents93RequestBuilder)? updates,
  ]) => (TeacherGradeComponents93RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents93Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents93Request rebuild(
    void Function(TeacherGradeComponents93RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents93RequestBuilder toBuilder() =>
      TeacherGradeComponents93RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents93Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents93Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents93RequestBuilder
    implements
        Builder<
          TeacherGradeComponents93Request,
          TeacherGradeComponents93RequestBuilder
        > {
  _$TeacherGradeComponents93Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents93RequestTypeEnum? _type;
  TeacherGradeComponents93RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents93RequestTypeEnum? type) =>
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

  TeacherGradeComponents93RequestBuilder() {
    TeacherGradeComponents93Request._defaults(this);
  }

  TeacherGradeComponents93RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents93Request other) {
    _$v = other as _$TeacherGradeComponents93Request;
  }

  @override
  void update(void Function(TeacherGradeComponents93RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents93Request build() => _build();

  _$TeacherGradeComponents93Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents93Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents93Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents93Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents93Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents93Request',
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
