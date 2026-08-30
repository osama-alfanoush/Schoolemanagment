// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components82_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents82RequestTypeEnum
_$teacherGradeComponents82RequestTypeEnum_quiz =
    const TeacherGradeComponents82RequestTypeEnum._('quiz');
const TeacherGradeComponents82RequestTypeEnum
_$teacherGradeComponents82RequestTypeEnum_homework =
    const TeacherGradeComponents82RequestTypeEnum._('homework');
const TeacherGradeComponents82RequestTypeEnum
_$teacherGradeComponents82RequestTypeEnum_exam =
    const TeacherGradeComponents82RequestTypeEnum._('exam');

TeacherGradeComponents82RequestTypeEnum
_$teacherGradeComponents82RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents82RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents82RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents82RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents82RequestTypeEnum>
_$teacherGradeComponents82RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents82RequestTypeEnum>(
      const <TeacherGradeComponents82RequestTypeEnum>[
        _$teacherGradeComponents82RequestTypeEnum_quiz,
        _$teacherGradeComponents82RequestTypeEnum_homework,
        _$teacherGradeComponents82RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents82RequestTypeEnum>
_$teacherGradeComponents82RequestTypeEnumSerializer =
    _$TeacherGradeComponents82RequestTypeEnumSerializer();

class _$TeacherGradeComponents82RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents82RequestTypeEnum> {
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
    TeacherGradeComponents82RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents82RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents82RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents82RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents82RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents82Request
    extends TeacherGradeComponents82Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents82RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents82Request([
    void Function(TeacherGradeComponents82RequestBuilder)? updates,
  ]) => (TeacherGradeComponents82RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents82Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents82Request rebuild(
    void Function(TeacherGradeComponents82RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents82RequestBuilder toBuilder() =>
      TeacherGradeComponents82RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents82Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents82Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents82RequestBuilder
    implements
        Builder<
          TeacherGradeComponents82Request,
          TeacherGradeComponents82RequestBuilder
        > {
  _$TeacherGradeComponents82Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents82RequestTypeEnum? _type;
  TeacherGradeComponents82RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents82RequestTypeEnum? type) =>
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

  TeacherGradeComponents82RequestBuilder() {
    TeacherGradeComponents82Request._defaults(this);
  }

  TeacherGradeComponents82RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents82Request other) {
    _$v = other as _$TeacherGradeComponents82Request;
  }

  @override
  void update(void Function(TeacherGradeComponents82RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents82Request build() => _build();

  _$TeacherGradeComponents82Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents82Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents82Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents82Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents82Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents82Request',
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
