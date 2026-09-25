// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_borrowing.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LibraryBorrowing extends LibraryBorrowing {
  @override
  final int id;
  @override
  final int bookId;
  @override
  final int studentUserId;
  @override
  final DateTime borrowedDate;
  @override
  final DateTime dueDate;
  @override
  final DateTime? returnedDate;
  @override
  final String fineAmount;
  @override
  final bool isReturned;
  @override
  final int issuedBy;
  @override
  final int? returnedTo;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$LibraryBorrowing([
    void Function(LibraryBorrowingBuilder)? updates,
  ]) => (LibraryBorrowingBuilder()..update(updates))._build();

  _$LibraryBorrowing._({
    required this.id,
    required this.bookId,
    required this.studentUserId,
    required this.borrowedDate,
    required this.dueDate,
    this.returnedDate,
    required this.fineAmount,
    required this.isReturned,
    required this.issuedBy,
    this.returnedTo,
    this.notes,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  LibraryBorrowing rebuild(void Function(LibraryBorrowingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LibraryBorrowingBuilder toBuilder() =>
      LibraryBorrowingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LibraryBorrowing &&
        id == other.id &&
        bookId == other.bookId &&
        studentUserId == other.studentUserId &&
        borrowedDate == other.borrowedDate &&
        dueDate == other.dueDate &&
        returnedDate == other.returnedDate &&
        fineAmount == other.fineAmount &&
        isReturned == other.isReturned &&
        issuedBy == other.issuedBy &&
        returnedTo == other.returnedTo &&
        notes == other.notes &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, borrowedDate.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, returnedDate.hashCode);
    _$hash = $jc(_$hash, fineAmount.hashCode);
    _$hash = $jc(_$hash, isReturned.hashCode);
    _$hash = $jc(_$hash, issuedBy.hashCode);
    _$hash = $jc(_$hash, returnedTo.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LibraryBorrowing')
          ..add('id', id)
          ..add('bookId', bookId)
          ..add('studentUserId', studentUserId)
          ..add('borrowedDate', borrowedDate)
          ..add('dueDate', dueDate)
          ..add('returnedDate', returnedDate)
          ..add('fineAmount', fineAmount)
          ..add('isReturned', isReturned)
          ..add('issuedBy', issuedBy)
          ..add('returnedTo', returnedTo)
          ..add('notes', notes)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class LibraryBorrowingBuilder
    implements Builder<LibraryBorrowing, LibraryBorrowingBuilder> {
  _$LibraryBorrowing? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _bookId;
  int? get bookId => _$this._bookId;
  set bookId(int? bookId) => _$this._bookId = bookId;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  DateTime? _borrowedDate;
  DateTime? get borrowedDate => _$this._borrowedDate;
  set borrowedDate(DateTime? borrowedDate) =>
      _$this._borrowedDate = borrowedDate;

  DateTime? _dueDate;
  DateTime? get dueDate => _$this._dueDate;
  set dueDate(DateTime? dueDate) => _$this._dueDate = dueDate;

  DateTime? _returnedDate;
  DateTime? get returnedDate => _$this._returnedDate;
  set returnedDate(DateTime? returnedDate) =>
      _$this._returnedDate = returnedDate;

  String? _fineAmount;
  String? get fineAmount => _$this._fineAmount;
  set fineAmount(String? fineAmount) => _$this._fineAmount = fineAmount;

  bool? _isReturned;
  bool? get isReturned => _$this._isReturned;
  set isReturned(bool? isReturned) => _$this._isReturned = isReturned;

  int? _issuedBy;
  int? get issuedBy => _$this._issuedBy;
  set issuedBy(int? issuedBy) => _$this._issuedBy = issuedBy;

  int? _returnedTo;
  int? get returnedTo => _$this._returnedTo;
  set returnedTo(int? returnedTo) => _$this._returnedTo = returnedTo;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  LibraryBorrowingBuilder() {
    LibraryBorrowing._defaults(this);
  }

  LibraryBorrowingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _bookId = $v.bookId;
      _studentUserId = $v.studentUserId;
      _borrowedDate = $v.borrowedDate;
      _dueDate = $v.dueDate;
      _returnedDate = $v.returnedDate;
      _fineAmount = $v.fineAmount;
      _isReturned = $v.isReturned;
      _issuedBy = $v.issuedBy;
      _returnedTo = $v.returnedTo;
      _notes = $v.notes;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LibraryBorrowing other) {
    _$v = other as _$LibraryBorrowing;
  }

  @override
  void update(void Function(LibraryBorrowingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LibraryBorrowing build() => _build();

  _$LibraryBorrowing _build() {
    final _$result =
        _$v ??
        _$LibraryBorrowing._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'LibraryBorrowing',
            'id',
          ),
          bookId: BuiltValueNullFieldError.checkNotNull(
            bookId,
            r'LibraryBorrowing',
            'bookId',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'LibraryBorrowing',
            'studentUserId',
          ),
          borrowedDate: BuiltValueNullFieldError.checkNotNull(
            borrowedDate,
            r'LibraryBorrowing',
            'borrowedDate',
          ),
          dueDate: BuiltValueNullFieldError.checkNotNull(
            dueDate,
            r'LibraryBorrowing',
            'dueDate',
          ),
          returnedDate: returnedDate,
          fineAmount: BuiltValueNullFieldError.checkNotNull(
            fineAmount,
            r'LibraryBorrowing',
            'fineAmount',
          ),
          isReturned: BuiltValueNullFieldError.checkNotNull(
            isReturned,
            r'LibraryBorrowing',
            'isReturned',
          ),
          issuedBy: BuiltValueNullFieldError.checkNotNull(
            issuedBy,
            r'LibraryBorrowing',
            'issuedBy',
          ),
          returnedTo: returnedTo,
          notes: notes,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'LibraryBorrowing',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
