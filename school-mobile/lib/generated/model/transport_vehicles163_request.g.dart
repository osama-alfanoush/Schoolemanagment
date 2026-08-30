// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_vehicles163_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportVehicles163Request extends TransportVehicles163Request {
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

  factory _$TransportVehicles163Request([
    void Function(TransportVehicles163RequestBuilder)? updates,
  ]) => (TransportVehicles163RequestBuilder()..update(updates))._build();

  _$TransportVehicles163Request._({
    required this.registrationNumber,
    this.model,
    required this.type,
    required this.capacity,
    this.routeId,
    this.driverId,
  }) : super._();
  @override
  TransportVehicles163Request rebuild(
    void Function(TransportVehicles163RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransportVehicles163RequestBuilder toBuilder() =>
      TransportVehicles163RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportVehicles163Request &&
        registrationNumber == other.registrationNumber &&
        model == other.model &&
        type == other.type &&
        capacity == other.capacity &&
        routeId == other.routeId &&
        driverId == other.driverId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, registrationNumber.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, capacity.hashCode);
    _$hash = $jc(_$hash, routeId.hashCode);
    _$hash = $jc(_$hash, driverId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportVehicles163Request')
          ..add('registrationNumber', registrationNumber)
          ..add('model', model)
          ..add('type', type)
          ..add('capacity', capacity)
          ..add('routeId', routeId)
          ..add('driverId', driverId))
        .toString();
  }
}

class TransportVehicles163RequestBuilder
    implements
        Builder<
          TransportVehicles163Request,
          TransportVehicles163RequestBuilder
        > {
  _$TransportVehicles163Request? _$v;

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

  TransportVehicles163RequestBuilder() {
    TransportVehicles163Request._defaults(this);
  }

  TransportVehicles163RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _registrationNumber = $v.registrationNumber;
      _model = $v.model;
      _type = $v.type;
      _capacity = $v.capacity;
      _routeId = $v.routeId;
      _driverId = $v.driverId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportVehicles163Request other) {
    _$v = other as _$TransportVehicles163Request;
  }

  @override
  void update(void Function(TransportVehicles163RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportVehicles163Request build() => _build();

  _$TransportVehicles163Request _build() {
    final _$result =
        _$v ??
        _$TransportVehicles163Request._(
          registrationNumber: BuiltValueNullFieldError.checkNotNull(
            registrationNumber,
            r'TransportVehicles163Request',
            'registrationNumber',
          ),
          model: model,
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TransportVehicles163Request',
            'type',
          ),
          capacity: BuiltValueNullFieldError.checkNotNull(
            capacity,
            r'TransportVehicles163Request',
            'capacity',
          ),
          routeId: routeId,
          driverId: driverId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
