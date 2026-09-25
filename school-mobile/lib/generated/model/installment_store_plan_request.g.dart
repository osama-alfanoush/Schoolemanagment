// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_store_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InstallmentStorePlanRequestFrequencyEnum
_$installmentStorePlanRequestFrequencyEnum_monthly =
    const InstallmentStorePlanRequestFrequencyEnum._('monthly');
const InstallmentStorePlanRequestFrequencyEnum
_$installmentStorePlanRequestFrequencyEnum_quarterly =
    const InstallmentStorePlanRequestFrequencyEnum._('quarterly');

InstallmentStorePlanRequestFrequencyEnum
_$installmentStorePlanRequestFrequencyEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$installmentStorePlanRequestFrequencyEnum_monthly;
    case 'quarterly':
      return _$installmentStorePlanRequestFrequencyEnum_quarterly;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InstallmentStorePlanRequestFrequencyEnum>
_$installmentStorePlanRequestFrequencyEnumValues =
    BuiltSet<InstallmentStorePlanRequestFrequencyEnum>(
      const <InstallmentStorePlanRequestFrequencyEnum>[
        _$installmentStorePlanRequestFrequencyEnum_monthly,
        _$installmentStorePlanRequestFrequencyEnum_quarterly,
      ],
    );

Serializer<InstallmentStorePlanRequestFrequencyEnum>
_$installmentStorePlanRequestFrequencyEnumSerializer =
    _$InstallmentStorePlanRequestFrequencyEnumSerializer();

class _$InstallmentStorePlanRequestFrequencyEnumSerializer
    implements PrimitiveSerializer<InstallmentStorePlanRequestFrequencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'monthly': 'monthly',
    'quarterly': 'quarterly',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'monthly': 'monthly',
    'quarterly': 'quarterly',
  };

  @override
  final Iterable<Type> types = const <Type>[
    InstallmentStorePlanRequestFrequencyEnum,
  ];
  @override
  final String wireName = 'InstallmentStorePlanRequestFrequencyEnum';

  @override
  Object serialize(
    Serializers serializers,
    InstallmentStorePlanRequestFrequencyEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  InstallmentStorePlanRequestFrequencyEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => InstallmentStorePlanRequestFrequencyEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$InstallmentStorePlanRequest extends InstallmentStorePlanRequest {
  @override
  final int studentUserId;
  @override
  final int? invoiceId;
  @override
  final num totalAmount;
  @override
  final num? downPayment;
  @override
  final int numInstallments;
  @override
  final InstallmentStorePlanRequestFrequencyEnum? frequency;
  @override
  final DateTime startDate;

  factory _$InstallmentStorePlanRequest([
    void Function(InstallmentStorePlanRequestBuilder)? updates,
  ]) => (InstallmentStorePlanRequestBuilder()..update(updates))._build();

  _$InstallmentStorePlanRequest._({
    required this.studentUserId,
    this.invoiceId,
    required this.totalAmount,
    this.downPayment,
    required this.numInstallments,
    this.frequency,
    required this.startDate,
  }) : super._();
  @override
  InstallmentStorePlanRequest rebuild(
    void Function(InstallmentStorePlanRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  InstallmentStorePlanRequestBuilder toBuilder() =>
      InstallmentStorePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstallmentStorePlanRequest &&
        studentUserId == other.studentUserId &&
        invoiceId == other.invoiceId &&
        totalAmount == other.totalAmount &&
        downPayment == other.downPayment &&
        numInstallments == other.numInstallments &&
        frequency == other.frequency &&
        startDate == other.startDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, totalAmount.hashCode);
    _$hash = $jc(_$hash, downPayment.hashCode);
    _$hash = $jc(_$hash, numInstallments.hashCode);
    _$hash = $jc(_$hash, frequency.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InstallmentStorePlanRequest')
          ..add('studentUserId', studentUserId)
          ..add('invoiceId', invoiceId)
          ..add('totalAmount', totalAmount)
          ..add('downPayment', downPayment)
          ..add('numInstallments', numInstallments)
          ..add('frequency', frequency)
          ..add('startDate', startDate))
        .toString();
  }
}

class InstallmentStorePlanRequestBuilder
    implements
        Builder<
          InstallmentStorePlanRequest,
          InstallmentStorePlanRequestBuilder
        > {
  _$InstallmentStorePlanRequest? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _invoiceId;
  int? get invoiceId => _$this._invoiceId;
  set invoiceId(int? invoiceId) => _$this._invoiceId = invoiceId;

  num? _totalAmount;
  num? get totalAmount => _$this._totalAmount;
  set totalAmount(num? totalAmount) => _$this._totalAmount = totalAmount;

  num? _downPayment;
  num? get downPayment => _$this._downPayment;
  set downPayment(num? downPayment) => _$this._downPayment = downPayment;

  int? _numInstallments;
  int? get numInstallments => _$this._numInstallments;
  set numInstallments(int? numInstallments) =>
      _$this._numInstallments = numInstallments;

  InstallmentStorePlanRequestFrequencyEnum? _frequency;
  InstallmentStorePlanRequestFrequencyEnum? get frequency => _$this._frequency;
  set frequency(InstallmentStorePlanRequestFrequencyEnum? frequency) =>
      _$this._frequency = frequency;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  InstallmentStorePlanRequestBuilder() {
    InstallmentStorePlanRequest._defaults(this);
  }

  InstallmentStorePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _invoiceId = $v.invoiceId;
      _totalAmount = $v.totalAmount;
      _downPayment = $v.downPayment;
      _numInstallments = $v.numInstallments;
      _frequency = $v.frequency;
      _startDate = $v.startDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InstallmentStorePlanRequest other) {
    _$v = other as _$InstallmentStorePlanRequest;
  }

  @override
  void update(void Function(InstallmentStorePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InstallmentStorePlanRequest build() => _build();

  _$InstallmentStorePlanRequest _build() {
    final _$result =
        _$v ??
        _$InstallmentStorePlanRequest._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'InstallmentStorePlanRequest',
            'studentUserId',
          ),
          invoiceId: invoiceId,
          totalAmount: BuiltValueNullFieldError.checkNotNull(
            totalAmount,
            r'InstallmentStorePlanRequest',
            'totalAmount',
          ),
          downPayment: downPayment,
          numInstallments: BuiltValueNullFieldError.checkNotNull(
            numInstallments,
            r'InstallmentStorePlanRequest',
            'numInstallments',
          ),
          frequency: frequency,
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'InstallmentStorePlanRequest',
            'startDate',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
