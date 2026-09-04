// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components107_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents107RequestTypeEnum
_$teacherGradeComponents107RequestTypeEnum_quiz =
    const TeacherGradeComponents107RequestTypeEnum._('quiz');
const TeacherGradeComponents107RequestTypeEnum
_$teacherGradeComponents107RequestTypeEnum_homework =
    const TeacherGradeComponents107RequestTypeEnum._('homework');
const TeacherGradeComponents107RequestTypeEnum
_$teacherGradeComponents107RequestTypeEnum_exam =
    const TeacherGradeComponents107RequestTypeEnum._('exam');

TeacherGradeComponents107RequestTypeEnum
_$teacherGradeComponents107RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents107RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents107RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents107RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents107RequestTypeEnum>
_$teacherGradeComponents107RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents107RequestTypeEnum>(
      const <TeacherGradeComponents107RequestTypeEnum>[
        _$teacherGradeComponents107RequestTypeEnum_quiz,
        _$teacherGradeComponents107RequestTypeEnum_homework,
        _$teacherGradeComponents107RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents107RequestTypeEnum>
_$teacherGradeComponents107RequestTypeEnumSerializer =
    _$TeacherGradeComponents107RequestTypeEnumSerializer();

class _$TeacherGradeComponents107RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents107RequestTypeEnum> {
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
    TeacherGradeComponents107RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents107RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents107RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents107RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents107RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents107Request
    extends TeacherGradeComponents107Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents107RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents107Request([
    void Function(TeacherGradeComponents107RequestBuilder)? updates,
  ]) => (TeacherGradeComponents107RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents107Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents107Request rebuild(
    void Function(TeacherGradeComponents107RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents107RequestBuilder toBuilder() =>
      TeacherGradeComponents107RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents107Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents107Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents107RequestBuilder
    implements
        Builder<
          TeacherGradeComponents107Request,
          TeacherGradeComponents107RequestBuilder
        > {
  _$TeacherGradeComponents107Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents107RequestTypeEnum? _type;
  TeacherGradeComponents107RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents107RequestTypeEnum? type) =>
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

  TeacherGradeComponents107RequestBuilder() {
    TeacherGradeComponents107Request._defaults(this);
  }

  TeacherGradeComponents107RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents107Request other) {
    _$v = other as _$TeacherGradeComponents107Request;
  }

  @override
  void update(void Function(TeacherGradeComponents107RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents107Request build() => _build();

  _$TeacherGradeComponents107Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents107Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents107Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents107Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents107Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents107Request',
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
