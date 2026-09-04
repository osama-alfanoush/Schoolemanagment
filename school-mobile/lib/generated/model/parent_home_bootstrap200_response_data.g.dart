// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_bootstrap200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeBootstrap200ResponseData
    extends ParentHomeBootstrap200ResponseData {
  @override
  final ParentHomeBootstrap200ResponseDataUser user;
  @override
  final BuiltList<JsonObject?> roles;
  @override
  final BuiltList<BuiltMap<String, JsonObject?>> children;
  @override
  final ParentHomeBootstrap200ResponseDataTheme theme;
  @override
  final BuiltList<JsonObject?> features;
  @override
  final int unreadCount;
  @override
  final String minSupportedVersion;
  @override
  final String recommendedVersion;
  @override
  final bool forceUpgrade;

  factory _$ParentHomeBootstrap200ResponseData([
    void Function(ParentHomeBootstrap200ResponseDataBuilder)? updates,
  ]) => (ParentHomeBootstrap200ResponseDataBuilder()..update(updates))._build();

  _$ParentHomeBootstrap200ResponseData._({
    required this.user,
    required this.roles,
    required this.children,
    required this.theme,
    required this.features,
    required this.unreadCount,
    required this.minSupportedVersion,
    required this.recommendedVersion,
    required this.forceUpgrade,
  }) : super._();
  @override
  ParentHomeBootstrap200ResponseData rebuild(
    void Function(ParentHomeBootstrap200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeBootstrap200ResponseDataBuilder toBuilder() =>
      ParentHomeBootstrap200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeBootstrap200ResponseData &&
        user == other.user &&
        roles == other.roles &&
        children == other.children &&
        theme == other.theme &&
        features == other.features &&
        unreadCount == other.unreadCount &&
        minSupportedVersion == other.minSupportedVersion &&
        recommendedVersion == other.recommendedVersion &&
        forceUpgrade == other.forceUpgrade;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jc(_$hash, children.hashCode);
    _$hash = $jc(_$hash, theme.hashCode);
    _$hash = $jc(_$hash, features.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jc(_$hash, minSupportedVersion.hashCode);
    _$hash = $jc(_$hash, recommendedVersion.hashCode);
    _$hash = $jc(_$hash, forceUpgrade.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentHomeBootstrap200ResponseData')
          ..add('user', user)
          ..add('roles', roles)
          ..add('children', children)
          ..add('theme', theme)
          ..add('features', features)
          ..add('unreadCount', unreadCount)
          ..add('minSupportedVersion', minSupportedVersion)
          ..add('recommendedVersion', recommendedVersion)
          ..add('forceUpgrade', forceUpgrade))
        .toString();
  }
}

class ParentHomeBootstrap200ResponseDataBuilder
    implements
        Builder<
          ParentHomeBootstrap200ResponseData,
          ParentHomeBootstrap200ResponseDataBuilder
        > {
  _$ParentHomeBootstrap200ResponseData? _$v;

  ParentHomeBootstrap200ResponseDataUserBuilder? _user;
  ParentHomeBootstrap200ResponseDataUserBuilder get user =>
      _$this._user ??= ParentHomeBootstrap200ResponseDataUserBuilder();
  set user(ParentHomeBootstrap200ResponseDataUserBuilder? user) =>
      _$this._user = user;

  ListBuilder<JsonObject?>? _roles;
  ListBuilder<JsonObject?> get roles =>
      _$this._roles ??= ListBuilder<JsonObject?>();
  set roles(ListBuilder<JsonObject?>? roles) => _$this._roles = roles;

  ListBuilder<BuiltMap<String, JsonObject?>>? _children;
  ListBuilder<BuiltMap<String, JsonObject?>> get children =>
      _$this._children ??= ListBuilder<BuiltMap<String, JsonObject?>>();
  set children(ListBuilder<BuiltMap<String, JsonObject?>>? children) =>
      _$this._children = children;

  ParentHomeBootstrap200ResponseDataThemeBuilder? _theme;
  ParentHomeBootstrap200ResponseDataThemeBuilder get theme =>
      _$this._theme ??= ParentHomeBootstrap200ResponseDataThemeBuilder();
  set theme(ParentHomeBootstrap200ResponseDataThemeBuilder? theme) =>
      _$this._theme = theme;

  ListBuilder<JsonObject?>? _features;
  ListBuilder<JsonObject?> get features =>
      _$this._features ??= ListBuilder<JsonObject?>();
  set features(ListBuilder<JsonObject?>? features) =>
      _$this._features = features;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  String? _minSupportedVersion;
  String? get minSupportedVersion => _$this._minSupportedVersion;
  set minSupportedVersion(String? minSupportedVersion) =>
      _$this._minSupportedVersion = minSupportedVersion;

  String? _recommendedVersion;
  String? get recommendedVersion => _$this._recommendedVersion;
  set recommendedVersion(String? recommendedVersion) =>
      _$this._recommendedVersion = recommendedVersion;

  bool? _forceUpgrade;
  bool? get forceUpgrade => _$this._forceUpgrade;
  set forceUpgrade(bool? forceUpgrade) => _$this._forceUpgrade = forceUpgrade;

  ParentHomeBootstrap200ResponseDataBuilder() {
    ParentHomeBootstrap200ResponseData._defaults(this);
  }

  ParentHomeBootstrap200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _user = $v.user.toBuilder();
      _roles = $v.roles.toBuilder();
      _children = $v.children.toBuilder();
      _theme = $v.theme.toBuilder();
      _features = $v.features.toBuilder();
      _unreadCount = $v.unreadCount;
      _minSupportedVersion = $v.minSupportedVersion;
      _recommendedVersion = $v.recommendedVersion;
      _forceUpgrade = $v.forceUpgrade;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeBootstrap200ResponseData other) {
    _$v = other as _$ParentHomeBootstrap200ResponseData;
  }

  @override
  void update(
    void Function(ParentHomeBootstrap200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeBootstrap200ResponseData build() => _build();

  _$ParentHomeBootstrap200ResponseData _build() {
    _$ParentHomeBootstrap200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentHomeBootstrap200ResponseData._(
            user: user.build(),
            roles: roles.build(),
            children: children.build(),
            theme: theme.build(),
            features: features.build(),
            unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount,
              r'ParentHomeBootstrap200ResponseData',
              'unreadCount',
            ),
            minSupportedVersion: BuiltValueNullFieldError.checkNotNull(
              minSupportedVersion,
              r'ParentHomeBootstrap200ResponseData',
              'minSupportedVersion',
            ),
            recommendedVersion: BuiltValueNullFieldError.checkNotNull(
              recommendedVersion,
              r'ParentHomeBootstrap200ResponseData',
              'recommendedVersion',
            ),
            forceUpgrade: BuiltValueNullFieldError.checkNotNull(
              forceUpgrade,
              r'ParentHomeBootstrap200ResponseData',
              'forceUpgrade',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
        _$failedField = 'roles';
        roles.build();
        _$failedField = 'children';
        children.build();
        _$failedField = 'theme';
        theme.build();
        _$failedField = 'features';
        features.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentHomeBootstrap200ResponseData',
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
