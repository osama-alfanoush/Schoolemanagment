// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components98_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents98RequestTypeEnum
_$teacherGradeComponents98RequestTypeEnum_quiz =
    const TeacherGradeComponents98RequestTypeEnum._('quiz');
const TeacherGradeComponents98RequestTypeEnum
_$teacherGradeComponents98RequestTypeEnum_homework =
    const TeacherGradeComponents98RequestTypeEnum._('homework');
const TeacherGradeComponents98RequestTypeEnum
_$teacherGradeComponents98RequestTypeEnum_exam =
    const TeacherGradeComponents98RequestTypeEnum._('exam');

TeacherGradeComponents98RequestTypeEnum
_$teacherGradeComponents98RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents98RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents98RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents98RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents98RequestTypeEnum>
_$teacherGradeComponents98RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents98RequestTypeEnum>(
      const <TeacherGradeComponents98RequestTypeEnum>[
        _$teacherGradeComponents98RequestTypeEnum_quiz,
        _$teacherGradeComponents98RequestTypeEnum_homework,
        _$teacherGradeComponents98RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents98RequestTypeEnum>
_$teacherGradeComponents98RequestTypeEnumSerializer =
    _$TeacherGradeComponents98RequestTypeEnumSerializer();

class _$TeacherGradeComponents98RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents98RequestTypeEnum> {
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
    TeacherGradeComponents98RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents98RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents98RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents98RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents98RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents98Request
    extends TeacherGradeComponents98Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents98RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents98Request([
    void Function(TeacherGradeComponents98RequestBuilder)? updates,
  ]) => (TeacherGradeComponents98RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents98Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents98Request rebuild(
    void Function(TeacherGradeComponents98RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents98RequestBuilder toBuilder() =>
      TeacherGradeComponents98RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents98Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents98Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents98RequestBuilder
    implements
        Builder<
          TeacherGradeComponents98Request,
          TeacherGradeComponents98RequestBuilder
        > {
  _$TeacherGradeComponents98Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents98RequestTypeEnum? _type;
  TeacherGradeComponents98RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents98RequestTypeEnum? type) =>
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

  TeacherGradeComponents98RequestBuilder() {
    TeacherGradeComponents98Request._defaults(this);
  }

  TeacherGradeComponents98RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents98Request other) {
    _$v = other as _$TeacherGradeComponents98Request;
  }

  @override
  void update(void Function(TeacherGradeComponents98RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents98Request build() => _build();

  _$TeacherGradeComponents98Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents98Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents98Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents98Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents98Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents98Request',
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
