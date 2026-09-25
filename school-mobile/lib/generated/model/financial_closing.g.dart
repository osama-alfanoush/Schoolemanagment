// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_closing.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialClosing extends FinancialClosing {
  @override
  final int id;
  @override
  final int month;
  @override
  final int year;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final int? closedBy;
  @override
  final DateTime? closedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$FinancialClosing([
    void Function(FinancialClosingBuilder)? updates,
  ]) => (FinancialClosingBuilder()..update(updates))._build();

  _$FinancialClosing._({
    required this.id,
    required this.month,
    required this.year,
    required this.status,
    this.notes,
    this.closedBy,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  FinancialClosing rebuild(void Function(FinancialClosingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialClosingBuilder toBuilder() =>
      FinancialClosingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialClosing &&
        id == other.id &&
        month == other.month &&
        year == other.year &&
        status == other.status &&
        notes == other.notes &&
        closedBy == other.closedBy &&
        closedAt == other.closedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, closedBy.hashCode);
    _$hash = $jc(_$hash, closedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialClosing')
          ..add('id', id)
          ..add('month', month)
          ..add('year', year)
          ..add('status', status)
          ..add('notes', notes)
          ..add('closedBy', closedBy)
          ..add('closedAt', closedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class FinancialClosingBuilder
    implements Builder<FinancialClosing, FinancialClosingBuilder> {
  _$FinancialClosing? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _closedBy;
  int? get closedBy => _$this._closedBy;
  set closedBy(int? closedBy) => _$this._closedBy = closedBy;

  DateTime? _closedAt;
  DateTime? get closedAt => _$this._closedAt;
  set closedAt(DateTime? closedAt) => _$this._closedAt = closedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  FinancialClosingBuilder() {
    FinancialClosing._defaults(this);
  }

  FinancialClosingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _month = $v.month;
      _year = $v.year;
      _status = $v.status;
      _notes = $v.notes;
      _closedBy = $v.closedBy;
      _closedAt = $v.closedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialClosing other) {
    _$v = other as _$FinancialClosing;
  }

  @override
  void update(void Function(FinancialClosingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialClosing build() => _build();

  _$FinancialClosing _build() {
    final _$result =
        _$v ??
        _$FinancialClosing._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'FinancialClosing',
            'id',
          ),
          month: BuiltValueNullFieldError.checkNotNull(
            month,
            r'FinancialClosing',
            'month',
          ),
          year: BuiltValueNullFieldError.checkNotNull(
            year,
            r'FinancialClosing',
            'year',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'FinancialClosing',
            'status',
          ),
          notes: notes,
          closedBy: closedBy,
          closedAt: closedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'FinancialClosing',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
