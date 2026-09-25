// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_update_preferences_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxUpdatePreferencesRequest
    extends ParentInboxUpdatePreferencesRequest {
  @override
  final BuiltList<bool>? categories;
  @override
  final bool? pushEnabled;

  factory _$ParentInboxUpdatePreferencesRequest([
    void Function(ParentInboxUpdatePreferencesRequestBuilder)? updates,
  ]) =>
      (ParentInboxUpdatePreferencesRequestBuilder()..update(updates))._build();

  _$ParentInboxUpdatePreferencesRequest._({this.categories, this.pushEnabled})
    : super._();
  @override
  ParentInboxUpdatePreferencesRequest rebuild(
    void Function(ParentInboxUpdatePreferencesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxUpdatePreferencesRequestBuilder toBuilder() =>
      ParentInboxUpdatePreferencesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxUpdatePreferencesRequest &&
        categories == other.categories &&
        pushEnabled == other.pushEnabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, pushEnabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInboxUpdatePreferencesRequest')
          ..add('categories', categories)
          ..add('pushEnabled', pushEnabled))
        .toString();
  }
}

class ParentInboxUpdatePreferencesRequestBuilder
    implements
        Builder<
          ParentInboxUpdatePreferencesRequest,
          ParentInboxUpdatePreferencesRequestBuilder
        > {
  _$ParentInboxUpdatePreferencesRequest? _$v;

  ListBuilder<bool>? _categories;
  ListBuilder<bool> get categories =>
      _$this._categories ??= ListBuilder<bool>();
  set categories(ListBuilder<bool>? categories) =>
      _$this._categories = categories;

  bool? _pushEnabled;
  bool? get pushEnabled => _$this._pushEnabled;
  set pushEnabled(bool? pushEnabled) => _$this._pushEnabled = pushEnabled;

  ParentInboxUpdatePreferencesRequestBuilder() {
    ParentInboxUpdatePreferencesRequest._defaults(this);
  }

  ParentInboxUpdatePreferencesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categories = $v.categories?.toBuilder();
      _pushEnabled = $v.pushEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxUpdatePreferencesRequest other) {
    _$v = other as _$ParentInboxUpdatePreferencesRequest;
  }

  @override
  void update(
    void Function(ParentInboxUpdatePreferencesRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxUpdatePreferencesRequest build() => _build();

  _$ParentInboxUpdatePreferencesRequest _build() {
    _$ParentInboxUpdatePreferencesRequest _$result;
    try {
      _$result =
          _$v ??
          _$ParentInboxUpdatePreferencesRequest._(
            categories: _categories?.build(),
            pushEnabled: pushEnabled,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        _categories?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxUpdatePreferencesRequest',
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
