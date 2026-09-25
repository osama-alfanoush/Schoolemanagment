// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradebook_issue201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradebookIssue201Response extends GradebookIssue201Response {
  @override
  final ReportCardIssue data;

  factory _$GradebookIssue201Response([
    void Function(GradebookIssue201ResponseBuilder)? updates,
  ]) => (GradebookIssue201ResponseBuilder()..update(updates))._build();

  _$GradebookIssue201Response._({required this.data}) : super._();
  @override
  GradebookIssue201Response rebuild(
    void Function(GradebookIssue201ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradebookIssue201ResponseBuilder toBuilder() =>
      GradebookIssue201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradebookIssue201Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GradebookIssue201Response',
    )..add('data', data)).toString();
  }
}

class GradebookIssue201ResponseBuilder
    implements
        Builder<GradebookIssue201Response, GradebookIssue201ResponseBuilder> {
  _$GradebookIssue201Response? _$v;

  ReportCardIssueBuilder? _data;
  ReportCardIssueBuilder get data => _$this._data ??= ReportCardIssueBuilder();
  set data(ReportCardIssueBuilder? data) => _$this._data = data;

  GradebookIssue201ResponseBuilder() {
    GradebookIssue201Response._defaults(this);
  }

  GradebookIssue201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradebookIssue201Response other) {
    _$v = other as _$GradebookIssue201Response;
  }

  @override
  void update(void Function(GradebookIssue201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradebookIssue201Response build() => _build();

  _$GradebookIssue201Response _build() {
    _$GradebookIssue201Response _$result;
    try {
      _$result = _$v ?? _$GradebookIssue201Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradebookIssue201Response',
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
