// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_teacher_create_assignment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileTeacherCreateAssignmentRequest
    extends MobileTeacherCreateAssignmentRequest {
  @override
  final String idempotencyKey;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final String title;
  @override
  final String instructions;
  @override
  final DateTime dueAt;
  @override
  final num? maxScore;

  factory _$MobileTeacherCreateAssignmentRequest([
    void Function(MobileTeacherCreateAssignmentRequestBuilder)? updates,
  ]) =>
      (MobileTeacherCreateAssignmentRequestBuilder()..update(updates))._build();

  _$MobileTeacherCreateAssignmentRequest._({
    required this.idempotencyKey,
    required this.classRoomId,
    required this.subjectId,
    required this.title,
    required this.instructions,
    required this.dueAt,
    this.maxScore,
  }) : super._();
  @override
  MobileTeacherCreateAssignmentRequest rebuild(
    void Function(MobileTeacherCreateAssignmentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MobileTeacherCreateAssignmentRequestBuilder toBuilder() =>
      MobileTeacherCreateAssignmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileTeacherCreateAssignmentRequest &&
        idempotencyKey == other.idempotencyKey &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        title == other.title &&
        instructions == other.instructions &&
        dueAt == other.dueAt &&
        maxScore == other.maxScore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, instructions.hashCode);
    _$hash = $jc(_$hash, dueAt.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MobileTeacherCreateAssignmentRequest')
          ..add('idempotencyKey', idempotencyKey)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('title', title)
          ..add('instructions', instructions)
          ..add('dueAt', dueAt)
          ..add('maxScore', maxScore))
        .toString();
  }
}

class MobileTeacherCreateAssignmentRequestBuilder
    implements
        Builder<
          MobileTeacherCreateAssignmentRequest,
          MobileTeacherCreateAssignmentRequestBuilder
        > {
  _$MobileTeacherCreateAssignmentRequest? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

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

  DateTime? _dueAt;
  DateTime? get dueAt => _$this._dueAt;
  set dueAt(DateTime? dueAt) => _$this._dueAt = dueAt;

  num? _maxScore;
  num? get maxScore => _$this._maxScore;
  set maxScore(num? maxScore) => _$this._maxScore = maxScore;

  MobileTeacherCreateAssignmentRequestBuilder() {
    MobileTeacherCreateAssignmentRequest._defaults(this);
  }

  MobileTeacherCreateAssignmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _title = $v.title;
      _instructions = $v.instructions;
      _dueAt = $v.dueAt;
      _maxScore = $v.maxScore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MobileTeacherCreateAssignmentRequest other) {
    _$v = other as _$MobileTeacherCreateAssignmentRequest;
  }

  @override
  void update(
    void Function(MobileTeacherCreateAssignmentRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MobileTeacherCreateAssignmentRequest build() => _build();

  _$MobileTeacherCreateAssignmentRequest _build() {
    final _$result =
        _$v ??
        _$MobileTeacherCreateAssignmentRequest._(
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
            idempotencyKey,
            r'MobileTeacherCreateAssignmentRequest',
            'idempotencyKey',
          ),
          classRoomId: BuiltValueNullFieldError.checkNotNull(
            classRoomId,
            r'MobileTeacherCreateAssignmentRequest',
            'classRoomId',
          ),
          subjectId: BuiltValueNullFieldError.checkNotNull(
            subjectId,
            r'MobileTeacherCreateAssignmentRequest',
            'subjectId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'MobileTeacherCreateAssignmentRequest',
            'title',
          ),
          instructions: BuiltValueNullFieldError.checkNotNull(
            instructions,
            r'MobileTeacherCreateAssignmentRequest',
            'instructions',
          ),
          dueAt: BuiltValueNullFieldError.checkNotNull(
            dueAt,
            r'MobileTeacherCreateAssignmentRequest',
            'dueAt',
          ),
          maxScore: maxScore,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
