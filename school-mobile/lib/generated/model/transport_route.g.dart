// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportRoute extends TransportRoute {
  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime departureTime;
  @override
  final DateTime returnTime;
  @override
  final String fee;
  @override
  final int capacity;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$TransportRoute([void Function(TransportRouteBuilder)? updates]) =>
      (TransportRouteBuilder()..update(updates))._build();

  _$TransportRoute._({
    required this.id,
    required this.name,
    this.description,
    required this.departureTime,
    required this.returnTime,
    required this.fee,
    required this.capacity,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  TransportRoute rebuild(void Function(TransportRouteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransportRouteBuilder toBuilder() => TransportRouteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportRoute &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        departureTime == other.departureTime &&
        returnTime == other.returnTime &&
        fee == other.fee &&
        capacity == other.capacity &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, departureTime.hashCode);
    _$hash = $jc(_$hash, returnTime.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, capacity.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportRoute')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('departureTime', departureTime)
          ..add('returnTime', returnTime)
          ..add('fee', fee)
          ..add('capacity', capacity)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class TransportRouteBuilder
    implements Builder<TransportRoute, TransportRouteBuilder> {
  _$TransportRoute? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  DateTime? _departureTime;
  DateTime? get departureTime => _$this._departureTime;
  set departureTime(DateTime? departureTime) =>
      _$this._departureTime = departureTime;

  DateTime? _returnTime;
  DateTime? get returnTime => _$this._returnTime;
  set returnTime(DateTime? returnTime) => _$this._returnTime = returnTime;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(String? fee) => _$this._fee = fee;

  int? _capacity;
  int? get capacity => _$this._capacity;
  set capacity(int? capacity) => _$this._capacity = capacity;

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

  TransportRouteBuilder() {
    TransportRoute._defaults(this);
  }

  TransportRouteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _departureTime = $v.departureTime;
      _returnTime = $v.returnTime;
      _fee = $v.fee;
      _capacity = $v.capacity;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportRoute other) {
    _$v = other as _$TransportRoute;
  }

  @override
  void update(void Function(TransportRouteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportRoute build() => _build();

  _$TransportRoute _build() {
    final _$result =
        _$v ??
        _$TransportRoute._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TransportRoute',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TransportRoute',
            'name',
          ),
          description: description,
          departureTime: BuiltValueNullFieldError.checkNotNull(
            departureTime,
            r'TransportRoute',
            'departureTime',
          ),
          returnTime: BuiltValueNullFieldError.checkNotNull(
            returnTime,
            r'TransportRoute',
            'returnTime',
          ),
          fee: BuiltValueNullFieldError.checkNotNull(
            fee,
            r'TransportRoute',
            'fee',
          ),
          capacity: BuiltValueNullFieldError.checkNotNull(
            capacity,
            r'TransportRoute',
            'capacity',
          ),
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'TransportRoute',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'TransportRoute',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
