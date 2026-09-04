// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_vehicles169_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportVehicles169Request extends TransportVehicles169Request {
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

  factory _$TransportVehicles169Request([
    void Function(TransportVehicles169RequestBuilder)? updates,
  ]) => (TransportVehicles169RequestBuilder()..update(updates))._build();

  _$TransportVehicles169Request._({
    required this.registrationNumber,
    this.model,
    required this.type,
    required this.capacity,
    this.routeId,
    this.driverId,
  }) : super._();
  @override
  TransportVehicles169Request rebuild(
    void Function(TransportVehicles169RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransportVehicles169RequestBuilder toBuilder() =>
      TransportVehicles169RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportVehicles169Request &&
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
    return (newBuiltValueToStringHelper(r'TransportVehicles169Request')
          ..add('registrationNumber', registrationNumber)
          ..add('model', model)
          ..add('type', type)
          ..add('capacity', capacity)
          ..add('routeId', routeId)
          ..add('driverId', driverId))
        .toString();
  }
}

class TransportVehicles169RequestBuilder
    implements
        Builder<
          TransportVehicles169Request,
          TransportVehicles169RequestBuilder
        > {
  _$TransportVehicles169Request? _$v;

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

  TransportVehicles169RequestBuilder() {
    TransportVehicles169Request._defaults(this);
  }

  TransportVehicles169RequestBuilder get _$this {
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
  void replace(TransportVehicles169Request other) {
    _$v = other as _$TransportVehicles169Request;
  }

  @override
  void update(void Function(TransportVehicles169RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportVehicles169Request build() => _build();

  _$TransportVehicles169Request _build() {
    final _$result =
        _$v ??
        _$TransportVehicles169Request._(
          registrationNumber: BuiltValueNullFieldError.checkNotNull(
            registrationNumber,
            r'TransportVehicles169Request',
            'registrationNumber',
          ),
          model: model,
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'TransportVehicles169Request',
            'type',
          ),
          capacity: BuiltValueNullFieldError.checkNotNull(
            capacity,
            r'TransportVehicles169Request',
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
