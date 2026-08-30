// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JournalEntry extends JournalEntry {
  @override
  final int id;
  @override
  final DateTime entryDate;
  @override
  final String referenceNo;
  @override
  final String description;
  @override
  final String type;
  @override
  final String accountCode;
  @override
  final String accountName;
  @override
  final String amount;
  @override
  final String source_;
  @override
  final int? sourceId;
  @override
  final int createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int? journalBatchId;
  @override
  final String? lineDescription;
  @override
  final String? costCenter;
  @override
  final int schoolId;

  factory _$JournalEntry([void Function(JournalEntryBuilder)? updates]) =>
      (JournalEntryBuilder()..update(updates))._build();

  _$JournalEntry._({
    required this.id,
    required this.entryDate,
    required this.referenceNo,
    required this.description,
    required this.type,
    required this.accountCode,
    required this.accountName,
    required this.amount,
    required this.source_,
    this.sourceId,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.journalBatchId,
    this.lineDescription,
    this.costCenter,
    required this.schoolId,
  }) : super._();
  @override
  JournalEntry rebuild(void Function(JournalEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JournalEntryBuilder toBuilder() => JournalEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JournalEntry &&
        id == other.id &&
        entryDate == other.entryDate &&
        referenceNo == other.referenceNo &&
        description == other.description &&
        type == other.type &&
        accountCode == other.accountCode &&
        accountName == other.accountName &&
        amount == other.amount &&
        source_ == other.source_ &&
        sourceId == other.sourceId &&
        createdBy == other.createdBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        deletedAt == other.deletedAt &&
        journalBatchId == other.journalBatchId &&
        lineDescription == other.lineDescription &&
        costCenter == other.costCenter &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, entryDate.hashCode);
    _$hash = $jc(_$hash, referenceNo.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, accountCode.hashCode);
    _$hash = $jc(_$hash, accountName.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, sourceId.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jc(_$hash, journalBatchId.hashCode);
    _$hash = $jc(_$hash, lineDescription.hashCode);
    _$hash = $jc(_$hash, costCenter.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'JournalEntry')
          ..add('id', id)
          ..add('entryDate', entryDate)
          ..add('referenceNo', referenceNo)
          ..add('description', description)
          ..add('type', type)
          ..add('accountCode', accountCode)
          ..add('accountName', accountName)
          ..add('amount', amount)
          ..add('source_', source_)
          ..add('sourceId', sourceId)
          ..add('createdBy', createdBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('deletedAt', deletedAt)
          ..add('journalBatchId', journalBatchId)
          ..add('lineDescription', lineDescription)
          ..add('costCenter', costCenter)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class JournalEntryBuilder
    implements Builder<JournalEntry, JournalEntryBuilder> {
  _$JournalEntry? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  DateTime? _entryDate;
  DateTime? get entryDate => _$this._entryDate;
  set entryDate(DateTime? entryDate) => _$this._entryDate = entryDate;

  String? _referenceNo;
  String? get referenceNo => _$this._referenceNo;
  set referenceNo(String? referenceNo) => _$this._referenceNo = referenceNo;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _accountCode;
  String? get accountCode => _$this._accountCode;
  set accountCode(String? accountCode) => _$this._accountCode = accountCode;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  int? _sourceId;
  int? get sourceId => _$this._sourceId;
  set sourceId(int? sourceId) => _$this._sourceId = sourceId;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _deletedAt;
  DateTime? get deletedAt => _$this._deletedAt;
  set deletedAt(DateTime? deletedAt) => _$this._deletedAt = deletedAt;

  int? _journalBatchId;
  int? get journalBatchId => _$this._journalBatchId;
  set journalBatchId(int? journalBatchId) =>
      _$this._journalBatchId = journalBatchId;

  String? _lineDescription;
  String? get lineDescription => _$this._lineDescription;
  set lineDescription(String? lineDescription) =>
      _$this._lineDescription = lineDescription;

  String? _costCenter;
  String? get costCenter => _$this._costCenter;
  set costCenter(String? costCenter) => _$this._costCenter = costCenter;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  JournalEntryBuilder() {
    JournalEntry._defaults(this);
  }

  JournalEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _entryDate = $v.entryDate;
      _referenceNo = $v.referenceNo;
      _description = $v.description;
      _type = $v.type;
      _accountCode = $v.accountCode;
      _accountName = $v.accountName;
      _amount = $v.amount;
      _source_ = $v.source_;
      _sourceId = $v.sourceId;
      _createdBy = $v.createdBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _deletedAt = $v.deletedAt;
      _journalBatchId = $v.journalBatchId;
      _lineDescription = $v.lineDescription;
      _costCenter = $v.costCenter;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JournalEntry other) {
    _$v = other as _$JournalEntry;
  }

  @override
  void update(void Function(JournalEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JournalEntry build() => _build();

  _$JournalEntry _build() {
    final _$result =
        _$v ??
        _$JournalEntry._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'JournalEntry', 'id'),
          entryDate: BuiltValueNullFieldError.checkNotNull(
            entryDate,
            r'JournalEntry',
            'entryDate',
          ),
          referenceNo: BuiltValueNullFieldError.checkNotNull(
            referenceNo,
            r'JournalEntry',
            'referenceNo',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'JournalEntry',
            'description',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'JournalEntry',
            'type',
          ),
          accountCode: BuiltValueNullFieldError.checkNotNull(
            accountCode,
            r'JournalEntry',
            'accountCode',
          ),
          accountName: BuiltValueNullFieldError.checkNotNull(
            accountName,
            r'JournalEntry',
            'accountName',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'JournalEntry',
            'amount',
          ),
          source_: BuiltValueNullFieldError.checkNotNull(
            source_,
            r'JournalEntry',
            'source_',
          ),
          sourceId: sourceId,
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'JournalEntry',
            'createdBy',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          journalBatchId: journalBatchId,
          lineDescription: lineDescription,
          costCenter: costCenter,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'JournalEntry',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
