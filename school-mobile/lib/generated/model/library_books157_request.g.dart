// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_books157_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LibraryBooks157Request extends LibraryBooks157Request {
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
  final int totalCopies;
  @override
  final String? location;

  factory _$LibraryBooks157Request([
    void Function(LibraryBooks157RequestBuilder)? updates,
  ]) => (LibraryBooks157RequestBuilder()..update(updates))._build();

  _$LibraryBooks157Request._({
    this.isbn,
    required this.title,
    required this.author,
    this.publisher,
    this.publicationYear,
    this.category,
    this.description,
    required this.totalCopies,
    this.location,
  }) : super._();
  @override
  LibraryBooks157Request rebuild(
    void Function(LibraryBooks157RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LibraryBooks157RequestBuilder toBuilder() =>
      LibraryBooks157RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LibraryBooks157Request &&
        isbn == other.isbn &&
        title == other.title &&
        author == other.author &&
        publisher == other.publisher &&
        publicationYear == other.publicationYear &&
        category == other.category &&
        description == other.description &&
        totalCopies == other.totalCopies &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, publisher.hashCode);
    _$hash = $jc(_$hash, publicationYear.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, totalCopies.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LibraryBooks157Request')
          ..add('isbn', isbn)
          ..add('title', title)
          ..add('author', author)
          ..add('publisher', publisher)
          ..add('publicationYear', publicationYear)
          ..add('category', category)
          ..add('description', description)
          ..add('totalCopies', totalCopies)
          ..add('location', location))
        .toString();
  }
}

class LibraryBooks157RequestBuilder
    implements Builder<LibraryBooks157Request, LibraryBooks157RequestBuilder> {
  _$LibraryBooks157Request? _$v;

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

  int? _totalCopies;
  int? get totalCopies => _$this._totalCopies;
  set totalCopies(int? totalCopies) => _$this._totalCopies = totalCopies;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  LibraryBooks157RequestBuilder() {
    LibraryBooks157Request._defaults(this);
  }

  LibraryBooks157RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isbn = $v.isbn;
      _title = $v.title;
      _author = $v.author;
      _publisher = $v.publisher;
      _publicationYear = $v.publicationYear;
      _category = $v.category;
      _description = $v.description;
      _totalCopies = $v.totalCopies;
      _location = $v.location;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LibraryBooks157Request other) {
    _$v = other as _$LibraryBooks157Request;
  }

  @override
  void update(void Function(LibraryBooks157RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LibraryBooks157Request build() => _build();

  _$LibraryBooks157Request _build() {
    final _$result =
        _$v ??
        _$LibraryBooks157Request._(
          isbn: isbn,
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'LibraryBooks157Request',
            'title',
          ),
          author: BuiltValueNullFieldError.checkNotNull(
            author,
            r'LibraryBooks157Request',
            'author',
          ),
          publisher: publisher,
          publicationYear: publicationYear,
          category: category,
          description: description,
          totalCopies: BuiltValueNullFieldError.checkNotNull(
            totalCopies,
            r'LibraryBooks157Request',
            'totalCopies',
          ),
          location: location,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
