// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_update_supplier_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementUpdateSupplierRequestPaymentTermsEnum
_$procurementUpdateSupplierRequestPaymentTermsEnum_cash =
    const ProcurementUpdateSupplierRequestPaymentTermsEnum._('cash');
const ProcurementUpdateSupplierRequestPaymentTermsEnum
_$procurementUpdateSupplierRequestPaymentTermsEnum_net15 =
    const ProcurementUpdateSupplierRequestPaymentTermsEnum._('net15');
const ProcurementUpdateSupplierRequestPaymentTermsEnum
_$procurementUpdateSupplierRequestPaymentTermsEnum_net30 =
    const ProcurementUpdateSupplierRequestPaymentTermsEnum._('net30');
const ProcurementUpdateSupplierRequestPaymentTermsEnum
_$procurementUpdateSupplierRequestPaymentTermsEnum_net60 =
    const ProcurementUpdateSupplierRequestPaymentTermsEnum._('net60');

ProcurementUpdateSupplierRequestPaymentTermsEnum
_$procurementUpdateSupplierRequestPaymentTermsEnumValueOf(String name) {
  switch (name) {
    case 'cash':
      return _$procurementUpdateSupplierRequestPaymentTermsEnum_cash;
    case 'net15':
      return _$procurementUpdateSupplierRequestPaymentTermsEnum_net15;
    case 'net30':
      return _$procurementUpdateSupplierRequestPaymentTermsEnum_net30;
    case 'net60':
      return _$procurementUpdateSupplierRequestPaymentTermsEnum_net60;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementUpdateSupplierRequestPaymentTermsEnum>
_$procurementUpdateSupplierRequestPaymentTermsEnumValues =
    BuiltSet<ProcurementUpdateSupplierRequestPaymentTermsEnum>(
      const <ProcurementUpdateSupplierRequestPaymentTermsEnum>[
        _$procurementUpdateSupplierRequestPaymentTermsEnum_cash,
        _$procurementUpdateSupplierRequestPaymentTermsEnum_net15,
        _$procurementUpdateSupplierRequestPaymentTermsEnum_net30,
        _$procurementUpdateSupplierRequestPaymentTermsEnum_net60,
      ],
    );

Serializer<ProcurementUpdateSupplierRequestPaymentTermsEnum>
_$procurementUpdateSupplierRequestPaymentTermsEnumSerializer =
    _$ProcurementUpdateSupplierRequestPaymentTermsEnumSerializer();

class _$ProcurementUpdateSupplierRequestPaymentTermsEnumSerializer
    implements
        PrimitiveSerializer<ProcurementUpdateSupplierRequestPaymentTermsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cash': 'cash',
    'net15': 'net_15',
    'net30': 'net_30',
    'net60': 'net_60',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cash': 'cash',
    'net_15': 'net15',
    'net_30': 'net30',
    'net_60': 'net60',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProcurementUpdateSupplierRequestPaymentTermsEnum,
  ];
  @override
  final String wireName = 'ProcurementUpdateSupplierRequestPaymentTermsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementUpdateSupplierRequestPaymentTermsEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementUpdateSupplierRequestPaymentTermsEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementUpdateSupplierRequestPaymentTermsEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementUpdateSupplierRequest
    extends ProcurementUpdateSupplierRequest {
  @override
  final String? name;
  @override
  final String? contactPerson;
  @override
  final String? phone;
  @override
  final String? secondaryPhone;
  @override
  final String? email;
  @override
  final String? address;
  @override
  final String? taxNumber;
  @override
  final bool? isActive;
  @override
  final ProcurementUpdateSupplierRequestPaymentTermsEnum? paymentTerms;
  @override
  final num? creditLimit;
  @override
  final String? notes;

  factory _$ProcurementUpdateSupplierRequest([
    void Function(ProcurementUpdateSupplierRequestBuilder)? updates,
  ]) => (ProcurementUpdateSupplierRequestBuilder()..update(updates))._build();

  _$ProcurementUpdateSupplierRequest._({
    this.name,
    this.contactPerson,
    this.phone,
    this.secondaryPhone,
    this.email,
    this.address,
    this.taxNumber,
    this.isActive,
    this.paymentTerms,
    this.creditLimit,
    this.notes,
  }) : super._();
  @override
  ProcurementUpdateSupplierRequest rebuild(
    void Function(ProcurementUpdateSupplierRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementUpdateSupplierRequestBuilder toBuilder() =>
      ProcurementUpdateSupplierRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementUpdateSupplierRequest &&
        name == other.name &&
        contactPerson == other.contactPerson &&
        phone == other.phone &&
        secondaryPhone == other.secondaryPhone &&
        email == other.email &&
        address == other.address &&
        taxNumber == other.taxNumber &&
        isActive == other.isActive &&
        paymentTerms == other.paymentTerms &&
        creditLimit == other.creditLimit &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, contactPerson.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, secondaryPhone.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, taxNumber.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, paymentTerms.hashCode);
    _$hash = $jc(_$hash, creditLimit.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProcurementUpdateSupplierRequest')
          ..add('name', name)
          ..add('contactPerson', contactPerson)
          ..add('phone', phone)
          ..add('secondaryPhone', secondaryPhone)
          ..add('email', email)
          ..add('address', address)
          ..add('taxNumber', taxNumber)
          ..add('isActive', isActive)
          ..add('paymentTerms', paymentTerms)
          ..add('creditLimit', creditLimit)
          ..add('notes', notes))
        .toString();
  }
}

class ProcurementUpdateSupplierRequestBuilder
    implements
        Builder<
          ProcurementUpdateSupplierRequest,
          ProcurementUpdateSupplierRequestBuilder
        > {
  _$ProcurementUpdateSupplierRequest? _$v;

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

  ProcurementUpdateSupplierRequestPaymentTermsEnum? _paymentTerms;
  ProcurementUpdateSupplierRequestPaymentTermsEnum? get paymentTerms =>
      _$this._paymentTerms;
  set paymentTerms(
    ProcurementUpdateSupplierRequestPaymentTermsEnum? paymentTerms,
  ) => _$this._paymentTerms = paymentTerms;

  num? _creditLimit;
  num? get creditLimit => _$this._creditLimit;
  set creditLimit(num? creditLimit) => _$this._creditLimit = creditLimit;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  ProcurementUpdateSupplierRequestBuilder() {
    ProcurementUpdateSupplierRequest._defaults(this);
  }

  ProcurementUpdateSupplierRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _contactPerson = $v.contactPerson;
      _phone = $v.phone;
      _secondaryPhone = $v.secondaryPhone;
      _email = $v.email;
      _address = $v.address;
      _taxNumber = $v.taxNumber;
      _isActive = $v.isActive;
      _paymentTerms = $v.paymentTerms;
      _creditLimit = $v.creditLimit;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementUpdateSupplierRequest other) {
    _$v = other as _$ProcurementUpdateSupplierRequest;
  }

  @override
  void update(void Function(ProcurementUpdateSupplierRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementUpdateSupplierRequest build() => _build();

  _$ProcurementUpdateSupplierRequest _build() {
    final _$result =
        _$v ??
        _$ProcurementUpdateSupplierRequest._(
          name: name,
          contactPerson: contactPerson,
          phone: phone,
          secondaryPhone: secondaryPhone,
          email: email,
          address: address,
          taxNumber: taxNumber,
          isActive: isActive,
          paymentTerms: paymentTerms,
          creditLimit: creditLimit,
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
