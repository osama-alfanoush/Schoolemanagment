// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_student_assignments200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileStudentAssignments200ResponseData
    extends MobileStudentAssignments200ResponseData {
  @override
  final AnyOf anyOf;

  factory _$MobileStudentAssignments200ResponseData([
    void Function(MobileStudentAssignments200ResponseDataBuilder)? updates,
  ]) => (MobileStudentAssignments200ResponseDataBuilder()..update(updates))
      ._build();

  _$MobileStudentAssignments200ResponseData._({required this.anyOf})
    : super._();
  @override
  MobileStudentAssignments200ResponseData rebuild(
    void Function(MobileStudentAssignments200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MobileStudentAssignments200ResponseDataBuilder toBuilder() =>
      MobileStudentAssignments200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileStudentAssignments200ResponseData &&
        anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'MobileStudentAssignments200ResponseData',
    )..add('anyOf', anyOf)).toString();
  }
}

class MobileStudentAssignments200ResponseDataBuilder
    implements
        Builder<
          MobileStudentAssignments200ResponseData,
          MobileStudentAssignments200ResponseDataBuilder
        > {
  _$MobileStudentAssignments200ResponseData? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  MobileStudentAssignments200ResponseDataBuilder() {
    MobileStudentAssignments200ResponseData._defaults(this);
  }

  MobileStudentAssignments200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MobileStudentAssignments200ResponseData other) {
    _$v = other as _$MobileStudentAssignments200ResponseData;
  }

  @override
  void update(
    void Function(MobileStudentAssignments200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MobileStudentAssignments200ResponseData build() => _build();

  _$MobileStudentAssignments200ResponseData _build() {
    final _$result =
        _$v ??
        _$MobileStudentAssignments200ResponseData._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'MobileStudentAssignments200ResponseData',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
