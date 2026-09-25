// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_notifications200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxNotifications200Response
    extends ParentInboxNotifications200Response {
  @override
  final ParentInboxNotifications200ResponseData data;

  factory _$ParentInboxNotifications200Response([
    void Function(ParentInboxNotifications200ResponseBuilder)? updates,
  ]) =>
      (ParentInboxNotifications200ResponseBuilder()..update(updates))._build();

  _$ParentInboxNotifications200Response._({required this.data}) : super._();
  @override
  ParentInboxNotifications200Response rebuild(
    void Function(ParentInboxNotifications200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxNotifications200ResponseBuilder toBuilder() =>
      ParentInboxNotifications200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxNotifications200Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentInboxNotifications200Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxNotifications200ResponseBuilder
    implements
        Builder<
          ParentInboxNotifications200Response,
          ParentInboxNotifications200ResponseBuilder
        > {
  _$ParentInboxNotifications200Response? _$v;

  ParentInboxNotifications200ResponseDataBuilder? _data;
  ParentInboxNotifications200ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxNotifications200ResponseDataBuilder();
  set data(ParentInboxNotifications200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInboxNotifications200ResponseBuilder() {
    ParentInboxNotifications200Response._defaults(this);
  }

  ParentInboxNotifications200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxNotifications200Response other) {
    _$v = other as _$ParentInboxNotifications200Response;
  }

  @override
  void update(
    void Function(ParentInboxNotifications200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxNotifications200Response build() => _build();

  _$ParentInboxNotifications200Response _build() {
    _$ParentInboxNotifications200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentInboxNotifications200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxNotifications200Response',
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
