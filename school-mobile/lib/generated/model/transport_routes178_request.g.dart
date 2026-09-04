// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_routes178_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransportRoutes178Request extends TransportRoutes178Request {
  @override
  final String name;
  @override
  final String? description;
  @override
  final String departureTime;
  @override
  final String returnTime;
  @override
  final num fee;
  @override
  final int capacity;

  factory _$TransportRoutes178Request([
    void Function(TransportRoutes178RequestBuilder)? updates,
  ]) => (TransportRoutes178RequestBuilder()..update(updates))._build();

  _$TransportRoutes178Request._({
    required this.name,
    this.description,
    required this.departureTime,
    required this.returnTime,
    required this.fee,
    required this.capacity,
  }) : super._();
  @override
  TransportRoutes178Request rebuild(
    void Function(TransportRoutes178RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TransportRoutes178RequestBuilder toBuilder() =>
      TransportRoutes178RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransportRoutes178Request &&
        name == other.name &&
        description == other.description &&
        departureTime == other.departureTime &&
        returnTime == other.returnTime &&
        fee == other.fee &&
        capacity == other.capacity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, departureTime.hashCode);
    _$hash = $jc(_$hash, returnTime.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, capacity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransportRoutes178Request')
          ..add('name', name)
          ..add('description', description)
          ..add('departureTime', departureTime)
          ..add('returnTime', returnTime)
          ..add('fee', fee)
          ..add('capacity', capacity))
        .toString();
  }
}

class TransportRoutes178RequestBuilder
    implements
        Builder<TransportRoutes178Request, TransportRoutes178RequestBuilder> {
  _$TransportRoutes178Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _departureTime;
  String? get departureTime => _$this._departureTime;
  set departureTime(String? departureTime) =>
      _$this._departureTime = departureTime;

  String? _returnTime;
  String? get returnTime => _$this._returnTime;
  set returnTime(String? returnTime) => _$this._returnTime = returnTime;

  num? _fee;
  num? get fee => _$this._fee;
  set fee(num? fee) => _$this._fee = fee;

  int? _capacity;
  int? get capacity => _$this._capacity;
  set capacity(int? capacity) => _$this._capacity = capacity;

  TransportRoutes178RequestBuilder() {
    TransportRoutes178Request._defaults(this);
  }

  TransportRoutes178RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _departureTime = $v.departureTime;
      _returnTime = $v.returnTime;
      _fee = $v.fee;
      _capacity = $v.capacity;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransportRoutes178Request other) {
    _$v = other as _$TransportRoutes178Request;
  }

  @override
  void update(void Function(TransportRoutes178RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransportRoutes178Request build() => _build();

  _$TransportRoutes178Request _build() {
    final _$result =
        _$v ??
        _$TransportRoutes178Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'TransportRoutes178Request',
            'name',
          ),
          description: description,
          departureTime: BuiltValueNullFieldError.checkNotNull(
            departureTime,
            r'TransportRoutes178Request',
            'departureTime',
          ),
          returnTime: BuiltValueNullFieldError.checkNotNull(
            returnTime,
            r'TransportRoutes178Request',
            'returnTime',
          ),
          fee: BuiltValueNullFieldError.checkNotNull(
            fee,
            r'TransportRoutes178Request',
            'fee',
          ),
          capacity: BuiltValueNullFieldError.checkNotNull(
            capacity,
            r'TransportRoutes178Request',
            'capacity',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
