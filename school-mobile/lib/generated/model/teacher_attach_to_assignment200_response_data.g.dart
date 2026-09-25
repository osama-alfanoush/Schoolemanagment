// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_attach_to_assignment200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAttachToAssignment200ResponseData
    extends TeacherAttachToAssignment200ResponseData {
  @override
  final int id;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final String title;
  @override
  final String instructions;
  @override
  final String dueAt;
  @override
  final bool published;
  @override
  final String? publishedAt;
  @override
  final bool hasAttachment;

  factory _$TeacherAttachToAssignment200ResponseData([
    void Function(TeacherAttachToAssignment200ResponseDataBuilder)? updates,
  ]) => (TeacherAttachToAssignment200ResponseDataBuilder()..update(updates))
      ._build();

  _$TeacherAttachToAssignment200ResponseData._({
    required this.id,
    required this.classRoomId,
    required this.subjectId,
    required this.title,
    required this.instructions,
    required this.dueAt,
    required this.published,
    this.publishedAt,
    required this.hasAttachment,
  }) : super._();
  @override
  TeacherAttachToAssignment200ResponseData rebuild(
    void Function(TeacherAttachToAssignment200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAttachToAssignment200ResponseDataBuilder toBuilder() =>
      TeacherAttachToAssignment200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAttachToAssignment200ResponseData &&
        id == other.id &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        title == other.title &&
        instructions == other.instructions &&
        dueAt == other.dueAt &&
        published == other.published &&
        publishedAt == other.publishedAt &&
        hasAttachment == other.hasAttachment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, instructions.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, published.hashCode);
    _$hash = $jc(_$hash, publishedAt.hashCode);
    _$hash = $jc(_$hash, hasAttachment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherAttachToAssignment200ResponseData',
          )
          ..add('id', id)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('title', title)
          ..add('instructions', instructions)
          ..add('dueAt', dueAt)
          ..add('published', published)
          ..add('publishedAt', publishedAt)
          ..add('hasAttachment', hasAttachment))
        .toString();
  }
}

class TeacherAttachToAssignment200ResponseDataBuilder
    implements
        Builder<
          TeacherAttachToAssignment200ResponseData,
          TeacherAttachToAssignment200ResponseDataBuilder
        > {
  _$TeacherAttachToAssignment200ResponseData? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _instructions;
  String? get instructions => _$this._instructions;
  set instructions(String? instructions) => _$this._instructions = instructions;

  String? _dueAt;
  String? get dueAt => _$this._dueAt;
  set dueAt(String? dueAt) => _$this._dueAt = dueAt;

  bool? _published;
  bool? get published => _$this._published;
  set published(bool? published) => _$this._published = published;

  String? _publishedAt;
  String? get publishedAt => _$this._publishedAt;
  set publishedAt(String? publishedAt) => _$this._publishedAt = publishedAt;

  bool? _hasAttachment;
  bool? get hasAttachment => _$this._hasAttachment;
  set hasAttachment(bool? hasAttachment) =>
      _$this._hasAttachment = hasAttachment;

  TeacherAttachToAssignment200ResponseDataBuilder() {
    TeacherAttachToAssignment200ResponseData._defaults(this);
  }

  TeacherAttachToAssignment200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _title = $v.title;
      _instructions = $v.instructions;
      _dueAt = $v.dueAt;
      _published = $v.published;
      _publishedAt = $v.publishedAt;
      _hasAttachment = $v.hasAttachment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAttachToAssignment200ResponseData other) {
    _$v = other as _$TeacherAttachToAssignment200ResponseData;
  }

  @override
  void update(
    void Function(TeacherAttachToAssignment200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAttachToAssignment200ResponseData build() => _build();

  _$TeacherAttachToAssignment200ResponseData _build() {
    final _$result =
        _$v ??
        _$TeacherAttachToAssignment200ResponseData._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TeacherAttachToAssignment200ResponseData',
            'id',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'TeacherAttachToAssignment200ResponseData',
            'classRoomId',
          ),
          subjectId: BuiltValueNullFieldError.checkNotNull(
            subjectId,
            r'TeacherAttachToAssignment200ResponseData',
            'subjectId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'TeacherAttachToAssignment200ResponseData',
            'title',
          ),
          instructions: BuiltValueNullFieldError.checkNotNull(
            instructions,
            r'TeacherAttachToAssignment200ResponseData',
            'instructions',
          ),
          dueAt: BuiltValueNullFieldError.checkNotNull(
            dueAt,
            r'TeacherAttachToAssignment200ResponseData',
            'dueAt',
          ),
          published: BuiltValueNullFieldError.checkNotNull(
            published,
            r'TeacherAttachToAssignment200ResponseData',
            'published',
          ),
          publishedAt: publishedAt,
          hasAttachment: BuiltValueNullFieldError.checkNotNull(
            hasAttachment,
            r'TeacherAttachToAssignment200ResponseData',
            'hasAttachment',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
