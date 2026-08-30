// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Gradebook extends Gradebook {
  @override
  final int id;
  @override
  final int schoolId;
  @override
  final int? courseSectionId;
  @override
  final int? classRoomId;
  @override
  final int? subjectId;
  @override
  final int gradingPeriodId;
  @override
  final String state;
  @override
  final int version;
  @override
  final int? submittedBy;
  @override
  final DateTime? submittedAt;
  @override
  final int? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final int? finalizedBy;
  @override
  final DateTime? finalizedAt;
  @override
  final int? reopenedBy;
  @override
  final DateTime? reopenedUntil;
  @override
  final String? reopenReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int? returnedBy;
  @override
  final DateTime? returnedAt;
  @override
  final String? returnReason;

  factory _$Gradebook([void Function(GradebookBuilder)? updates]) =>
      (GradebookBuilder()..update(updates))._build();

  _$Gradebook._({
    required this.id,
    required this.schoolId,
    this.courseSectionId,
    this.classRoomId,
    this.subjectId,
    required this.gradingPeriodId,
    required this.state,
    required this.version,
    this.submittedBy,
    this.submittedAt,
    this.approvedBy,
    this.approvedAt,
    this.finalizedBy,
    this.finalizedAt,
    this.reopenedBy,
    this.reopenedUntil,
    this.reopenReason,
    this.createdAt,
    this.updatedAt,
    this.returnedBy,
    this.returnedAt,
    this.returnReason,
  }) : super._();
  @override
  Gradebook rebuild(void Function(GradebookBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GradebookBuilder toBuilder() => GradebookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Gradebook &&
        id == other.id &&
        schoolId == other.schoolId &&
        courseSectionId == other.courseSectionId &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        gradingPeriodId == other.gradingPeriodId &&
        state == other.state &&
        version == other.version &&
        submittedBy == other.submittedBy &&
        submittedAt == other.submittedAt &&
        approvedBy == other.approvedBy &&
        approvedAt == other.approvedAt &&
        finalizedBy == other.finalizedBy &&
        finalizedAt == other.finalizedAt &&
        reopenedBy == other.reopenedBy &&
        reopenedUntil == other.reopenedUntil &&
        reopenReason == other.reopenReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        returnedBy == other.returnedBy &&
        returnedAt == other.returnedAt &&
        returnReason == other.returnReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, courseSectionId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, gradingPeriodId.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, submittedBy.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, finalizedBy.hashCode);
    _$hash = $jc(_$hash, finalizedAt.hashCode);
    _$hash = $jc(_$hash, reopenedBy.hashCode);
    _$hash = $jc(_$hash, reopenedUntil.hashCode);
    _$hash = $jc(_$hash, reopenReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, returnedBy.hashCode);
    _$hash = $jc(_$hash, returnedAt.hashCode);
    _$hash = $jc(_$hash, returnReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Gradebook')
          ..add('id', id)
          ..add('schoolId', schoolId)
          ..add('courseSectionId', courseSectionId)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('gradingPeriodId', gradingPeriodId)
          ..add('state', state)
          ..add('version', version)
          ..add('submittedBy', submittedBy)
          ..add('submittedAt', submittedAt)
          ..add('approvedBy', approvedBy)
          ..add('approvedAt', approvedAt)
          ..add('finalizedBy', finalizedBy)
          ..add('finalizedAt', finalizedAt)
          ..add('reopenedBy', reopenedBy)
          ..add('reopenedUntil', reopenedUntil)
          ..add('reopenReason', reopenReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('returnedBy', returnedBy)
          ..add('returnedAt', returnedAt)
          ..add('returnReason', returnReason))
        .toString();
  }
}

class GradebookBuilder implements Builder<Gradebook, GradebookBuilder> {
  _$Gradebook? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  int? _courseSectionId;
  int? get courseSectionId => _$this._courseSectionId;
  set courseSectionId(int? courseSectionId) =>
      _$this._courseSectionId = courseSectionId;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  int? _gradingPeriodId;
  int? get gradingPeriodId => _$this._gradingPeriodId;
  set gradingPeriodId(int? gradingPeriodId) =>
      _$this._gradingPeriodId = gradingPeriodId;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  int? _submittedBy;
  int? get submittedBy => _$this._submittedBy;
  set submittedBy(int? submittedBy) => _$this._submittedBy = submittedBy;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  int? _finalizedBy;
  int? get finalizedBy => _$this._finalizedBy;
  set finalizedBy(int? finalizedBy) => _$this._finalizedBy = finalizedBy;

  DateTime? _finalizedAt;
  DateTime? get finalizedAt => _$this._finalizedAt;
  set finalizedAt(DateTime? finalizedAt) => _$this._finalizedAt = finalizedAt;

  int? _reopenedBy;
  int? get reopenedBy => _$this._reopenedBy;
  set reopenedBy(int? reopenedBy) => _$this._reopenedBy = reopenedBy;

  DateTime? _reopenedUntil;
  DateTime? get reopenedUntil => _$this._reopenedUntil;
  set reopenedUntil(DateTime? reopenedUntil) =>
      _$this._reopenedUntil = reopenedUntil;

  String? _reopenReason;
  String? get reopenReason => _$this._reopenReason;
  set reopenReason(String? reopenReason) => _$this._reopenReason = reopenReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _returnedBy;
  int? get returnedBy => _$this._returnedBy;
  set returnedBy(int? returnedBy) => _$this._returnedBy = returnedBy;

  DateTime? _returnedAt;
  DateTime? get returnedAt => _$this._returnedAt;
  set returnedAt(DateTime? returnedAt) => _$this._returnedAt = returnedAt;

  String? _returnReason;
  String? get returnReason => _$this._returnReason;
  set returnReason(String? returnReason) => _$this._returnReason = returnReason;

  GradebookBuilder() {
    Gradebook._defaults(this);
  }

  GradebookBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _schoolId = $v.schoolId;
      _courseSectionId = $v.courseSectionId;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _gradingPeriodId = $v.gradingPeriodId;
      _state = $v.state;
      _version = $v.version;
      _submittedBy = $v.submittedBy;
      _submittedAt = $v.submittedAt;
      _approvedBy = $v.approvedBy;
      _approvedAt = $v.approvedAt;
      _finalizedBy = $v.finalizedBy;
      _finalizedAt = $v.finalizedAt;
      _reopenedBy = $v.reopenedBy;
      _reopenedUntil = $v.reopenedUntil;
      _reopenReason = $v.reopenReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _returnedBy = $v.returnedBy;
      _returnedAt = $v.returnedAt;
      _returnReason = $v.returnReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Gradebook other) {
    _$v = other as _$Gradebook;
  }

  @override
  void update(void Function(GradebookBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Gradebook build() => _build();

  _$Gradebook _build() {
    final _$result =
        _$v ??
        _$Gradebook._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Gradebook', 'id'),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Gradebook',
            'schoolId',
          ),
          courseSectionId: courseSectionId,
          classRoomId: classRoomId,
          subjectId: subjectId,
          gradingPeriodId: BuiltValueNullFieldError.checkNotNull(
            gradingPeriodId,
            r'Gradebook',
            'gradingPeriodId',
          ),
          state: BuiltValueNullFieldError.checkNotNull(
            state,
            r'Gradebook',
            'state',
          ),
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'Gradebook',
            'version',
          ),
          submittedBy: submittedBy,
          submittedAt: submittedAt,
          approvedBy: approvedBy,
          approvedAt: approvedAt,
          finalizedBy: finalizedBy,
          finalizedAt: finalizedAt,
          reopenedBy: reopenedBy,
          reopenedUntil: reopenedUntil,
          reopenReason: reopenReason,
          createdAt: createdAt,
          updatedAt: updatedAt,
          returnedBy: returnedBy,
          returnedAt: returnedAt,
          returnReason: returnReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
