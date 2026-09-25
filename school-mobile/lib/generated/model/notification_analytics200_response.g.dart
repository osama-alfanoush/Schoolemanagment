// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_analytics200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationAnalytics200Response
    extends NotificationAnalytics200Response {
  @override
  final int totalSent;
  @override
  final int totalRead;
  @override
  final BuiltMap<String, JsonObject?> byType;
  @override
  final BuiltMap<String, JsonObject?> byCategory;
  @override
  final BuiltMap<String, JsonObject?> deliverySuccessRate;

  factory _$NotificationAnalytics200Response([
    void Function(NotificationAnalytics200ResponseBuilder)? updates,
  ]) => (NotificationAnalytics200ResponseBuilder()..update(updates))._build();

  _$NotificationAnalytics200Response._({
    required this.totalSent,
    required this.totalRead,
    required this.byType,
    required this.byCategory,
    required this.deliverySuccessRate,
  }) : super._();
  @override
  NotificationAnalytics200Response rebuild(
    void Function(NotificationAnalytics200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationAnalytics200ResponseBuilder toBuilder() =>
      NotificationAnalytics200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationAnalytics200Response &&
        totalSent == other.totalSent &&
        totalRead == other.totalRead &&
        byType == other.byType &&
        byCategory == other.byCategory &&
        deliverySuccessRate == other.deliverySuccessRate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalSent.hashCode);
    _$hash = $jc(_$hash, totalRead.hashCode);
    _$hash = $jc(_$hash, byType.hashCode);
    _$hash = $jc(_$hash, byCategory.hashCode);
    _$hash = $jc(_$hash, deliverySuccessRate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationAnalytics200Response')
          ..add('totalSent', totalSent)
          ..add('totalRead', totalRead)
          ..add('byType', byType)
          ..add('byCategory', byCategory)
          ..add('deliverySuccessRate', deliverySuccessRate))
        .toString();
  }
}

class NotificationAnalytics200ResponseBuilder
    implements
        Builder<
          NotificationAnalytics200Response,
          NotificationAnalytics200ResponseBuilder
        > {
  _$NotificationAnalytics200Response? _$v;

  int? _totalSent;
  int? get totalSent => _$this._totalSent;
  set totalSent(int? totalSent) => _$this._totalSent = totalSent;

  int? _totalRead;
  int? get totalRead => _$this._totalRead;
  set totalRead(int? totalRead) => _$this._totalRead = totalRead;

  MapBuilder<String, JsonObject?>? _byType;
  MapBuilder<String, JsonObject?> get byType =>
      _$this._byType ??= MapBuilder<String, JsonObject?>();
  set byType(MapBuilder<String, JsonObject?>? byType) =>
      _$this._byType = byType;

  MapBuilder<String, JsonObject?>? _byCategory;
  MapBuilder<String, JsonObject?> get byCategory =>
      _$this._byCategory ??= MapBuilder<String, JsonObject?>();
  set byCategory(MapBuilder<String, JsonObject?>? byCategory) =>
      _$this._byCategory = byCategory;

  MapBuilder<String, JsonObject?>? _deliverySuccessRate;
  MapBuilder<String, JsonObject?> get deliverySuccessRate =>
      _$this._deliverySuccessRate ??= MapBuilder<String, JsonObject?>();
  set deliverySuccessRate(
    MapBuilder<String, JsonObject?>? deliverySuccessRate,
  ) => _$this._deliverySuccessRate = deliverySuccessRate;

  NotificationAnalytics200ResponseBuilder() {
    NotificationAnalytics200Response._defaults(this);
  }

  NotificationAnalytics200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalSent = $v.totalSent;
      _totalRead = $v.totalRead;
      _byType = $v.byType.toBuilder();
      _byCategory = $v.byCategory.toBuilder();
      _deliverySuccessRate = $v.deliverySuccessRate.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationAnalytics200Response other) {
    _$v = other as _$NotificationAnalytics200Response;
  }

  @override
  void update(void Function(NotificationAnalytics200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationAnalytics200Response build() => _build();

  _$NotificationAnalytics200Response _build() {
    _$NotificationAnalytics200Response _$result;
    try {
      _$result =
          _$v ??
          _$NotificationAnalytics200Response._(
            totalSent: BuiltValueNullFieldError.checkNotNull(
              totalSent,
              r'NotificationAnalytics200Response',
              'totalSent',
            ),
            totalRead: BuiltValueNullFieldError.checkNotNull(
              totalRead,
              r'NotificationAnalytics200Response',
              'totalRead',
            ),
            byType: byType.build(),
            byCategory: byCategory.build(),
            deliverySuccessRate: deliverySuccessRate.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'byType';
        byType.build();
        _$failedField = 'byCategory';
        byCategory.build();
        _$failedField = 'deliverySuccessRate';
        deliverySuccessRate.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'NotificationAnalytics200Response',
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
