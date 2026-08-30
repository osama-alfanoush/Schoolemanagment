// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_batch.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JournalBatch extends JournalBatch {
  @override
  final int id;
  @override
  final String referenceNo;
  @override
  final DateTime entryDate;
  @override
  final String description;
  @override
  final String source_;
  @override
  final int? sourceId;
  @override
  final int? academicYearId;
  @override
  final String? branchReference;
  @override
  final String status;
  @override
  final int createdBy;
  @override
  final int? approvedBy;
  @override
  final int? postedBy;
  @override
  final int? reversedBy;
  @override
  final int? reversalOfId;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? postedAt;
  @override
  final DateTime? reversedAt;
  @override
  final String? reversalReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? idempotencyKey;
  @override
  final int schoolId;

  factory _$JournalBatch([void Function(JournalBatchBuilder)? updates]) =>
      (JournalBatchBuilder()..update(updates))._build();

  _$JournalBatch._({
    required this.id,
    required this.referenceNo,
    required this.entryDate,
    required this.description,
    required this.source_,
    this.sourceId,
    this.academicYearId,
    this.branchReference,
    required this.status,
    required this.createdBy,
    this.approvedBy,
    this.postedBy,
    this.reversedBy,
    this.reversalOfId,
    this.approvedAt,
    this.postedAt,
    this.reversedAt,
    this.reversalReason,
    this.createdAt,
    this.updatedAt,
    this.idempotencyKey,
    required this.schoolId,
  }) : super._();
  @override
  JournalBatch rebuild(void Function(JournalBatchBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JournalBatchBuilder toBuilder() => JournalBatchBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JournalBatch &&
        id == other.id &&
        referenceNo == other.referenceNo &&
        entryDate == other.entryDate &&
        description == other.description &&
        source_ == other.source_ &&
        sourceId == other.sourceId &&
        academicYearId == other.academicYearId &&
        branchReference == other.branchReference &&
        status == other.status &&
        createdBy == other.createdBy &&
        approvedBy == other.approvedBy &&
        postedBy == other.postedBy &&
        reversedBy == other.reversedBy &&
        reversalOfId == other.reversalOfId &&
        approvedAt == other.approvedAt &&
        postedAt == other.postedAt &&
        reversedAt == other.reversedAt &&
        reversalReason == other.reversalReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        idempotencyKey == other.idempotencyKey &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, referenceNo.hashCode);
    _$hash = $jc(_$hash, entryDate.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, academicYearId.hashCode);
    _$hash = $jc(_$hash, branchReference.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, postedBy.hashCode);
    _$hash = $jc(_$hash, reversedBy.hashCode);
    _$hash = $jc(_$hash, reversalOfId.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, reversedAt.hashCode);
    _$hash = $jc(_$hash, reversalReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'JournalBatch')
          ..add('id', id)
          ..add('referenceNo', referenceNo)
          ..add('entryDate', entryDate)
          ..add('description', description)
          ..add('source_', source_)
          ..add('sourceId', sourceId)
          ..add('academicYearId', academicYearId)
          ..add('branchReference', branchReference)
          ..add('status', status)
          ..add('createdBy', createdBy)
          ..add('approvedBy', approvedBy)
          ..add('postedBy', postedBy)
          ..add('reversedBy', reversedBy)
          ..add('reversalOfId', reversalOfId)
          ..add('approvedAt', approvedAt)
          ..add('postedAt', postedAt)
          ..add('reversedAt', reversedAt)
          ..add('reversalReason', reversalReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('idempotencyKey', idempotencyKey)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class JournalBatchBuilder
    implements Builder<JournalBatch, JournalBatchBuilder> {
  _$JournalBatch? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _referenceNo;
  String? get referenceNo => _$this._referenceNo;
  set referenceNo(String? referenceNo) => _$this._referenceNo = referenceNo;

  DateTime? _entryDate;
  DateTime? get entryDate => _$this._entryDate;
  set entryDate(DateTime? entryDate) => _$this._entryDate = entryDate;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  int? _sourceId;
  int? get sourceId => _$this._sourceId;
  set sourceId(int? sourceId) => _$this._sourceId = sourceId;

  int? _academicYearId;
  int? get academicYearId => _$this._academicYearId;
  set academicYearId(int? academicYearId) =>
      _$this._academicYearId = academicYearId;

  String? _branchReference;
  String? get branchReference => _$this._branchReference;
  set branchReference(String? branchReference) =>
      _$this._branchReference = branchReference;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  int? _postedBy;
  int? get postedBy => _$this._postedBy;
  set postedBy(int? postedBy) => _$this._postedBy = postedBy;

  int? _reversedBy;
  int? get reversedBy => _$this._reversedBy;
  set reversedBy(int? reversedBy) => _$this._reversedBy = reversedBy;

  int? _reversalOfId;
  int? get reversalOfId => _$this._reversalOfId;
  set reversalOfId(int? reversalOfId) => _$this._reversalOfId = reversalOfId;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _postedAt;
  DateTime? get postedAt => _$this._postedAt;
  set postedAt(DateTime? postedAt) => _$this._postedAt = postedAt;

  DateTime? _reversedAt;
  DateTime? get reversedAt => _$this._reversedAt;
  set reversedAt(DateTime? reversedAt) => _$this._reversedAt = reversedAt;

  String? _reversalReason;
  String? get reversalReason => _$this._reversalReason;
  set reversalReason(String? reversalReason) =>
      _$this._reversalReason = reversalReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  JournalBatchBuilder() {
    JournalBatch._defaults(this);
  }

  JournalBatchBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _referenceNo = $v.referenceNo;
      _entryDate = $v.entryDate;
      _description = $v.description;
      _source_ = $v.source_;
      _sourceId = $v.sourceId;
      _academicYearId = $v.academicYearId;
      _branchReference = $v.branchReference;
      _status = $v.status;
      _createdBy = $v.createdBy;
      _approvedBy = $v.approvedBy;
      _postedBy = $v.postedBy;
      _reversedBy = $v.reversedBy;
      _reversalOfId = $v.reversalOfId;
      _approvedAt = $v.approvedAt;
      _postedAt = $v.postedAt;
      _reversedAt = $v.reversedAt;
      _reversalReason = $v.reversalReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _idempotencyKey = $v.idempotencyKey;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JournalBatch other) {
    _$v = other as _$JournalBatch;
  }

  @override
  void update(void Function(JournalBatchBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JournalBatch build() => _build();

  _$JournalBatch _build() {
    final _$result =
        _$v ??
        _$JournalBatch._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'JournalBatch', 'id'),
          referenceNo: BuiltValueNullFieldError.checkNotNull(
            referenceNo,
            r'JournalBatch',
            'referenceNo',
          ),
          entryDate: BuiltValueNullFieldError.checkNotNull(
            entryDate,
            r'JournalBatch',
            'entryDate',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'JournalBatch',
            'description',
          ),
          source_: BuiltValueNullFieldError.checkNotNull(
            source_,
            r'JournalBatch',
            'source_',
          ),
          sourceId: sourceId,
          academicYearId: academicYearId,
          branchReference: branchReference,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'JournalBatch',
            'status',
          ),
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'JournalBatch',
            'createdBy',
          ),
          approvedBy: approvedBy,
          postedBy: postedBy,
          reversedBy: reversedBy,
          reversalOfId: reversalOfId,
          approvedAt: approvedAt,
          postedAt: postedAt,
          reversedAt: reversedAt,
          reversalReason: reversalReason,
          createdAt: createdAt,
          updatedAt: updatedAt,
          idempotencyKey: idempotencyKey,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'JournalBatch',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
