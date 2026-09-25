// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_stops209_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportStops209Request extends TransportStops209Request {
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

  factory _$TransportStops209Request([
    void Function(TransportStops209RequestBuilder)? updates,
  ]) => (TransportStops209RequestBuilder()..update(updates))._build();

  _$TransportStops209Request._({
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
  TransportStops209Request rebuild(
    void Function(TransportStops209RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransportStops209RequestBuilder toBuilder() =>
      TransportStops209RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportStops209Request &&
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
    return (newBuiltValueToStringHelper(r'TransportStops209Request')
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

class TransportStops209RequestBuilder
    implements
        Builder<TransportStops209Request, TransportStops209RequestBuilder> {
  _$TransportStops209Request? _$v;

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

  TransportStops209RequestBuilder() {
    TransportStops209Request._defaults(this);
  }

  TransportStops209RequestBuilder get _$this {
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
  void replace(TransportStops209Request other) {
    _$v = other as _$TransportStops209Request;
  }

  @override
  void update(void Function(TransportStops209RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportStops209Request build() => _build();

  _$TransportStops209Request _build() {
    final _$result =
        _$v ??
        _$TransportStops209Request._(
          routeId: BuiltValueNullFieldError.checkNotNull(
            routeId,
            r'TransportStops209Request',
            'routeId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TransportStops209Request',
            'name',
          ),
          address: BuiltValueNullFieldError.checkNotNull(
            address,
            r'TransportStops209Request',
            'address',
          ),
          latitude: latitude,
          longitude: longitude,
          pickupTime: BuiltValueNullFieldError.checkNotNull(
            pickupTime,
            r'TransportStops209Request',
            'pickupTime',
          ),
          dropoffTime: BuiltValueNullFieldError.checkNotNull(
            dropoffTime,
            r'TransportStops209Request',
            'dropoffTime',
          ),
          sequenceNumber: BuiltValueNullFieldError.checkNotNull(
            sequenceNumber,
            r'TransportStops209Request',
            'sequenceNumber',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
