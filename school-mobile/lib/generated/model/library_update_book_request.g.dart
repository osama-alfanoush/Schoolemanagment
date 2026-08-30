// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_update_book_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LibraryUpdateBookRequest extends LibraryUpdateBookRequest {
  @override
  final String? title;
  @override
  final String? author;
  @override
  final int? totalCopies;
  @override
  final bool? isActive;

  factory _$LibraryUpdateBookRequest([
    void Function(LibraryUpdateBookRequestBuilder)? updates,
  ]) => (LibraryUpdateBookRequestBuilder()..update(updates))._build();

  _$LibraryUpdateBookRequest._({
    this.title,
    this.author,
    this.totalCopies,
    this.isActive,
  }) : super._();
  @override
  LibraryUpdateBookRequest rebuild(
    void Function(LibraryUpdateBookRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LibraryUpdateBookRequestBuilder toBuilder() =>
      LibraryUpdateBookRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LibraryUpdateBookRequest &&
        title == other.title &&
        author == other.author &&
        totalCopies == other.totalCopies &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, totalCopies.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LibraryUpdateBookRequest')
          ..add('title', title)
          ..add('author', author)
          ..add('totalCopies', totalCopies)
          ..add('isActive', isActive))
        .toString();
  }
}

class LibraryUpdateBookRequestBuilder
    implements
        Builder<LibraryUpdateBookRequest, LibraryUpdateBookRequestBuilder> {
  _$LibraryUpdateBookRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  int? _totalCopies;
  int? get totalCopies => _$this._totalCopies;
  set totalCopies(int? totalCopies) => _$this._totalCopies = totalCopies;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  LibraryUpdateBookRequestBuilder() {
    LibraryUpdateBookRequest._defaults(this);
  }

  LibraryUpdateBookRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _author = $v.author;
      _totalCopies = $v.totalCopies;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LibraryUpdateBookRequest other) {
    _$v = other as _$LibraryUpdateBookRequest;
  }

  @override
  void update(void Function(LibraryUpdateBookRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LibraryUpdateBookRequest build() => _build();

  _$LibraryUpdateBookRequest _build() {
    final _$result =
        _$v ??
        _$LibraryUpdateBookRequest._(
          title: title,
          author: author,
          totalCopies: totalCopies,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
