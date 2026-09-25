// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_store_supplier_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProcurementStoreSupplierRequestPaymentTermsEnum
_$procurementStoreSupplierRequestPaymentTermsEnum_cash =
    const ProcurementStoreSupplierRequestPaymentTermsEnum._('cash');
const ProcurementStoreSupplierRequestPaymentTermsEnum
_$procurementStoreSupplierRequestPaymentTermsEnum_net15 =
    const ProcurementStoreSupplierRequestPaymentTermsEnum._('net15');
const ProcurementStoreSupplierRequestPaymentTermsEnum
_$procurementStoreSupplierRequestPaymentTermsEnum_net30 =
    const ProcurementStoreSupplierRequestPaymentTermsEnum._('net30');
const ProcurementStoreSupplierRequestPaymentTermsEnum
_$procurementStoreSupplierRequestPaymentTermsEnum_net60 =
    const ProcurementStoreSupplierRequestPaymentTermsEnum._('net60');

ProcurementStoreSupplierRequestPaymentTermsEnum
_$procurementStoreSupplierRequestPaymentTermsEnumValueOf(String name) {
  switch (name) {
    case 'cash':
      return _$procurementStoreSupplierRequestPaymentTermsEnum_cash;
    case 'net15':
      return _$procurementStoreSupplierRequestPaymentTermsEnum_net15;
    case 'net30':
      return _$procurementStoreSupplierRequestPaymentTermsEnum_net30;
    case 'net60':
      return _$procurementStoreSupplierRequestPaymentTermsEnum_net60;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ProcurementStoreSupplierRequestPaymentTermsEnum>
_$procurementStoreSupplierRequestPaymentTermsEnumValues =
    BuiltSet<ProcurementStoreSupplierRequestPaymentTermsEnum>(
      const <ProcurementStoreSupplierRequestPaymentTermsEnum>[
        _$procurementStoreSupplierRequestPaymentTermsEnum_cash,
        _$procurementStoreSupplierRequestPaymentTermsEnum_net15,
        _$procurementStoreSupplierRequestPaymentTermsEnum_net30,
        _$procurementStoreSupplierRequestPaymentTermsEnum_net60,
      ],
    );

Serializer<ProcurementStoreSupplierRequestPaymentTermsEnum>
_$procurementStoreSupplierRequestPaymentTermsEnumSerializer =
    _$ProcurementStoreSupplierRequestPaymentTermsEnumSerializer();

class _$ProcurementStoreSupplierRequestPaymentTermsEnumSerializer
    implements
        PrimitiveSerializer<ProcurementStoreSupplierRequestPaymentTermsEnum> {
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
    ProcurementStoreSupplierRequestPaymentTermsEnum,
  ];
  @override
  final String wireName = 'ProcurementStoreSupplierRequestPaymentTermsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ProcurementStoreSupplierRequestPaymentTermsEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ProcurementStoreSupplierRequestPaymentTermsEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ProcurementStoreSupplierRequestPaymentTermsEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ProcurementStoreSupplierRequest
    extends ProcurementStoreSupplierRequest {
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
  final ProcurementStoreSupplierRequestPaymentTermsEnum? paymentTerms;
  @override
  final num? creditLimit;
  @override
  final String? notes;

  factory _$ProcurementStoreSupplierRequest([
    void Function(ProcurementStoreSupplierRequestBuilder)? updates,
  ]) => (ProcurementStoreSupplierRequestBuilder()..update(updates))._build();

  _$ProcurementStoreSupplierRequest._({
    required this.name,
    this.contactPerson,
    required this.phone,
    this.secondaryPhone,
    this.email,
    this.address,
    this.taxNumber,
    this.paymentTerms,
    this.creditLimit,
    this.notes,
  }) : super._();
  @override
  ProcurementStoreSupplierRequest rebuild(
    void Function(ProcurementStoreSupplierRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementStoreSupplierRequestBuilder toBuilder() =>
      ProcurementStoreSupplierRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementStoreSupplierRequest &&
        name == other.name &&
        contactPerson == other.contactPerson &&
        phone == other.phone &&
        secondaryPhone == other.secondaryPhone &&
        email == other.email &&
        address == other.address &&
        taxNumber == other.taxNumber &&
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
    _$hash = $jc(_$hash, paymentTerms.hashCode);
    _$hash = $jc(_$hash, creditLimit.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProcurementStoreSupplierRequest')
          ..add('name', name)
          ..add('contactPerson', contactPerson)
          ..add('phone', phone)
          ..add('secondaryPhone', secondaryPhone)
          ..add('email', email)
          ..add('address', address)
          ..add('taxNumber', taxNumber)
          ..add('paymentTerms', paymentTerms)
          ..add('creditLimit', creditLimit)
          ..add('notes', notes))
        .toString();
  }
}

class ProcurementStoreSupplierRequestBuilder
    implements
        Builder<
          ProcurementStoreSupplierRequest,
          ProcurementStoreSupplierRequestBuilder
        > {
  _$ProcurementStoreSupplierRequest? _$v;

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

  ProcurementStoreSupplierRequestPaymentTermsEnum? _paymentTerms;
  ProcurementStoreSupplierRequestPaymentTermsEnum? get paymentTerms =>
      _$this._paymentTerms;
  set paymentTerms(
    ProcurementStoreSupplierRequestPaymentTermsEnum? paymentTerms,
  ) => _$this._paymentTerms = paymentTerms;

  num? _creditLimit;
  num? get creditLimit => _$this._creditLimit;
  set creditLimit(num? creditLimit) => _$this._creditLimit = creditLimit;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  ProcurementStoreSupplierRequestBuilder() {
    ProcurementStoreSupplierRequest._defaults(this);
  }

  ProcurementStoreSupplierRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _contactPerson = $v.contactPerson;
      _phone = $v.phone;
      _secondaryPhone = $v.secondaryPhone;
      _email = $v.email;
      _address = $v.address;
      _taxNumber = $v.taxNumber;
      _paymentTerms = $v.paymentTerms;
      _creditLimit = $v.creditLimit;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementStoreSupplierRequest other) {
    _$v = other as _$ProcurementStoreSupplierRequest;
  }

  @override
  void update(void Function(ProcurementStoreSupplierRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementStoreSupplierRequest build() => _build();

  _$ProcurementStoreSupplierRequest _build() {
    final _$result =
        _$v ??
        _$ProcurementStoreSupplierRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'ProcurementStoreSupplierRequest',
            'name',
          ),
          contactPerson: contactPerson,
          phone: BuiltValueNullFieldError.checkNotNull(
            phone,
            r'ProcurementStoreSupplierRequest',
            'phone',
          ),
          secondaryPhone: secondaryPhone,
          email: email,
          address: address,
          taxNumber: taxNumber,
          paymentTerms: paymentTerms,
          creditLimit: creditLimit,
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
