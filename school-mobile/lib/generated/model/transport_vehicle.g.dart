// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_vehicle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportVehicle extends TransportVehicle {
  @override
  final int id;
  @override
  final String registrationNumber;
  @override
  final String? model;
  @override
  final String type;
  @override
  final int capacity;
  @override
  final int? routeId;
  @override
  final int? driverId;
  @override
  final String? gpsDeviceId;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$TransportVehicle([
    void Function(TransportVehicleBuilder)? updates,
  ]) => (TransportVehicleBuilder()..update(updates))._build();

  _$TransportVehicle._({
    required this.id,
    required this.registrationNumber,
    this.model,
    required this.type,
    required this.capacity,
    this.routeId,
    this.driverId,
    this.gpsDeviceId,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  TransportVehicle rebuild(void Function(TransportVehicleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransportVehicleBuilder toBuilder() =>
      TransportVehicleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportVehicle &&
        id == other.id &&
        registrationNumber == other.registrationNumber &&
        model == other.model &&
        type == other.type &&
        capacity == other.capacity &&
        routeId == other.routeId &&
        driverId == other.driverId &&
        gpsDeviceId == other.gpsDeviceId &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, registrationNumber.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, capacity.hashCode);
    _$hash = $jc(_$hash, routeId.hashCode);
    _$hash = $jc(_$hash, driverId.hashCode);
    _$hash = $jc(_$hash, gpsDeviceId.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportVehicle')
          ..add('id', id)
          ..add('registrationNumber', registrationNumber)
          ..add('model', model)
          ..add('type', type)
          ..add('capacity', capacity)
          ..add('routeId', routeId)
          ..add('driverId', driverId)
          ..add('gpsDeviceId', gpsDeviceId)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class TransportVehicleBuilder
    implements Builder<TransportVehicle, TransportVehicleBuilder> {
  _$TransportVehicle? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _registrationNumber;
  String? get registrationNumber => _$this._registrationNumber;
  set registrationNumber(String? registrationNumber) =>
      _$this._registrationNumber = registrationNumber;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _capacity;
  int? get capacity => _$this._capacity;
  set capacity(int? capacity) => _$this._capacity = capacity;

  int? _routeId;
  int? get routeId => _$this._routeId;
  set routeId(int? routeId) => _$this._routeId = routeId;

  int? _driverId;
  int? get driverId => _$this._driverId;
  set driverId(int? driverId) => _$this._driverId = driverId;

  String? _gpsDeviceId;
  String? get gpsDeviceId => _$this._gpsDeviceId;
  set gpsDeviceId(String? gpsDeviceId) => _$this._gpsDeviceId = gpsDeviceId;

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

  TransportVehicleBuilder() {
    TransportVehicle._defaults(this);
  }

  TransportVehicleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _registrationNumber = $v.registrationNumber;
      _model = $v.model;
      _type = $v.type;
      _capacity = $v.capacity;
      _routeId = $v.routeId;
      _driverId = $v.driverId;
      _gpsDeviceId = $v.gpsDeviceId;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportVehicle other) {
    _$v = other as _$TransportVehicle;
  }

  @override
  void update(void Function(TransportVehicleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportVehicle build() => _build();

  _$TransportVehicle _build() {
    final _$result =
        _$v ??
        _$TransportVehicle._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TransportVehicle',
            'id',
          ),
          registrationNumber: BuiltValueNullFieldError.checkNotNull(
            registrationNumber,
            r'TransportVehicle',
            'registrationNumber',
          ),
          model: model,
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TransportVehicle',
            'type',
          ),
          capacity: BuiltValueNullFieldError.checkNotNull(
            capacity,
            r'TransportVehicle',
            'capacity',
          ),
          routeId: routeId,
          driverId: driverId,
          gpsDeviceId: gpsDeviceId,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'TransportVehicle',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'TransportVehicle',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
