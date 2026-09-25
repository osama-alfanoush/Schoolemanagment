// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseCategory extends WarehouseCategory {
  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$WarehouseCategory([
    void Function(WarehouseCategoryBuilder)? updates,
  ]) => (WarehouseCategoryBuilder()..update(updates))._build();

  _$WarehouseCategory._({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  WarehouseCategory rebuild(void Function(WarehouseCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WarehouseCategoryBuilder toBuilder() =>
      WarehouseCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseCategory &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseCategory')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class WarehouseCategoryBuilder
    implements Builder<WarehouseCategory, WarehouseCategoryBuilder> {
  _$WarehouseCategory? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  WarehouseCategoryBuilder() {
    WarehouseCategory._defaults(this);
  }

  WarehouseCategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseCategory other) {
    _$v = other as _$WarehouseCategory;
  }

  @override
  void update(void Function(WarehouseCategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseCategory build() => _build();

  _$WarehouseCategory _build() {
    final _$result =
        _$v ??
        _$WarehouseCategory._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'WarehouseCategory',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'WarehouseCategory',
            'name',
          ),
          description: description,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'WarehouseCategory',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
