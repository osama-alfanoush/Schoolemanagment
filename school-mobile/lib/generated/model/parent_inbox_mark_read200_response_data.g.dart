// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_mark_read200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxMarkRead200ResponseData
    extends ParentInboxMarkRead200ResponseData {
  @override
  final int id;
  @override
  final bool read;

  factory _$ParentInboxMarkRead200ResponseData([
    void Function(ParentInboxMarkRead200ResponseDataBuilder)? updates,
  ]) => (ParentInboxMarkRead200ResponseDataBuilder()..update(updates))._build();

  _$ParentInboxMarkRead200ResponseData._({required this.id, required this.read})
    : super._();
  @override
  ParentInboxMarkRead200ResponseData rebuild(
    void Function(ParentInboxMarkRead200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxMarkRead200ResponseDataBuilder toBuilder() =>
      ParentInboxMarkRead200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxMarkRead200ResponseData &&
        id == other.id &&
        read == other.read;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentInboxMarkRead200ResponseData')
          ..add('id', id)
          ..add('read', read))
        .toString();
  }
}

class ParentInboxMarkRead200ResponseDataBuilder
    implements
        Builder<
          ParentInboxMarkRead200ResponseData,
          ParentInboxMarkRead200ResponseDataBuilder
        > {
  _$ParentInboxMarkRead200ResponseData? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  bool? _read;
  bool? get read => _$this._read;
  set read(bool? read) => _$this._read = read;

  ParentInboxMarkRead200ResponseDataBuilder() {
    ParentInboxMarkRead200ResponseData._defaults(this);
  }

  ParentInboxMarkRead200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _read = $v.read;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxMarkRead200ResponseData other) {
    _$v = other as _$ParentInboxMarkRead200ResponseData;
  }

  @override
  void update(
    void Function(ParentInboxMarkRead200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxMarkRead200ResponseData build() => _build();

  _$ParentInboxMarkRead200ResponseData _build() {
    final _$result =
        _$v ??
        _$ParentInboxMarkRead200ResponseData._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'ParentInboxMarkRead200ResponseData',
            'id',
          ),
          read: BuiltValueNullFieldError.checkNotNull(
            read,
            r'ParentInboxMarkRead200ResponseData',
            'read',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
