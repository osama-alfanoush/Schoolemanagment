// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_receipt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GoodsReceipt extends GoodsReceipt {
  @override
  final int id;
  @override
  final String grnNo;
  @override
  final int purchaseOrderId;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final int receivedBy;
  @override
  final DateTime receivedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$GoodsReceipt([void Function(GoodsReceiptBuilder)? updates]) =>
      (GoodsReceiptBuilder()..update(updates))._build();

  _$GoodsReceipt._({
    required this.id,
    required this.grnNo,
    required this.purchaseOrderId,
    required this.status,
    this.notes,
    required this.receivedBy,
    required this.receivedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  GoodsReceipt rebuild(void Function(GoodsReceiptBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoodsReceiptBuilder toBuilder() => GoodsReceiptBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GoodsReceipt &&
        id == other.id &&
        grnNo == other.grnNo &&
        purchaseOrderId == other.purchaseOrderId &&
        status == other.status &&
        notes == other.notes &&
        receivedBy == other.receivedBy &&
        receivedAt == other.receivedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, grnNo.hashCode);
    _$hash = $jc(_$hash, purchaseOrderId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, receivedBy.hashCode);
    _$hash = $jc(_$hash, receivedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GoodsReceipt')
          ..add('id', id)
          ..add('grnNo', grnNo)
          ..add('purchaseOrderId', purchaseOrderId)
          ..add('status', status)
          ..add('notes', notes)
          ..add('receivedBy', receivedBy)
          ..add('receivedAt', receivedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class GoodsReceiptBuilder
    implements Builder<GoodsReceipt, GoodsReceiptBuilder> {
  _$GoodsReceipt? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _grnNo;
  String? get grnNo => _$this._grnNo;
  set grnNo(String? grnNo) => _$this._grnNo = grnNo;

  int? _purchaseOrderId;
  int? get purchaseOrderId => _$this._purchaseOrderId;
  set purchaseOrderId(int? purchaseOrderId) =>
      _$this._purchaseOrderId = purchaseOrderId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _receivedBy;
  int? get receivedBy => _$this._receivedBy;
  set receivedBy(int? receivedBy) => _$this._receivedBy = receivedBy;

  DateTime? _receivedAt;
  DateTime? get receivedAt => _$this._receivedAt;
  set receivedAt(DateTime? receivedAt) => _$this._receivedAt = receivedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  GoodsReceiptBuilder() {
    GoodsReceipt._defaults(this);
  }

  GoodsReceiptBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _grnNo = $v.grnNo;
      _purchaseOrderId = $v.purchaseOrderId;
      _status = $v.status;
      _notes = $v.notes;
      _receivedBy = $v.receivedBy;
      _receivedAt = $v.receivedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GoodsReceipt other) {
    _$v = other as _$GoodsReceipt;
  }

  @override
  void update(void Function(GoodsReceiptBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GoodsReceipt build() => _build();

  _$GoodsReceipt _build() {
    final _$result =
        _$v ??
        _$GoodsReceipt._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'GoodsReceipt', 'id'),
          grnNo: BuiltValueNullFieldError.checkNotNull(
            grnNo,
            r'GoodsReceipt',
            'grnNo',
          ),
          purchaseOrderId: BuiltValueNullFieldError.checkNotNull(
            purchaseOrderId,
            r'GoodsReceipt',
            'purchaseOrderId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'GoodsReceipt',
            'status',
          ),
          notes: notes,
          receivedBy: BuiltValueNullFieldError.checkNotNull(
            receivedBy,
            r'GoodsReceipt',
            'receivedBy',
          ),
          receivedAt: BuiltValueNullFieldError.checkNotNull(
            receivedAt,
            r'GoodsReceipt',
            'receivedAt',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'GoodsReceipt',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
