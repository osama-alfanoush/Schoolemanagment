// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Supplier extends Supplier {
  @override
  final int id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String? contactPerson;
  @override
  final String phone;
  @override
  final String? secondaryPhone;
  @override
  final String? email;
  @override
  final String? address;
  @override
  final String? taxNumber;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int schoolId;

  factory _$Supplier([void Function(SupplierBuilder)? updates]) =>
      (SupplierBuilder()..update(updates))._build();

  _$Supplier._({
    required this.id,
    required this.code,
    required this.name,
    this.contactPerson,
    required this.phone,
    this.secondaryPhone,
    this.email,
    this.address,
    this.taxNumber,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.schoolId,
  }) : super._();
  @override
  Supplier rebuild(void Function(SupplierBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SupplierBuilder toBuilder() => SupplierBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Supplier &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        contactPerson == other.contactPerson &&
        phone == other.phone &&
        secondaryPhone == other.secondaryPhone &&
        email == other.email &&
        address == other.address &&
        taxNumber == other.taxNumber &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        deletedAt == other.deletedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, contactPerson.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, secondaryPhone.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, taxNumber.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Supplier')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('contactPerson', contactPerson)
          ..add('phone', phone)
          ..add('secondaryPhone', secondaryPhone)
          ..add('email', email)
          ..add('address', address)
          ..add('taxNumber', taxNumber)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('deletedAt', deletedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class SupplierBuilder implements Builder<Supplier, SupplierBuilder> {
  _$Supplier? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _contactPerson;
  String? get contactPerson => _$this._contactPerson;
  set contactPerson(String? contactPerson) =>
      _$this._contactPerson = contactPerson;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _secondaryPhone;
  String? get secondaryPhone => _$this._secondaryPhone;
  set secondaryPhone(String? secondaryPhone) =>
      _$this._secondaryPhone = secondaryPhone;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _taxNumber;
  String? get taxNumber => _$this._taxNumber;
  set taxNumber(String? taxNumber) => _$this._taxNumber = taxNumber;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _deletedAt;
  DateTime? get deletedAt => _$this._deletedAt;
  set deletedAt(DateTime? deletedAt) => _$this._deletedAt = deletedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  SupplierBuilder() {
    Supplier._defaults(this);
  }

  SupplierBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _contactPerson = $v.contactPerson;
      _phone = $v.phone;
      _secondaryPhone = $v.secondaryPhone;
      _email = $v.email;
      _address = $v.address;
      _taxNumber = $v.taxNumber;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _deletedAt = $v.deletedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Supplier other) {
    _$v = other as _$Supplier;
  }

  @override
  void update(void Function(SupplierBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Supplier build() => _build();

  _$Supplier _build() {
    final _$result =
        _$v ??
        _$Supplier._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Supplier', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'Supplier',
            'code',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'Supplier',
            'name',
          ),
          contactPerson: contactPerson,
          phone: BuiltValueNullFieldError.checkNotNull(
            phone,
            r'Supplier',
            'phone',
          ),
          secondaryPhone: secondaryPhone,
          email: email,
          address: address,
          taxNumber: taxNumber,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'Supplier',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Supplier',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
