// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_generate_invoices_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceGenerateInvoicesRequest extends FinanceGenerateInvoicesRequest {
  @override
  final int feeStructureId;
  @override
  final DateTime dueDate;
  @override
  final BuiltList<String>? studentUserIds;
  @override
  final int? classRoomId;

  factory _$FinanceGenerateInvoicesRequest([
    void Function(FinanceGenerateInvoicesRequestBuilder)? updates,
  ]) => (FinanceGenerateInvoicesRequestBuilder()..update(updates))._build();

  _$FinanceGenerateInvoicesRequest._({
    required this.feeStructureId,
    required this.dueDate,
    this.studentUserIds,
    this.classRoomId,
  }) : super._();
  @override
  FinanceGenerateInvoicesRequest rebuild(
    void Function(FinanceGenerateInvoicesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceGenerateInvoicesRequestBuilder toBuilder() =>
      FinanceGenerateInvoicesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceGenerateInvoicesRequest &&
        feeStructureId == other.feeStructureId &&
        dueDate == other.dueDate &&
        studentUserIds == other.studentUserIds &&
        classRoomId == other.classRoomId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feeStructureId.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, studentUserIds.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceGenerateInvoicesRequest')
          ..add('feeStructureId', feeStructureId)
          ..add('dueDate', dueDate)
          ..add('studentUserIds', studentUserIds)
          ..add('classRoomId', classRoomId))
        .toString();
  }
}

class FinanceGenerateInvoicesRequestBuilder
    implements
        Builder<
          FinanceGenerateInvoicesRequest,
          FinanceGenerateInvoicesRequestBuilder
        > {
  _$FinanceGenerateInvoicesRequest? _$v;

  int? _feeStructureId;
  int? get feeStructureId => _$this._feeStructureId;
  set feeStructureId(int? feeStructureId) =>
      _$this._feeStructureId = feeStructureId;

  DateTime? _dueDate;
  DateTime? get dueDate => _$this._dueDate;
  set dueDate(DateTime? dueDate) => _$this._dueDate = dueDate;

  ListBuilder<String>? _studentUserIds;
  ListBuilder<String> get studentUserIds =>
      _$this._studentUserIds ??= ListBuilder<String>();
  set studentUserIds(ListBuilder<String>? studentUserIds) =>
      _$this._studentUserIds = studentUserIds;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  FinanceGenerateInvoicesRequestBuilder() {
    FinanceGenerateInvoicesRequest._defaults(this);
  }

  FinanceGenerateInvoicesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feeStructureId = $v.feeStructureId;
      _dueDate = $v.dueDate;
      _studentUserIds = $v.studentUserIds?.toBuilder();
      _classRoomId = $v.classRoomId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceGenerateInvoicesRequest other) {
    _$v = other as _$FinanceGenerateInvoicesRequest;
  }

  @override
  void update(void Function(FinanceGenerateInvoicesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceGenerateInvoicesRequest build() => _build();

  _$FinanceGenerateInvoicesRequest _build() {
    _$FinanceGenerateInvoicesRequest _$result;
    try {
      _$result =
          _$v ??
          _$FinanceGenerateInvoicesRequest._(
            feeStructureId: BuiltValueNullFieldError.checkNotNull(
              feeStructureId,
              r'FinanceGenerateInvoicesRequest',
              'feeStructureId',
            ),
            dueDate: BuiltValueNullFieldError.checkNotNull(
              dueDate,
              r'FinanceGenerateInvoicesRequest',
              'dueDate',
            ),
            studentUserIds: _studentUserIds?.build(),
            classRoomId: classRoomId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'studentUserIds';
        _studentUserIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FinanceGenerateInvoicesRequest',
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
