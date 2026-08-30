// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_category_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreCategoryRequest extends WarehouseStoreCategoryRequest {
  @override
  final String name;
  @override
  final String? description;

  factory _$WarehouseStoreCategoryRequest([
    void Function(WarehouseStoreCategoryRequestBuilder)? updates,
  ]) => (WarehouseStoreCategoryRequestBuilder()..update(updates))._build();

  _$WarehouseStoreCategoryRequest._({required this.name, this.description})
    : super._();
  @override
  WarehouseStoreCategoryRequest rebuild(
    void Function(WarehouseStoreCategoryRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreCategoryRequestBuilder toBuilder() =>
      WarehouseStoreCategoryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreCategoryRequest &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseStoreCategoryRequest')
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class WarehouseStoreCategoryRequestBuilder
    implements
        Builder<
          WarehouseStoreCategoryRequest,
          WarehouseStoreCategoryRequestBuilder
        > {
  _$WarehouseStoreCategoryRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WarehouseStoreCategoryRequestBuilder() {
    WarehouseStoreCategoryRequest._defaults(this);
  }

  WarehouseStoreCategoryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreCategoryRequest other) {
    _$v = other as _$WarehouseStoreCategoryRequest;
  }

  @override
  void update(void Function(WarehouseStoreCategoryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreCategoryRequest build() => _build();

  _$WarehouseStoreCategoryRequest _build() {
    final _$result =
        _$v ??
        _$WarehouseStoreCategoryRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'WarehouseStoreCategoryRequest',
            'name',
          ),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
