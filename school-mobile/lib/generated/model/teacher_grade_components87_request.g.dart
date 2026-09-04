// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_components87_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherGradeComponents87RequestTypeEnum
_$teacherGradeComponents87RequestTypeEnum_quiz =
    const TeacherGradeComponents87RequestTypeEnum._('quiz');
const TeacherGradeComponents87RequestTypeEnum
_$teacherGradeComponents87RequestTypeEnum_homework =
    const TeacherGradeComponents87RequestTypeEnum._('homework');
const TeacherGradeComponents87RequestTypeEnum
_$teacherGradeComponents87RequestTypeEnum_exam =
    const TeacherGradeComponents87RequestTypeEnum._('exam');

TeacherGradeComponents87RequestTypeEnum
_$teacherGradeComponents87RequestTypeEnumValueOf(String name) {
  switch (name) {
    case 'quiz':
      return _$teacherGradeComponents87RequestTypeEnum_quiz;
    case 'homework':
      return _$teacherGradeComponents87RequestTypeEnum_homework;
    case 'exam':
      return _$teacherGradeComponents87RequestTypeEnum_exam;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherGradeComponents87RequestTypeEnum>
_$teacherGradeComponents87RequestTypeEnumValues =
    BuiltSet<TeacherGradeComponents87RequestTypeEnum>(
      const <TeacherGradeComponents87RequestTypeEnum>[
        _$teacherGradeComponents87RequestTypeEnum_quiz,
        _$teacherGradeComponents87RequestTypeEnum_homework,
        _$teacherGradeComponents87RequestTypeEnum_exam,
      ],
    );

Serializer<TeacherGradeComponents87RequestTypeEnum>
_$teacherGradeComponents87RequestTypeEnumSerializer =
    _$TeacherGradeComponents87RequestTypeEnumSerializer();

class _$TeacherGradeComponents87RequestTypeEnumSerializer
    implements PrimitiveSerializer<TeacherGradeComponents87RequestTypeEnum> {
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
    TeacherGradeComponents87RequestTypeEnum,
  ];
  @override
  final String wireName = 'TeacherGradeComponents87RequestTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradeComponents87RequestTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherGradeComponents87RequestTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherGradeComponents87RequestTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherGradeComponents87Request
    extends TeacherGradeComponents87Request {
  @override
  final String name;
  @override
  final TeacherGradeComponents87RequestTypeEnum type;
  @override
  final num weight;
  @override
  final num maxScore;
  @override
  final int? semesterId;
  @override
  final int? gradingPeriodId;

  factory _$TeacherGradeComponents87Request([
    void Function(TeacherGradeComponents87RequestBuilder)? updates,
  ]) => (TeacherGradeComponents87RequestBuilder()..update(updates))._build();

  _$TeacherGradeComponents87Request._({
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.semesterId,
    this.gradingPeriodId,
  }) : super._();
  @override
  TeacherGradeComponents87Request rebuild(
    void Function(TeacherGradeComponents87RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeComponents87RequestBuilder toBuilder() =>
      TeacherGradeComponents87RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeComponents87Request &&
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
    return (newBuiltValueToStringHelper(r'TeacherGradeComponents87Request')
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('semesterId', semesterId)
          ..add('gradingPeriodId', gradingPeriodId))
        .toString();
  }
}

class TeacherGradeComponents87RequestBuilder
    implements
        Builder<
          TeacherGradeComponents87Request,
          TeacherGradeComponents87RequestBuilder
        > {
  _$TeacherGradeComponents87Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  TeacherGradeComponents87RequestTypeEnum? _type;
  TeacherGradeComponents87RequestTypeEnum? get type => _$this._type;
  set type(TeacherGradeComponents87RequestTypeEnum? type) =>
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

  TeacherGradeComponents87RequestBuilder() {
    TeacherGradeComponents87Request._defaults(this);
  }

  TeacherGradeComponents87RequestBuilder get _$this {
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
  void replace(TeacherGradeComponents87Request other) {
    _$v = other as _$TeacherGradeComponents87Request;
  }

  @override
  void update(void Function(TeacherGradeComponents87RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeComponents87Request build() => _build();

  _$TeacherGradeComponents87Request _build() {
    final _$result =
        _$v ??
        _$TeacherGradeComponents87Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TeacherGradeComponents87Request',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TeacherGradeComponents87Request',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'TeacherGradeComponents87Request',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'TeacherGradeComponents87Request',
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
