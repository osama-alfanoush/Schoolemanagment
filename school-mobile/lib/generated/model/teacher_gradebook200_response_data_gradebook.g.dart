// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_gradebook200_response_data_gradebook.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradebook200ResponseDataGradebook
    extends TeacherGradebook200ResponseDataGradebook {
  @override
  final int id;
  @override
  final String state;
  @override
  final bool editable;
  @override
  final String? reopenedUntil;

  factory _$TeacherGradebook200ResponseDataGradebook([
    void Function(TeacherGradebook200ResponseDataGradebookBuilder)? updates,
  ]) => (TeacherGradebook200ResponseDataGradebookBuilder()..update(updates))
      ._build();

  _$TeacherGradebook200ResponseDataGradebook._({
    required this.id,
    required this.state,
    required this.editable,
    this.reopenedUntil,
  }) : super._();
  @override
  TeacherGradebook200ResponseDataGradebook rebuild(
    void Function(TeacherGradebook200ResponseDataGradebookBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradebook200ResponseDataGradebookBuilder toBuilder() =>
      TeacherGradebook200ResponseDataGradebookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradebook200ResponseDataGradebook &&
        id == other.id &&
        state == other.state &&
        editable == other.editable &&
        reopenedUntil == other.reopenedUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, editable.hashCode);
    _$hash = $jc(_$hash, reopenedUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherGradebook200ResponseDataGradebook',
          )
          ..add('id', id)
          ..add('state', state)
          ..add('editable', editable)
          ..add('reopenedUntil', reopenedUntil))
        .toString();
  }
}

class TeacherGradebook200ResponseDataGradebookBuilder
    implements
        Builder<
          TeacherGradebook200ResponseDataGradebook,
          TeacherGradebook200ResponseDataGradebookBuilder
        > {
  _$TeacherGradebook200ResponseDataGradebook? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  bool? _editable;
  bool? get editable => _$this._editable;
  set editable(bool? editable) => _$this._editable = editable;

  String? _reopenedUntil;
  String? get reopenedUntil => _$this._reopenedUntil;
  set reopenedUntil(String? reopenedUntil) =>
      _$this._reopenedUntil = reopenedUntil;

  TeacherGradebook200ResponseDataGradebookBuilder() {
    TeacherGradebook200ResponseDataGradebook._defaults(this);
  }

  TeacherGradebook200ResponseDataGradebookBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _state = $v.state;
      _editable = $v.editable;
      _reopenedUntil = $v.reopenedUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradebook200ResponseDataGradebook other) {
    _$v = other as _$TeacherGradebook200ResponseDataGradebook;
  }

  @override
  void update(
    void Function(TeacherGradebook200ResponseDataGradebookBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradebook200ResponseDataGradebook build() => _build();

  _$TeacherGradebook200ResponseDataGradebook _build() {
    final _$result =
        _$v ??
        _$TeacherGradebook200ResponseDataGradebook._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TeacherGradebook200ResponseDataGradebook',
            'id',
          ),
          state: BuiltValueNullFieldError.checkNotNull(
            state,
            r'TeacherGradebook200ResponseDataGradebook',
            'state',
          ),
          editable: BuiltValueNullFieldError.checkNotNull(
            editable,
            r'TeacherGradebook200ResponseDataGradebook',
            'editable',
          ),
          reopenedUntil: reopenedUntil,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
