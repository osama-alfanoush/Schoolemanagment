// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delta_change_resource.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeltaChangeResource extends DeltaChangeResource {
  @override
  final String type;
  @override
  final String id;
  @override
  final bool deleted;
  @override
  final String? etag;
  @override
  final BuiltMap<String, JsonObject?> payload;

  factory _$DeltaChangeResource([
    void Function(DeltaChangeResourceBuilder)? updates,
  ]) => (DeltaChangeResourceBuilder()..update(updates))._build();

  _$DeltaChangeResource._({
    required this.type,
    required this.id,
    required this.deleted,
    this.etag,
    required this.payload,
  }) : super._();
  @override
  DeltaChangeResource rebuild(
    void Function(DeltaChangeResourceBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeltaChangeResourceBuilder toBuilder() =>
      DeltaChangeResourceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeltaChangeResource &&
        type == other.type &&
        id == other.id &&
        deleted == other.deleted &&
        etag == other.etag &&
        payload == other.payload;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, deleted.hashCode);
    _$hash = $jc(_$hash, etag.hashCode);
    _$hash = $jc(_$hash, payload.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeltaChangeResource')
          ..add('type', type)
          ..add('id', id)
          ..add('deleted', deleted)
          ..add('etag', etag)
          ..add('payload', payload))
        .toString();
  }
}

class DeltaChangeResourceBuilder
    implements Builder<DeltaChangeResource, DeltaChangeResourceBuilder> {
  _$DeltaChangeResource? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  bool? _deleted;
  bool? get deleted => _$this._deleted;
  set deleted(bool? deleted) => _$this._deleted = deleted;

  String? _etag;
  String? get etag => _$this._etag;
  set etag(String? etag) => _$this._etag = etag;

  MapBuilder<String, JsonObject?>? _payload;
  MapBuilder<String, JsonObject?> get payload =>
      _$this._payload ??= MapBuilder<String, JsonObject?>();
  set payload(MapBuilder<String, JsonObject?>? payload) =>
      _$this._payload = payload;

  DeltaChangeResourceBuilder() {
    DeltaChangeResource._defaults(this);
  }

  DeltaChangeResourceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _id = $v.id;
      _deleted = $v.deleted;
      _etag = $v.etag;
      _payload = $v.payload.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeltaChangeResource other) {
    _$v = other as _$DeltaChangeResource;
  }

  @override
  void update(void Function(DeltaChangeResourceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeltaChangeResource build() => _build();

  _$DeltaChangeResource _build() {
    _$DeltaChangeResource _$result;
    try {
      _$result =
          _$v ??
          _$DeltaChangeResource._(
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'DeltaChangeResource',
              'type',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'DeltaChangeResource',
              'id',
            ),
            deleted: BuiltValueNullFieldError.checkNotNull(
              deleted,
              r'DeltaChangeResource',
              'deleted',
            ),
            etag: etag,
            payload: payload.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'payload';
        payload.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DeltaChangeResource',
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
