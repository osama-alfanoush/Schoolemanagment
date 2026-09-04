// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_stops171_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportStops171Request extends TransportStops171Request {
  @override
  final int routeId;
  @override
  final String name;
  @override
  final String address;
  @override
  final num? latitude;
  @override
  final num? longitude;
  @override
  final String pickupTime;
  @override
  final String dropoffTime;
  @override
  final int sequenceNumber;

  factory _$TransportStops171Request([
    void Function(TransportStops171RequestBuilder)? updates,
  ]) => (TransportStops171RequestBuilder()..update(updates))._build();

  _$TransportStops171Request._({
    required this.routeId,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
    required this.pickupTime,
    required this.dropoffTime,
    required this.sequenceNumber,
  }) : super._();
  @override
  TransportStops171Request rebuild(
    void Function(TransportStops171RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransportStops171RequestBuilder toBuilder() =>
      TransportStops171RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportStops171Request &&
        routeId == other.routeId &&
        name == other.name &&
        address == other.address &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        pickupTime == other.pickupTime &&
        dropoffTime == other.dropoffTime &&
        sequenceNumber == other.sequenceNumber;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, routeId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, pickupTime.hashCode);
    _$hash = $jc(_$hash, dropoffTime.hashCode);
    _$hash = $jc(_$hash, sequenceNumber.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportStops171Request')
          ..add('routeId', routeId)
          ..add('name', name)
          ..add('address', address)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('pickupTime', pickupTime)
          ..add('dropoffTime', dropoffTime)
          ..add('sequenceNumber', sequenceNumber))
        .toString();
  }
}

class TransportStops171RequestBuilder
    implements
        Builder<TransportStops171Request, TransportStops171RequestBuilder> {
  _$TransportStops171Request? _$v;

  int? _routeId;
  int? get routeId => _$this._routeId;
  set routeId(int? routeId) => _$this._routeId = routeId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  String? _pickupTime;
  String? get pickupTime => _$this._pickupTime;
  set pickupTime(String? pickupTime) => _$this._pickupTime = pickupTime;

  String? _dropoffTime;
  String? get dropoffTime => _$this._dropoffTime;
  set dropoffTime(String? dropoffTime) => _$this._dropoffTime = dropoffTime;

  int? _sequenceNumber;
  int? get sequenceNumber => _$this._sequenceNumber;
  set sequenceNumber(int? sequenceNumber) =>
      _$this._sequenceNumber = sequenceNumber;

  TransportStops171RequestBuilder() {
    TransportStops171Request._defaults(this);
  }

  TransportStops171RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _routeId = $v.routeId;
      _name = $v.name;
      _address = $v.address;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _pickupTime = $v.pickupTime;
      _dropoffTime = $v.dropoffTime;
      _sequenceNumber = $v.sequenceNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportStops171Request other) {
    _$v = other as _$TransportStops171Request;
  }

  @override
  void update(void Function(TransportStops171RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportStops171Request build() => _build();

  _$TransportStops171Request _build() {
    final _$result =
        _$v ??
        _$TransportStops171Request._(
          routeId: BuiltValueNullFieldError.checkNotNull(
            routeId,
            r'TransportStops171Request',
            'routeId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TransportStops171Request',
            'name',
          ),
          address: BuiltValueNullFieldError.checkNotNull(
            address,
            r'TransportStops171Request',
            'address',
          ),
          latitude: latitude,
          longitude: longitude,
          pickupTime: BuiltValueNullFieldError.checkNotNull(
            pickupTime,
            r'TransportStops171Request',
            'pickupTime',
          ),
          dropoffTime: BuiltValueNullFieldError.checkNotNull(
            dropoffTime,
            r'TransportStops171Request',
            'dropoffTime',
          ),
          sequenceNumber: BuiltValueNullFieldError.checkNotNull(
            sequenceNumber,
            r'TransportStops171Request',
            'sequenceNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
