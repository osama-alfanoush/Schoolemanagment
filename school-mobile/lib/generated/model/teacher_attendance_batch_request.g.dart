// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_attendance_batch_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAttendanceBatchRequest extends TeacherAttendanceBatchRequest {
  @override
  final String idempotencyKey;
  @override
  final int classRoomId;
  @override
  final int? subjectId;
  @override
  final int? courseSectionId;
  @override
  final DateTime date;
  @override
  final BuiltList<TeacherAttendanceBatchRequestRecordsInner> records;

  factory _$TeacherAttendanceBatchRequest([
    void Function(TeacherAttendanceBatchRequestBuilder)? updates,
  ]) => (TeacherAttendanceBatchRequestBuilder()..update(updates))._build();

  _$TeacherAttendanceBatchRequest._({
    required this.idempotencyKey,
    required this.classRoomId,
    this.subjectId,
    this.courseSectionId,
    required this.date,
    required this.records,
  }) : super._();
  @override
  TeacherAttendanceBatchRequest rebuild(
    void Function(TeacherAttendanceBatchRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAttendanceBatchRequestBuilder toBuilder() =>
      TeacherAttendanceBatchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAttendanceBatchRequest &&
        idempotencyKey == other.idempotencyKey &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        courseSectionId == other.courseSectionId &&
        date == other.date &&
        records == other.records;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, courseSectionId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherAttendanceBatchRequest')
          ..add('idempotencyKey', idempotencyKey)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('courseSectionId', courseSectionId)
          ..add('date', date)
          ..add('records', records))
        .toString();
  }
}

class TeacherAttendanceBatchRequestBuilder
    implements
        Builder<
          TeacherAttendanceBatchRequest,
          TeacherAttendanceBatchRequestBuilder
        > {
  _$TeacherAttendanceBatchRequest? _$v;

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

  int? _courseSectionId;
  int? get courseSectionId => _$this._courseSectionId;
  set courseSectionId(int? courseSectionId) =>
      _$this._courseSectionId = courseSectionId;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  ListBuilder<TeacherAttendanceBatchRequestRecordsInner>? _records;
  ListBuilder<TeacherAttendanceBatchRequestRecordsInner> get records =>
      _$this._records ??=
          ListBuilder<TeacherAttendanceBatchRequestRecordsInner>();
  set records(
    ListBuilder<TeacherAttendanceBatchRequestRecordsInner>? records,
  ) => _$this._records = records;

  TeacherAttendanceBatchRequestBuilder() {
    TeacherAttendanceBatchRequest._defaults(this);
  }

  TeacherAttendanceBatchRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _courseSectionId = $v.courseSectionId;
      _date = $v.date;
      _records = $v.records.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAttendanceBatchRequest other) {
    _$v = other as _$TeacherAttendanceBatchRequest;
  }

  @override
  void update(void Function(TeacherAttendanceBatchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAttendanceBatchRequest build() => _build();

  _$TeacherAttendanceBatchRequest _build() {
    _$TeacherAttendanceBatchRequest _$result;
    try {
      _$result =
          _$v ??
          _$TeacherAttendanceBatchRequest._(
            idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey,
              r'TeacherAttendanceBatchRequest',
              'idempotencyKey',
            ),
            classRoomId: BuiltValueNullFieldError.checkNotNull(
              classRoomId,
              r'TeacherAttendanceBatchRequest',
              'classRoomId',
            ),
            subjectId: subjectId,
            courseSectionId: courseSectionId,
            date: BuiltValueNullFieldError.checkNotNull(
              date,
              r'TeacherAttendanceBatchRequest',
              'date',
            ),
            records: records.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        records.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAttendanceBatchRequest',
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
