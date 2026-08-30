// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_generate_invoices201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceGenerateInvoices201Response
    extends FinanceGenerateInvoices201Response {
  @override
  final int created;

  factory _$FinanceGenerateInvoices201Response([
    void Function(FinanceGenerateInvoices201ResponseBuilder)? updates,
  ]) => (FinanceGenerateInvoices201ResponseBuilder()..update(updates))._build();

  _$FinanceGenerateInvoices201Response._({required this.created}) : super._();
  @override
  FinanceGenerateInvoices201Response rebuild(
    void Function(FinanceGenerateInvoices201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceGenerateInvoices201ResponseBuilder toBuilder() =>
      FinanceGenerateInvoices201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceGenerateInvoices201Response &&
        created == other.created;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'FinanceGenerateInvoices201Response',
    )..add('created', created)).toString();
  }
}

class FinanceGenerateInvoices201ResponseBuilder
    implements
        Builder<
          FinanceGenerateInvoices201Response,
          FinanceGenerateInvoices201ResponseBuilder
        > {
  _$FinanceGenerateInvoices201Response? _$v;

  int? _created;
  int? get created => _$this._created;
  set created(int? created) => _$this._created = created;

  FinanceGenerateInvoices201ResponseBuilder() {
    FinanceGenerateInvoices201Response._defaults(this);
  }

  FinanceGenerateInvoices201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _created = $v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceGenerateInvoices201Response other) {
    _$v = other as _$FinanceGenerateInvoices201Response;
  }

  @override
  void update(
    void Function(FinanceGenerateInvoices201ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  FinanceGenerateInvoices201Response build() => _build();

  _$FinanceGenerateInvoices201Response _build() {
    final _$result =
        _$v ??
        _$FinanceGenerateInvoices201Response._(
          created: BuiltValueNullFieldError.checkNotNull(
            created,
            r'FinanceGenerateInvoices201Response',
            'created',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
