// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InventoryCount extends InventoryCount {
  @override
  final int id;
  @override
  final String countRef;
  @override
  final String countType;
  @override
  final DateTime countDate;
  @override
  final int itemId;
  @override
  final String systemQty;
  @override
  final String physicalQty;
  @override
  final String? notes;
  @override
  final int countedBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$InventoryCount([void Function(InventoryCountBuilder)? updates]) =>
      (InventoryCountBuilder()..update(updates))._build();

  _$InventoryCount._({
    required this.id,
    required this.countRef,
    required this.countType,
    required this.countDate,
    required this.itemId,
    required this.systemQty,
    required this.physicalQty,
    this.notes,
    required this.countedBy,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  InventoryCount rebuild(void Function(InventoryCountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InventoryCountBuilder toBuilder() => InventoryCountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InventoryCount &&
        id == other.id &&
        countRef == other.countRef &&
        countType == other.countType &&
        countDate == other.countDate &&
        itemId == other.itemId &&
        systemQty == other.systemQty &&
        physicalQty == other.physicalQty &&
        notes == other.notes &&
        countedBy == other.countedBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, countRef.hashCode);
    _$hash = $jc(_$hash, countType.hashCode);
    _$hash = $jc(_$hash, countDate.hashCode);
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, systemQty.hashCode);
    _$hash = $jc(_$hash, physicalQty.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, countedBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InventoryCount')
          ..add('id', id)
          ..add('countRef', countRef)
          ..add('countType', countType)
          ..add('countDate', countDate)
          ..add('itemId', itemId)
          ..add('systemQty', systemQty)
          ..add('physicalQty', physicalQty)
          ..add('notes', notes)
          ..add('countedBy', countedBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class InventoryCountBuilder
    implements Builder<InventoryCount, InventoryCountBuilder> {
  _$InventoryCount? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _countRef;
  String? get countRef => _$this._countRef;
  set countRef(String? countRef) => _$this._countRef = countRef;

  String? _countType;
  String? get countType => _$this._countType;
  set countType(String? countType) => _$this._countType = countType;

  DateTime? _countDate;
  DateTime? get countDate => _$this._countDate;
  set countDate(DateTime? countDate) => _$this._countDate = countDate;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  String? _systemQty;
  String? get systemQty => _$this._systemQty;
  set systemQty(String? systemQty) => _$this._systemQty = systemQty;

  String? _physicalQty;
  String? get physicalQty => _$this._physicalQty;
  set physicalQty(String? physicalQty) => _$this._physicalQty = physicalQty;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _countedBy;
  int? get countedBy => _$this._countedBy;
  set countedBy(int? countedBy) => _$this._countedBy = countedBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  InventoryCountBuilder() {
    InventoryCount._defaults(this);
  }

  InventoryCountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _countRef = $v.countRef;
      _countType = $v.countType;
      _countDate = $v.countDate;
      _itemId = $v.itemId;
      _systemQty = $v.systemQty;
      _physicalQty = $v.physicalQty;
      _notes = $v.notes;
      _countedBy = $v.countedBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InventoryCount other) {
    _$v = other as _$InventoryCount;
  }

  @override
  void update(void Function(InventoryCountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InventoryCount build() => _build();

  _$InventoryCount _build() {
    final _$result =
        _$v ??
        _$InventoryCount._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'InventoryCount',
            'id',
          ),
          countRef: BuiltValueNullFieldError.checkNotNull(
            countRef,
            r'InventoryCount',
            'countRef',
          ),
          countType: BuiltValueNullFieldError.checkNotNull(
            countType,
            r'InventoryCount',
            'countType',
          ),
          countDate: BuiltValueNullFieldError.checkNotNull(
            countDate,
            r'InventoryCount',
            'countDate',
          ),
          itemId: BuiltValueNullFieldError.checkNotNull(
            itemId,
            r'InventoryCount',
            'itemId',
          ),
          systemQty: BuiltValueNullFieldError.checkNotNull(
            systemQty,
            r'InventoryCount',
            'systemQty',
          ),
          physicalQty: BuiltValueNullFieldError.checkNotNull(
            physicalQty,
            r'InventoryCount',
            'physicalQty',
          ),
          notes: notes,
          countedBy: BuiltValueNullFieldError.checkNotNull(
            countedBy,
            r'InventoryCount',
            'countedBy',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'InventoryCount',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
