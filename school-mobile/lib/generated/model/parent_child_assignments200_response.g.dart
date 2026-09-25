// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_assignments200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildAssignments200Response
    extends ParentChildAssignments200Response {
  @override
  final BuiltMap<String, String> data;
  @override
  final ParentChildAssignments200ResponseMeta meta;

  factory _$ParentChildAssignments200Response([
    void Function(ParentChildAssignments200ResponseBuilder)? updates,
  ]) => (ParentChildAssignments200ResponseBuilder()..update(updates))._build();

  _$ParentChildAssignments200Response._({
    required this.data,
    required this.meta,
  }) : super._();
  @override
  ParentChildAssignments200Response rebuild(
    void Function(ParentChildAssignments200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildAssignments200ResponseBuilder toBuilder() =>
      ParentChildAssignments200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildAssignments200Response &&
        data == other.data &&
        meta == other.meta;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentChildAssignments200Response')
          ..add('data', data)
          ..add('meta', meta))
        .toString();
  }
}

class ParentChildAssignments200ResponseBuilder
    implements
        Builder<
          ParentChildAssignments200Response,
          ParentChildAssignments200ResponseBuilder
        > {
  _$ParentChildAssignments200Response? _$v;

  MapBuilder<String, String>? _data;
  MapBuilder<String, String> get data =>
      _$this._data ??= MapBuilder<String, String>();
  set data(MapBuilder<String, String>? data) => _$this._data = data;

  ParentChildAssignments200ResponseMetaBuilder? _meta;
  ParentChildAssignments200ResponseMetaBuilder get meta =>
      _$this._meta ??= ParentChildAssignments200ResponseMetaBuilder();
  set meta(ParentChildAssignments200ResponseMetaBuilder? meta) =>
      _$this._meta = meta;

  ParentChildAssignments200ResponseBuilder() {
    ParentChildAssignments200Response._defaults(this);
  }

  ParentChildAssignments200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _meta = $v.meta.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildAssignments200Response other) {
    _$v = other as _$ParentChildAssignments200Response;
  }

  @override
  void update(
    void Function(ParentChildAssignments200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildAssignments200Response build() => _build();

  _$ParentChildAssignments200Response _build() {
    _$ParentChildAssignments200Response _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildAssignments200Response._(
            data: data.build(),
            meta: meta.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'meta';
        meta.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildAssignments200Response',
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
