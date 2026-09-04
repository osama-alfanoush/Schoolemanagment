// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delta_page_resource.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeltaPageResource extends DeltaPageResource {
  @override
  final BuiltList<DeltaChangeResource> changes;
  @override
  final String nextCursor;
  @override
  final bool hasMore;
  @override
  final String types;

  factory _$DeltaPageResource([
    void Function(DeltaPageResourceBuilder)? updates,
  ]) => (DeltaPageResourceBuilder()..update(updates))._build();

  _$DeltaPageResource._({
    required this.changes,
    required this.nextCursor,
    required this.hasMore,
    required this.types,
  }) : super._();
  @override
  DeltaPageResource rebuild(void Function(DeltaPageResourceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeltaPageResourceBuilder toBuilder() =>
      DeltaPageResourceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeltaPageResource &&
        changes == other.changes &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore &&
        types == other.types;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, changes.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeltaPageResource')
          ..add('changes', changes)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore)
          ..add('types', types))
        .toString();
  }
}

class DeltaPageResourceBuilder
    implements Builder<DeltaPageResource, DeltaPageResourceBuilder> {
  _$DeltaPageResource? _$v;

  ListBuilder<DeltaChangeResource>? _changes;
  ListBuilder<DeltaChangeResource> get changes =>
      _$this._changes ??= ListBuilder<DeltaChangeResource>();
  set changes(ListBuilder<DeltaChangeResource>? changes) =>
      _$this._changes = changes;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  String? _types;
  String? get types => _$this._types;
  set types(String? types) => _$this._types = types;

  DeltaPageResourceBuilder() {
    DeltaPageResource._defaults(this);
  }

  DeltaPageResourceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _changes = $v.changes.toBuilder();
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _types = $v.types;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeltaPageResource other) {
    _$v = other as _$DeltaPageResource;
  }

  @override
  void update(void Function(DeltaPageResourceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeltaPageResource build() => _build();

  _$DeltaPageResource _build() {
    _$DeltaPageResource _$result;
    try {
      _$result =
          _$v ??
          _$DeltaPageResource._(
            changes: changes.build(),
            nextCursor: BuiltValueNullFieldError.checkNotNull(
              nextCursor,
              r'DeltaPageResource',
              'nextCursor',
            ),
            hasMore: BuiltValueNullFieldError.checkNotNull(
              hasMore,
              r'DeltaPageResource',
              'hasMore',
            ),
            types: BuiltValueNullFieldError.checkNotNull(
              types,
              r'DeltaPageResource',
              'types',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'changes';
        changes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DeltaPageResource',
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
