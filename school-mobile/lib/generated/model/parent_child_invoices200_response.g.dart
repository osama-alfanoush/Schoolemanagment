// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_invoices200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildInvoices200Response extends ParentChildInvoices200Response {
  @override
  final BuiltList<Invoice> invoices;
  @override
  final String outstandingTotal;

  factory _$ParentChildInvoices200Response([
    void Function(ParentChildInvoices200ResponseBuilder)? updates,
  ]) => (ParentChildInvoices200ResponseBuilder()..update(updates))._build();

  _$ParentChildInvoices200Response._({
    required this.invoices,
    required this.outstandingTotal,
  }) : super._();
  @override
  ParentChildInvoices200Response rebuild(
    void Function(ParentChildInvoices200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildInvoices200ResponseBuilder toBuilder() =>
      ParentChildInvoices200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildInvoices200Response &&
        invoices == other.invoices &&
        outstandingTotal == other.outstandingTotal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, invoices.hashCode);
    _$hash = $jc(_$hash, outstandingTotal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ParentChildInvoices200Response')
          ..add('invoices', invoices)
          ..add('outstandingTotal', outstandingTotal))
        .toString();
  }
}

class ParentChildInvoices200ResponseBuilder
    implements
        Builder<
          ParentChildInvoices200Response,
          ParentChildInvoices200ResponseBuilder
        > {
  _$ParentChildInvoices200Response? _$v;

  ListBuilder<Invoice>? _invoices;
  ListBuilder<Invoice> get invoices =>
      _$this._invoices ??= ListBuilder<Invoice>();
  set invoices(ListBuilder<Invoice>? invoices) => _$this._invoices = invoices;

  String? _outstandingTotal;
  String? get outstandingTotal => _$this._outstandingTotal;
  set outstandingTotal(String? outstandingTotal) =>
      _$this._outstandingTotal = outstandingTotal;

  ParentChildInvoices200ResponseBuilder() {
    ParentChildInvoices200Response._defaults(this);
  }

  ParentChildInvoices200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invoices = $v.invoices.toBuilder();
      _outstandingTotal = $v.outstandingTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildInvoices200Response other) {
    _$v = other as _$ParentChildInvoices200Response;
  }

  @override
  void update(void Function(ParentChildInvoices200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildInvoices200Response build() => _build();

  _$ParentChildInvoices200Response _build() {
    _$ParentChildInvoices200Response _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildInvoices200Response._(
            invoices: invoices.build(),
            outstandingTotal: BuiltValueNullFieldError.checkNotNull(
              outstandingTotal,
              r'ParentChildInvoices200Response',
              'outstandingTotal',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'invoices';
        invoices.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildInvoices200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
