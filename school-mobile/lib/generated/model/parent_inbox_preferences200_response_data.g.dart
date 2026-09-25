// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_preferences200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxPreferences200ResponseData
    extends ParentInboxPreferences200ResponseData {
  @override
  final bool pushEnabled;
  @override
  final String categories;
  @override
  final BuiltList<JsonObject?> alwaysOn;
  @override
  final BuiltList<JsonObject?>? quietHours;

  factory _$ParentInboxPreferences200ResponseData([
    void Function(ParentInboxPreferences200ResponseDataBuilder)? updates,
  ]) => (ParentInboxPreferences200ResponseDataBuilder()..update(updates))
      ._build();

  _$ParentInboxPreferences200ResponseData._({
    required this.pushEnabled,
    required this.categories,
    required this.alwaysOn,
    this.quietHours,
  }) : super._();
  @override
  ParentInboxPreferences200ResponseData rebuild(
    void Function(ParentInboxPreferences200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxPreferences200ResponseDataBuilder toBuilder() =>
      ParentInboxPreferences200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxPreferences200ResponseData &&
        pushEnabled == other.pushEnabled &&
        categories == other.categories &&
        alwaysOn == other.alwaysOn &&
        quietHours == other.quietHours;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pushEnabled.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, alwaysOn.hashCode);
    _$hash = $jc(_$hash, quietHours.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentInboxPreferences200ResponseData',
          )
          ..add('pushEnabled', pushEnabled)
          ..add('categories', categories)
          ..add('alwaysOn', alwaysOn)
          ..add('quietHours', quietHours))
        .toString();
  }
}

class ParentInboxPreferences200ResponseDataBuilder
    implements
        Builder<
          ParentInboxPreferences200ResponseData,
          ParentInboxPreferences200ResponseDataBuilder
        > {
  _$ParentInboxPreferences200ResponseData? _$v;

  bool? _pushEnabled;
  bool? get pushEnabled => _$this._pushEnabled;
  set pushEnabled(bool? pushEnabled) => _$this._pushEnabled = pushEnabled;

  String? _categories;
  String? get categories => _$this._categories;
  set categories(String? categories) => _$this._categories = categories;

  ListBuilder<JsonObject?>? _alwaysOn;
  ListBuilder<JsonObject?> get alwaysOn =>
      _$this._alwaysOn ??= ListBuilder<JsonObject?>();
  set alwaysOn(ListBuilder<JsonObject?>? alwaysOn) =>
      _$this._alwaysOn = alwaysOn;

  ListBuilder<JsonObject?>? _quietHours;
  ListBuilder<JsonObject?> get quietHours =>
      _$this._quietHours ??= ListBuilder<JsonObject?>();
  set quietHours(ListBuilder<JsonObject?>? quietHours) =>
      _$this._quietHours = quietHours;

  ParentInboxPreferences200ResponseDataBuilder() {
    ParentInboxPreferences200ResponseData._defaults(this);
  }

  ParentInboxPreferences200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pushEnabled = $v.pushEnabled;
      _categories = $v.categories;
      _alwaysOn = $v.alwaysOn.toBuilder();
      _quietHours = $v.quietHours?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxPreferences200ResponseData other) {
    _$v = other as _$ParentInboxPreferences200ResponseData;
  }

  @override
  void update(
    void Function(ParentInboxPreferences200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxPreferences200ResponseData build() => _build();

  _$ParentInboxPreferences200ResponseData _build() {
    _$ParentInboxPreferences200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentInboxPreferences200ResponseData._(
            pushEnabled: BuiltValueNullFieldError.checkNotNull(
              pushEnabled,
              r'ParentInboxPreferences200ResponseData',
              'pushEnabled',
            ),
            categories: BuiltValueNullFieldError.checkNotNull(
              categories,
              r'ParentInboxPreferences200ResponseData',
              'categories',
            ),
            alwaysOn: alwaysOn.build(),
            quietHours: _quietHours?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'alwaysOn';
        alwaysOn.build();
        _$failedField = 'quietHours';
        _quietHours?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxPreferences200ResponseData',
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
