// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_my_borrowings200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LibraryMyBorrowings200Response extends LibraryMyBorrowings200Response {
  @override
  final BuiltList<LibraryBorrowing> borrowings;
  @override
  final int activeCount;
  @override
  final int overdueCount;

  factory _$LibraryMyBorrowings200Response([
    void Function(LibraryMyBorrowings200ResponseBuilder)? updates,
  ]) => (LibraryMyBorrowings200ResponseBuilder()..update(updates))._build();

  _$LibraryMyBorrowings200Response._({
    required this.borrowings,
    required this.activeCount,
    required this.overdueCount,
  }) : super._();
  @override
  LibraryMyBorrowings200Response rebuild(
    void Function(LibraryMyBorrowings200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LibraryMyBorrowings200ResponseBuilder toBuilder() =>
      LibraryMyBorrowings200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LibraryMyBorrowings200Response &&
        borrowings == other.borrowings &&
        activeCount == other.activeCount &&
        overdueCount == other.overdueCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, borrowings.hashCode);
    _$hash = $jc(_$hash, activeCount.hashCode);
    _$hash = $jc(_$hash, overdueCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LibraryMyBorrowings200Response')
          ..add('borrowings', borrowings)
          ..add('activeCount', activeCount)
          ..add('overdueCount', overdueCount))
        .toString();
  }
}

class LibraryMyBorrowings200ResponseBuilder
    implements
        Builder<
          LibraryMyBorrowings200Response,
          LibraryMyBorrowings200ResponseBuilder
        > {
  _$LibraryMyBorrowings200Response? _$v;

  ListBuilder<LibraryBorrowing>? _borrowings;
  ListBuilder<LibraryBorrowing> get borrowings =>
      _$this._borrowings ??= ListBuilder<LibraryBorrowing>();
  set borrowings(ListBuilder<LibraryBorrowing>? borrowings) =>
      _$this._borrowings = borrowings;

  int? _activeCount;
  int? get activeCount => _$this._activeCount;
  set activeCount(int? activeCount) => _$this._activeCount = activeCount;

  int? _overdueCount;
  int? get overdueCount => _$this._overdueCount;
  set overdueCount(int? overdueCount) => _$this._overdueCount = overdueCount;

  LibraryMyBorrowings200ResponseBuilder() {
    LibraryMyBorrowings200Response._defaults(this);
  }

  LibraryMyBorrowings200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _borrowings = $v.borrowings.toBuilder();
      _activeCount = $v.activeCount;
      _overdueCount = $v.overdueCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LibraryMyBorrowings200Response other) {
    _$v = other as _$LibraryMyBorrowings200Response;
  }

  @override
  void update(void Function(LibraryMyBorrowings200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LibraryMyBorrowings200Response build() => _build();

  _$LibraryMyBorrowings200Response _build() {
    _$LibraryMyBorrowings200Response _$result;
    try {
      _$result =
          _$v ??
          _$LibraryMyBorrowings200Response._(
            borrowings: borrowings.build(),
            activeCount: BuiltValueNullFieldError.checkNotNull(
              activeCount,
              r'LibraryMyBorrowings200Response',
              'activeCount',
            ),
            overdueCount: BuiltValueNullFieldError.checkNotNull(
              overdueCount,
              r'LibraryMyBorrowings200Response',
              'overdueCount',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'borrowings';
        borrowings.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LibraryMyBorrowings200Response',
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
