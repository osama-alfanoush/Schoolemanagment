// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PurchaseRequest extends PurchaseRequest {
  @override
  final int id;
  @override
  final String requestNo;
  @override
  final int itemId;
  @override
  final String quantityRequested;
  @override
  final String unit;
  @override
  final String? justification;
  @override
  final String? estimatedCost;
  @override
  final String status;
  @override
  final String? adminNotes;
  @override
  final int requestedBy;
  @override
  final int? reviewedBy;
  @override
  final DateTime? reviewedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$PurchaseRequest([void Function(PurchaseRequestBuilder)? updates]) =>
      (PurchaseRequestBuilder()..update(updates))._build();

  _$PurchaseRequest._({
    required this.id,
    required this.requestNo,
    required this.itemId,
    required this.quantityRequested,
    required this.unit,
    this.justification,
    this.estimatedCost,
    required this.status,
    this.adminNotes,
    required this.requestedBy,
    this.reviewedBy,
    this.reviewedAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  PurchaseRequest rebuild(void Function(PurchaseRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PurchaseRequestBuilder toBuilder() => PurchaseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PurchaseRequest &&
        id == other.id &&
        requestNo == other.requestNo &&
        itemId == other.itemId &&
        quantityRequested == other.quantityRequested &&
        unit == other.unit &&
        justification == other.justification &&
        estimatedCost == other.estimatedCost &&
        status == other.status &&
        adminNotes == other.adminNotes &&
        requestedBy == other.requestedBy &&
        reviewedBy == other.reviewedBy &&
        reviewedAt == other.reviewedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, requestNo.hashCode);
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, quantityRequested.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, justification.hashCode);
    _$hash = $jc(_$hash, estimatedCost.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, adminNotes.hashCode);
    _$hash = $jc(_$hash, requestedBy.hashCode);
    _$hash = $jc(_$hash, reviewedBy.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PurchaseRequest')
          ..add('id', id)
          ..add('requestNo', requestNo)
          ..add('itemId', itemId)
          ..add('quantityRequested', quantityRequested)
          ..add('unit', unit)
          ..add('justification', justification)
          ..add('estimatedCost', estimatedCost)
          ..add('status', status)
          ..add('adminNotes', adminNotes)
          ..add('requestedBy', requestedBy)
          ..add('reviewedBy', reviewedBy)
          ..add('reviewedAt', reviewedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PurchaseRequestBuilder
    implements Builder<PurchaseRequest, PurchaseRequestBuilder> {
  _$PurchaseRequest? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _requestNo;
  String? get requestNo => _$this._requestNo;
  set requestNo(String? requestNo) => _$this._requestNo = requestNo;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  String? _quantityRequested;
  String? get quantityRequested => _$this._quantityRequested;
  set quantityRequested(String? quantityRequested) =>
      _$this._quantityRequested = quantityRequested;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  String? _justification;
  String? get justification => _$this._justification;
  set justification(String? justification) =>
      _$this._justification = justification;

  String? _estimatedCost;
  String? get estimatedCost => _$this._estimatedCost;
  set estimatedCost(String? estimatedCost) =>
      _$this._estimatedCost = estimatedCost;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _adminNotes;
  String? get adminNotes => _$this._adminNotes;
  set adminNotes(String? adminNotes) => _$this._adminNotes = adminNotes;

  int? _requestedBy;
  int? get requestedBy => _$this._requestedBy;
  set requestedBy(int? requestedBy) => _$this._requestedBy = requestedBy;

  int? _reviewedBy;
  int? get reviewedBy => _$this._reviewedBy;
  set reviewedBy(int? reviewedBy) => _$this._reviewedBy = reviewedBy;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  PurchaseRequestBuilder() {
    PurchaseRequest._defaults(this);
  }

  PurchaseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _requestNo = $v.requestNo;
      _itemId = $v.itemId;
      _quantityRequested = $v.quantityRequested;
      _unit = $v.unit;
      _justification = $v.justification;
      _estimatedCost = $v.estimatedCost;
      _status = $v.status;
      _adminNotes = $v.adminNotes;
      _requestedBy = $v.requestedBy;
      _reviewedBy = $v.reviewedBy;
      _reviewedAt = $v.reviewedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PurchaseRequest other) {
    _$v = other as _$PurchaseRequest;
  }

  @override
  void update(void Function(PurchaseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PurchaseRequest build() => _build();

  _$PurchaseRequest _build() {
    final _$result =
        _$v ??
        _$PurchaseRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'PurchaseRequest',
            'id',
          ),
          requestNo: BuiltValueNullFieldError.checkNotNull(
            requestNo,
            r'PurchaseRequest',
            'requestNo',
          ),
          itemId: BuiltValueNullFieldError.checkNotNull(
            itemId,
            r'PurchaseRequest',
            'itemId',
          ),
          quantityRequested: BuiltValueNullFieldError.checkNotNull(
            quantityRequested,
            r'PurchaseRequest',
            'quantityRequested',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'PurchaseRequest',
            'unit',
          ),
          justification: justification,
          estimatedCost: estimatedCost,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'PurchaseRequest',
            'status',
          ),
          adminNotes: adminNotes,
          requestedBy: BuiltValueNullFieldError.checkNotNull(
            requestedBy,
            r'PurchaseRequest',
            'requestedBy',
          ),
          reviewedBy: reviewedBy,
          reviewedAt: reviewedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'PurchaseRequest',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
