// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components83_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents83RequestTypeEnum
_$teacherGradeComponents83RequestTypeEnum_quiz =
    const TeacherGradeComponents83RequestTypeEnum._('quiz');
const TeacherGradeComponents83RequestTypeEnum
_$teacherGradeComponents83RequestTypeEnum_homework =
    const TeacherGradeComponents83RequestTypeEnum._('homework');
const TeacherGradeComponents83RequestTypeEnum
_$teacherGradeComponents83RequestTypeEnum_exam =
    const TeacherGradeComponents83RequestTypeEnum._('exam');

TeacherGradeComponents83RequestTypeEnum
_$teacherGradeComponents83RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents83RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents83RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents83RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents83RequestTypeEnum>
_$teacherGradeComponents83RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents83RequestTypeEnum>(
      const <TeacherGradeComponents83RequestTypeEnum>[
        _$teacherGradeComponents83RequestTypeEnum_quiz,
        _$teacherGradeComponents83RequestTypeEnum_homework,
        _$teacherGradeComponents83RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents83RequestTypeEnum>
_$teacherGradeComponents83RequestTypeEnumSerializer =
    _$TeacherGradeComponents83RequestTypeEnumSerializer();

class _$TeacherGradeComponents83RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents83RequestTypeEnum> {
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
    TeacherGradeComponents83RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents83RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents83RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents83RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents83RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents83Request
    extends TeacherGradeComponents83Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents83RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents83Request([
    void Function(TeacherGradeComponents83RequestBuilder)? updates,
  ]) => (TeacherGradeComponents83RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents83Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents83Request rebuild(
    void Function(TeacherGradeComponents83RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents83RequestBuilder toBuilder() =>
      TeacherGradeComponents83RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents83Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents83Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents83RequestBuilder
    implements
        Builder<
          TeacherGradeComponents83Request,
          TeacherGradeComponents83RequestBuilder
        > {
  _$TeacherGradeComponents83Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents83RequestTypeEnum? _type;
  TeacherGradeComponents83RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents83RequestTypeEnum? type) =>
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

  TeacherGradeComponents83RequestBuilder() {
    TeacherGradeComponents83Request._defaults(this);
  }

  TeacherGradeComponents83RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents83Request other) {
    _$v = other as _$TeacherGradeComponents83Request;
  }

  @override
  void update(void Function(TeacherGradeComponents83RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents83Request build() => _build();

  _$TeacherGradeComponents83Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents83Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents83Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents83Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents83Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents83Request',
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
