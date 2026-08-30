// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_assignment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportAssignment extends TransportAssignment {
  @override
  final int id;
  @override
  final int studentUserId;
  @override
  final int routeId;
  @override
  final int? pickupStopId;
  @override
  final int? dropoffStopId;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$TransportAssignment([
    void Function(TransportAssignmentBuilder)? updates,
  ]) => (TransportAssignmentBuilder()..update(updates))._build();

  _$TransportAssignment._({
    required this.id,
    required this.studentUserId,
    required this.routeId,
    this.pickupStopId,
    this.dropoffStopId,
    required this.startDate,
    this.endDate,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  TransportAssignment rebuild(
    void Function(TransportAssignmentBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransportAssignmentBuilder toBuilder() =>
      TransportAssignmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportAssignment &&
        id == other.id &&
        studentUserId == other.studentUserId &&
        routeId == other.routeId &&
        pickupStopId == other.pickupStopId &&
        dropoffStopId == other.dropoffStopId &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, routeId.hashCode);
    _$hash = $jc(_$hash, pickupStopId.hashCode);
    _$hash = $jc(_$hash, dropoffStopId.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportAssignment')
          ..add('id', id)
          ..add('studentUserId', studentUserId)
          ..add('routeId', routeId)
          ..add('pickupStopId', pickupStopId)
          ..add('dropoffStopId', dropoffStopId)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class TransportAssignmentBuilder
    implements Builder<TransportAssignment, TransportAssignmentBuilder> {
  _$TransportAssignment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _routeId;
  int? get routeId => _$this._routeId;
  set routeId(int? routeId) => _$this._routeId = routeId;

  int? _pickupStopId;
  int? get pickupStopId => _$this._pickupStopId;
  set pickupStopId(int? pickupStopId) => _$this._pickupStopId = pickupStopId;

  int? _dropoffStopId;
  int? get dropoffStopId => _$this._dropoffStopId;
  set dropoffStopId(int? dropoffStopId) =>
      _$this._dropoffStopId = dropoffStopId;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  TransportAssignmentBuilder() {
    TransportAssignment._defaults(this);
  }

  TransportAssignmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentUserId = $v.studentUserId;
      _routeId = $v.routeId;
      _pickupStopId = $v.pickupStopId;
      _dropoffStopId = $v.dropoffStopId;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportAssignment other) {
    _$v = other as _$TransportAssignment;
  }

  @override
  void update(void Function(TransportAssignmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportAssignment build() => _build();

  _$TransportAssignment _build() {
    final _$result =
        _$v ??
        _$TransportAssignment._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TransportAssignment',
            'id',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TransportAssignment',
            'studentUserId',
          ),
          routeId: BuiltValueNullFieldError.checkNotNull(
            routeId,
            r'TransportAssignment',
            'routeId',
          ),
          pickupStopId: pickupStopId,
          dropoffStopId: dropoffStopId,
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'TransportAssignment',
            'startDate',
          ),
          endDate: endDate,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'TransportAssignment',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'TransportAssignment',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
