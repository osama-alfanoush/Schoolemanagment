// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_home200_response_data_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeHome200ResponseDataAnyOf
    extends ParentHomeHome200ResponseDataAnyOf {
  @override
  final BuiltList<JsonObject?> children;
  @override
  final int unreadCount;
  @override
  final String generatedAt;

  factory _$ParentHomeHome200ResponseDataAnyOf([
    void Function(ParentHomeHome200ResponseDataAnyOfBuilder)? updates,
  ]) => (ParentHomeHome200ResponseDataAnyOfBuilder()..update(updates))._build();

  _$ParentHomeHome200ResponseDataAnyOf._({
    required this.children,
    required this.unreadCount,
    required this.generatedAt,
  }) : super._();
  @override
  ParentHomeHome200ResponseDataAnyOf rebuild(
    void Function(ParentHomeHome200ResponseDataAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeHome200ResponseDataAnyOfBuilder toBuilder() =>
      ParentHomeHome200ResponseDataAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeHome200ResponseDataAnyOf &&
        children == other.children &&
        unreadCount == other.unreadCount &&
        generatedAt == other.generatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentHomeHome200ResponseDataAnyOf')
          ..add('children', children)
          ..add('unreadCount', unreadCount)
          ..add('generatedAt', generatedAt))
        .toString();
  }
}

class ParentHomeHome200ResponseDataAnyOfBuilder
    implements
        Builder<
          ParentHomeHome200ResponseDataAnyOf,
          ParentHomeHome200ResponseDataAnyOfBuilder
        > {
  _$ParentHomeHome200ResponseDataAnyOf? _$v;

  ListBuilder<JsonObject?>? _children;
  ListBuilder<JsonObject?> get children =>
      _$this._children ??= ListBuilder<JsonObject?>();
  set children(ListBuilder<JsonObject?>? children) =>
      _$this._children = children;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  String? _generatedAt;
  String? get generatedAt => _$this._generatedAt;
  set generatedAt(String? generatedAt) => _$this._generatedAt = generatedAt;

  ParentHomeHome200ResponseDataAnyOfBuilder() {
    ParentHomeHome200ResponseDataAnyOf._defaults(this);
  }

  ParentHomeHome200ResponseDataAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _children = $v.children.toBuilder();
      _unreadCount = $v.unreadCount;
      _generatedAt = $v.generatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeHome200ResponseDataAnyOf other) {
    _$v = other as _$ParentHomeHome200ResponseDataAnyOf;
  }

  @override
  void update(
    void Function(ParentHomeHome200ResponseDataAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeHome200ResponseDataAnyOf build() => _build();

  _$ParentHomeHome200ResponseDataAnyOf _build() {
    _$ParentHomeHome200ResponseDataAnyOf _$result;
    try {
      _$result =
          _$v ??
          _$ParentHomeHome200ResponseDataAnyOf._(
            children: children.build(),
            unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount,
              r'ParentHomeHome200ResponseDataAnyOf',
              'unreadCount',
            ),
            generatedAt: BuiltValueNullFieldError.checkNotNull(
              generatedAt,
              r'ParentHomeHome200ResponseDataAnyOf',
              'generatedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentHomeHome200ResponseDataAnyOf',
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
