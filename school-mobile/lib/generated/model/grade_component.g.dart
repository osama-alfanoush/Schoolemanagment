// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_component.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradeComponent extends GradeComponent {
  @override
  final int id;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final int? semesterId;
  @override
  final String name;
  @override
  final String type;
  @override
  final String weight;
  @override
  final String maxScore;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int? gradebookId;
  @override
  final int? gradingPeriodId;
  @override
  final int schoolId;

  factory _$GradeComponent([void Function(GradeComponentBuilder)? updates]) =>
      (GradeComponentBuilder()..update(updates))._build();

  _$GradeComponent._({
    required this.id,
    required this.classRoomId,
    required this.subjectId,
    this.semesterId,
    required this.name,
    required this.type,
    required this.weight,
    required this.maxScore,
    this.createdAt,
    this.updatedAt,
    this.gradebookId,
    this.gradingPeriodId,
    required this.schoolId,
  }) : super._();
  @override
  GradeComponent rebuild(void Function(GradeComponentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GradeComponentBuilder toBuilder() => GradeComponentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradeComponent &&
        id == other.id &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        semesterId == other.semesterId &&
        name == other.name &&
        type == other.type &&
        weight == other.weight &&
        maxScore == other.maxScore &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        gradebookId == other.gradebookId &&
        gradingPeriodId == other.gradingPeriodId &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, semesterId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, gradebookId.hashCode);
    _$hash = $jc(_$hash, gradingPeriodId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GradeComponent')
          ..add('id', id)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('semesterId', semesterId)
          ..add('name', name)
          ..add('type', type)
          ..add('weight', weight)
          ..add('maxScore', maxScore)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('gradebookId', gradebookId)
          ..add('gradingPeriodId', gradingPeriodId)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class GradeComponentBuilder
    implements Builder<GradeComponent, GradeComponentBuilder> {
  _$GradeComponent? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  int? _semesterId;
  int? get semesterId => _$this._semesterId;
  set semesterId(int? semesterId) => _$this._semesterId = semesterId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _weight;
  String? get weight => _$this._weight;
  set weight(String? weight) => _$this._weight = weight;

  String? _maxScore;
  String? get maxScore => _$this._maxScore;
  set maxScore(String? maxScore) => _$this._maxScore = maxScore;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _gradebookId;
  int? get gradebookId => _$this._gradebookId;
  set gradebookId(int? gradebookId) => _$this._gradebookId = gradebookId;

  int? _gradingPeriodId;
  int? get gradingPeriodId => _$this._gradingPeriodId;
  set gradingPeriodId(int? gradingPeriodId) =>
      _$this._gradingPeriodId = gradingPeriodId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  GradeComponentBuilder() {
    GradeComponent._defaults(this);
  }

  GradeComponentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _semesterId = $v.semesterId;
      _name = $v.name;
      _type = $v.type;
      _weight = $v.weight;
      _maxScore = $v.maxScore;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _gradebookId = $v.gradebookId;
      _gradingPeriodId = $v.gradingPeriodId;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradeComponent other) {
    _$v = other as _$GradeComponent;
  }

  @override
  void update(void Function(GradeComponentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradeComponent build() => _build();

  _$GradeComponent _build() {
    final _$result =
        _$v ??
        _$GradeComponent._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GradeComponent',
            'id',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'GradeComponent',
            'classRoomId',
          ),
          subjectId: BuiltValueNullFieldError.checkNotNull(
            subjectId,
            r'GradeComponent',
            'subjectId',
          ),
          semesterId: semesterId,
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GradeComponent',
            'name',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'GradeComponent',
            'type',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'GradeComponent',
            'weight',
          ),
          maxScore: BuiltValueNullFieldError.checkNotNull(
            maxScore,
            r'GradeComponent',
            'maxScore',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          gradebookId: gradebookId,
          gradingPeriodId: gradingPeriodId,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'GradeComponent',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
