// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_home200_response_data_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeHome200ResponseDataAnyOf1
    extends ParentHomeHome200ResponseDataAnyOf1 {
  @override
  final BuiltList<String> children;
  @override
  final int unreadCount;
  @override
  final String generatedAt;

  factory _$ParentHomeHome200ResponseDataAnyOf1([
    void Function(ParentHomeHome200ResponseDataAnyOf1Builder)? updates,
  ]) =>
      (ParentHomeHome200ResponseDataAnyOf1Builder()..update(updates))._build();

  _$ParentHomeHome200ResponseDataAnyOf1._({
    required this.children,
    required this.unreadCount,
    required this.generatedAt,
  }) : super._();
  @override
  ParentHomeHome200ResponseDataAnyOf1 rebuild(
    void Function(ParentHomeHome200ResponseDataAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeHome200ResponseDataAnyOf1Builder toBuilder() =>
      ParentHomeHome200ResponseDataAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeHome200ResponseDataAnyOf1 &&
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
    return (newBuiltValueToStringHelper(r'ParentHomeHome200ResponseDataAnyOf1')
          ..add('children', children)
          ..add('unreadCount', unreadCount)
          ..add('generatedAt', generatedAt))
        .toString();
  }
}

class ParentHomeHome200ResponseDataAnyOf1Builder
    implements
        Builder<
          ParentHomeHome200ResponseDataAnyOf1,
          ParentHomeHome200ResponseDataAnyOf1Builder
        > {
  _$ParentHomeHome200ResponseDataAnyOf1? _$v;

  ListBuilder<String>? _children;
  ListBuilder<String> get children =>
      _$this._children ??= ListBuilder<String>();
  set children(ListBuilder<String>? children) => _$this._children = children;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  String? _generatedAt;
  String? get generatedAt => _$this._generatedAt;
  set generatedAt(String? generatedAt) => _$this._generatedAt = generatedAt;

  ParentHomeHome200ResponseDataAnyOf1Builder() {
    ParentHomeHome200ResponseDataAnyOf1._defaults(this);
  }

  ParentHomeHome200ResponseDataAnyOf1Builder get _$this {
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
  void replace(ParentHomeHome200ResponseDataAnyOf1 other) {
    _$v = other as _$ParentHomeHome200ResponseDataAnyOf1;
  }

  @override
  void update(
    void Function(ParentHomeHome200ResponseDataAnyOf1Builder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeHome200ResponseDataAnyOf1 build() => _build();

  _$ParentHomeHome200ResponseDataAnyOf1 _build() {
    _$ParentHomeHome200ResponseDataAnyOf1 _$result;
    try {
      _$result =
          _$v ??
          _$ParentHomeHome200ResponseDataAnyOf1._(
            children: children.build(),
            unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount,
              r'ParentHomeHome200ResponseDataAnyOf1',
              'unreadCount',
            ),
            generatedAt: BuiltValueNullFieldError.checkNotNull(
              generatedAt,
              r'ParentHomeHome200ResponseDataAnyOf1',
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
          r'ParentHomeHome200ResponseDataAnyOf1',
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
