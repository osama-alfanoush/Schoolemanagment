// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_roster200_response_data_students_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherRoster200ResponseDataStudentsInner
    extends TeacherRoster200ResponseDataStudentsInner {
  @override
  final int studentUserId;
  @override
  final String name;
  @override
  final String admissionNo;
  @override
  final String hasPhoto;
  @override
  final BuiltList<BuiltMap<String, JsonObject?>> guardians;
  @override
  final String? status;
  @override
  final String? note;
  @override
  final String? scopeKey;

  factory _$TeacherRoster200ResponseDataStudentsInner([
    void Function(TeacherRoster200ResponseDataStudentsInnerBuilder)? updates,
  ]) => (TeacherRoster200ResponseDataStudentsInnerBuilder()..update(updates))
      ._build();

  _$TeacherRoster200ResponseDataStudentsInner._({
    required this.studentUserId,
    required this.name,
    required this.admissionNo,
    required this.hasPhoto,
    required this.guardians,
    this.status,
    this.note,
    this.scopeKey,
  }) : super._();
  @override
  TeacherRoster200ResponseDataStudentsInner rebuild(
    void Function(TeacherRoster200ResponseDataStudentsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherRoster200ResponseDataStudentsInnerBuilder toBuilder() =>
      TeacherRoster200ResponseDataStudentsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherRoster200ResponseDataStudentsInner &&
        studentUserId == other.studentUserId &&
        name == other.name &&
        admissionNo == other.admissionNo &&
        hasPhoto == other.hasPhoto &&
        guardians == other.guardians &&
        status == other.status &&
        note == other.note &&
        scopeKey == other.scopeKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, admissionNo.hashCode);
    _$hash = $jc(_$hash, hasPhoto.hashCode);
    _$hash = $jc(_$hash, guardians.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherRoster200ResponseDataStudentsInner',
          )
          ..add('studentUserId', studentUserId)
          ..add('name', name)
          ..add('admissionNo', admissionNo)
          ..add('hasPhoto', hasPhoto)
          ..add('guardians', guardians)
          ..add('status', status)
          ..add('note', note)
          ..add('scopeKey', scopeKey))
        .toString();
  }
}

class TeacherRoster200ResponseDataStudentsInnerBuilder
    implements
        Builder<
          TeacherRoster200ResponseDataStudentsInner,
          TeacherRoster200ResponseDataStudentsInnerBuilder
        > {
  _$TeacherRoster200ResponseDataStudentsInner? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _admissionNo;
  String? get admissionNo => _$this._admissionNo;
  set admissionNo(String? admissionNo) => _$this._admissionNo = admissionNo;

  String? _hasPhoto;
  String? get hasPhoto => _$this._hasPhoto;
  set hasPhoto(String? hasPhoto) => _$this._hasPhoto = hasPhoto;

  ListBuilder<BuiltMap<String, JsonObject?>>? _guardians;
  ListBuilder<BuiltMap<String, JsonObject?>> get guardians =>
      _$this._guardians ??= ListBuilder<BuiltMap<String, JsonObject?>>();
  set guardians(ListBuilder<BuiltMap<String, JsonObject?>>? guardians) =>
      _$this._guardians = guardians;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  TeacherRoster200ResponseDataStudentsInnerBuilder() {
    TeacherRoster200ResponseDataStudentsInner._defaults(this);
  }

  TeacherRoster200ResponseDataStudentsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _name = $v.name;
      _admissionNo = $v.admissionNo;
      _hasPhoto = $v.hasPhoto;
      _guardians = $v.guardians.toBuilder();
      _status = $v.status;
      _note = $v.note;
      _scopeKey = $v.scopeKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherRoster200ResponseDataStudentsInner other) {
    _$v = other as _$TeacherRoster200ResponseDataStudentsInner;
  }

  @override
  void update(
    void Function(TeacherRoster200ResponseDataStudentsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherRoster200ResponseDataStudentsInner build() => _build();

  _$TeacherRoster200ResponseDataStudentsInner _build() {
    _$TeacherRoster200ResponseDataStudentsInner _$result;
    try {
      _$result =
          _$v ??
          _$TeacherRoster200ResponseDataStudentsInner._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'TeacherRoster200ResponseDataStudentsInner',
              'studentUserId',
            ),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'TeacherRoster200ResponseDataStudentsInner',
              'name',
            ),
            admissionNo: BuiltValueNullFieldError.checkNotNull(
              admissionNo,
              r'TeacherRoster200ResponseDataStudentsInner',
              'admissionNo',
            ),
            hasPhoto: BuiltValueNullFieldError.checkNotNull(
              hasPhoto,
              r'TeacherRoster200ResponseDataStudentsInner',
              'hasPhoto',
            ),
            guardians: guardians.build(),
            status: status,
            note: note,
            scopeKey: scopeKey,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'guardians';
        guardians.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherRoster200ResponseDataStudentsInner',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
