// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conduct_log.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConductLog extends ConductLog {
  @override
  final int id;
  @override
  final int studentUserId;
  @override
  final int teacherUserId;
  @override
  final String category;
  @override
  final String title;
  @override
  final String note;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$ConductLog([void Function(ConductLogBuilder)? updates]) =>
      (ConductLogBuilder()..update(updates))._build();

  _$ConductLog._({
    required this.id,
    required this.studentUserId,
    required this.teacherUserId,
    required this.category,
    required this.title,
    required this.note,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  ConductLog rebuild(void Function(ConductLogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConductLogBuilder toBuilder() => ConductLogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConductLog &&
        id == other.id &&
        studentUserId == other.studentUserId &&
        teacherUserId == other.teacherUserId &&
        category == other.category &&
        title == other.title &&
        note == other.note &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, teacherUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConductLog')
          ..add('id', id)
          ..add('studentUserId', studentUserId)
          ..add('teacherUserId', teacherUserId)
          ..add('category', category)
          ..add('title', title)
          ..add('note', note)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class ConductLogBuilder implements Builder<ConductLog, ConductLogBuilder> {
  _$ConductLog? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _teacherUserId;
  int? get teacherUserId => _$this._teacherUserId;
  set teacherUserId(int? teacherUserId) =>
      _$this._teacherUserId = teacherUserId;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  ConductLogBuilder() {
    ConductLog._defaults(this);
  }

  ConductLogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentUserId = $v.studentUserId;
      _teacherUserId = $v.teacherUserId;
      _category = $v.category;
      _title = $v.title;
      _note = $v.note;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConductLog other) {
    _$v = other as _$ConductLog;
  }

  @override
  void update(void Function(ConductLogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConductLog build() => _build();

  _$ConductLog _build() {
    final _$result =
        _$v ??
        _$ConductLog._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'ConductLog', 'id'),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'ConductLog',
            'studentUserId',
          ),
          teacherUserId: BuiltValueNullFieldError.checkNotNull(
            teacherUserId,
            r'ConductLog',
            'teacherUserId',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'ConductLog',
            'category',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'ConductLog',
            'title',
          ),
          note: BuiltValueNullFieldError.checkNotNull(
            note,
            r'ConductLog',
            'note',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'ConductLog',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
