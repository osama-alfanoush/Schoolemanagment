// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_book.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LibraryBook extends LibraryBook {
  @override
  final int id;
  @override
  final String? isbn;
  @override
  final String title;
  @override
  final String author;
  @override
  final String? publisher;
  @override
  final int? publicationYear;
  @override
  final String? category;
  @override
  final String? description;
  @override
  final String? coverImage;
  @override
  final int totalCopies;
  @override
  final int availableCopies;
  @override
  final String? location;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$LibraryBook([void Function(LibraryBookBuilder)? updates]) =>
      (LibraryBookBuilder()..update(updates))._build();

  _$LibraryBook._({
    required this.id,
    this.isbn,
    required this.title,
    required this.author,
    this.publisher,
    this.publicationYear,
    this.category,
    this.description,
    this.coverImage,
    required this.totalCopies,
    required this.availableCopies,
    this.location,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  LibraryBook rebuild(void Function(LibraryBookBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LibraryBookBuilder toBuilder() => LibraryBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LibraryBook &&
        id == other.id &&
        isbn == other.isbn &&
        title == other.title &&
        author == other.author &&
        publisher == other.publisher &&
        publicationYear == other.publicationYear &&
        category == other.category &&
        description == other.description &&
        coverImage == other.coverImage &&
        totalCopies == other.totalCopies &&
        availableCopies == other.availableCopies &&
        location == other.location &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, publisher.hashCode);
    _$hash = $jc(_$hash, publicationYear.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, totalCopies.hashCode);
    _$hash = $jc(_$hash, availableCopies.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LibraryBook')
          ..add('id', id)
          ..add('isbn', isbn)
          ..add('title', title)
          ..add('author', author)
          ..add('publisher', publisher)
          ..add('publicationYear', publicationYear)
          ..add('category', category)
          ..add('description', description)
          ..add('coverImage', coverImage)
          ..add('totalCopies', totalCopies)
          ..add('availableCopies', availableCopies)
          ..add('location', location)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class LibraryBookBuilder implements Builder<LibraryBook, LibraryBookBuilder> {
  _$LibraryBook? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _isbn;
  String? get isbn => _$this._isbn;
  set isbn(String? isbn) => _$this._isbn = isbn;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _publisher;
  String? get publisher => _$this._publisher;
  set publisher(String? publisher) => _$this._publisher = publisher;

  int? _publicationYear;
  int? get publicationYear => _$this._publicationYear;
  set publicationYear(int? publicationYear) =>
      _$this._publicationYear = publicationYear;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  int? _totalCopies;
  int? get totalCopies => _$this._totalCopies;
  set totalCopies(int? totalCopies) => _$this._totalCopies = totalCopies;

  int? _availableCopies;
  int? get availableCopies => _$this._availableCopies;
  set availableCopies(int? availableCopies) =>
      _$this._availableCopies = availableCopies;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  LibraryBookBuilder() {
    LibraryBook._defaults(this);
  }

  LibraryBookBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _isbn = $v.isbn;
      _title = $v.title;
      _author = $v.author;
      _publisher = $v.publisher;
      _publicationYear = $v.publicationYear;
      _category = $v.category;
      _description = $v.description;
      _coverImage = $v.coverImage;
      _totalCopies = $v.totalCopies;
      _availableCopies = $v.availableCopies;
      _location = $v.location;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LibraryBook other) {
    _$v = other as _$LibraryBook;
  }

  @override
  void update(void Function(LibraryBookBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LibraryBook build() => _build();

  _$LibraryBook _build() {
    final _$result =
        _$v ??
        _$LibraryBook._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'LibraryBook', 'id'),
          isbn: isbn,
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'LibraryBook',
            'title',
          ),
          author: BuiltValueNullFieldError.checkNotNull(
            author,
            r'LibraryBook',
            'author',
          ),
          publisher: publisher,
          publicationYear: publicationYear,
          category: category,
          description: description,
          coverImage: coverImage,
          totalCopies: BuiltValueNullFieldError.checkNotNull(
            totalCopies,
            r'LibraryBook',
            'totalCopies',
          ),
          availableCopies: BuiltValueNullFieldError.checkNotNull(
            availableCopies,
            r'LibraryBook',
            'availableCopies',
          ),
          location: location,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'LibraryBook',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'LibraryBook',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
