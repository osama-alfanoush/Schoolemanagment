// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_stop.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportStop extends TransportStop {
  @override
  final int id;
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
  final DateTime pickupTime;
  @override
  final DateTime dropoffTime;
  @override
  final int sequenceNumber;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$TransportStop([void Function(TransportStopBuilder)? updates]) =>
      (TransportStopBuilder()..update(updates))._build();

  _$TransportStop._({
    required this.id,
    required this.routeId,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
    required this.pickupTime,
    required this.dropoffTime,
    required this.sequenceNumber,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  TransportStop rebuild(void Function(TransportStopBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransportStopBuilder toBuilder() => TransportStopBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportStop &&
        id == other.id &&
        routeId == other.routeId &&
        name == other.name &&
        address == other.address &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        pickupTime == other.pickupTime &&
        dropoffTime == other.dropoffTime &&
        sequenceNumber == other.sequenceNumber &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, routeId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, pickupTime.hashCode);
    _$hash = $jc(_$hash, dropoffTime.hashCode);
    _$hash = $jc(_$hash, sequenceNumber.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportStop')
          ..add('id', id)
          ..add('routeId', routeId)
          ..add('name', name)
          ..add('address', address)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('pickupTime', pickupTime)
          ..add('dropoffTime', dropoffTime)
          ..add('sequenceNumber', sequenceNumber)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class TransportStopBuilder
    implements Builder<TransportStop, TransportStopBuilder> {
  _$TransportStop? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  DateTime? _pickupTime;
  DateTime? get pickupTime => _$this._pickupTime;
  set pickupTime(DateTime? pickupTime) => _$this._pickupTime = pickupTime;

  DateTime? _dropoffTime;
  DateTime? get dropoffTime => _$this._dropoffTime;
  set dropoffTime(DateTime? dropoffTime) => _$this._dropoffTime = dropoffTime;

  int? _sequenceNumber;
  int? get sequenceNumber => _$this._sequenceNumber;
  set sequenceNumber(int? sequenceNumber) =>
      _$this._sequenceNumber = sequenceNumber;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  TransportStopBuilder() {
    TransportStop._defaults(this);
  }

  TransportStopBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _routeId = $v.routeId;
      _name = $v.name;
      _address = $v.address;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _pickupTime = $v.pickupTime;
      _dropoffTime = $v.dropoffTime;
      _sequenceNumber = $v.sequenceNumber;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportStop other) {
    _$v = other as _$TransportStop;
  }

  @override
  void update(void Function(TransportStopBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportStop build() => _build();

  _$TransportStop _build() {
    final _$result =
        _$v ??
        _$TransportStop._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'TransportStop', 'id'),
          routeId: BuiltValueNullFieldError.checkNotNull(
            routeId,
            r'TransportStop',
            'routeId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TransportStop',
            'name',
          ),
          address: BuiltValueNullFieldError.checkNotNull(
            address,
            r'TransportStop',
            'address',
          ),
          latitude: latitude,
          longitude: longitude,
          pickupTime: BuiltValueNullFieldError.checkNotNull(
            pickupTime,
            r'TransportStop',
            'pickupTime',
          ),
          dropoffTime: BuiltValueNullFieldError.checkNotNull(
            dropoffTime,
            r'TransportStop',
            'dropoffTime',
          ),
          sequenceNumber: BuiltValueNullFieldError.checkNotNull(
            sequenceNumber,
            r'TransportStop',
            'sequenceNumber',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'TransportStop',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
