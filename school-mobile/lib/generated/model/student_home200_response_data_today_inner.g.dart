// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_home200_response_data_today_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentHome200ResponseDataTodayInner
    extends StudentHome200ResponseDataTodayInner {
  @override
  final int id;
  @override
  final String subject;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String room;

  factory _$StudentHome200ResponseDataTodayInner([
    void Function(StudentHome200ResponseDataTodayInnerBuilder)? updates,
  ]) =>
      (StudentHome200ResponseDataTodayInnerBuilder()..update(updates))._build();

  _$StudentHome200ResponseDataTodayInner._({
    required this.id,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.room,
  }) : super._();
  @override
  StudentHome200ResponseDataTodayInner rebuild(
    void Function(StudentHome200ResponseDataTodayInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentHome200ResponseDataTodayInnerBuilder toBuilder() =>
      StudentHome200ResponseDataTodayInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentHome200ResponseDataTodayInner &&
        id == other.id &&
        subject == other.subject &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        room == other.room;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentHome200ResponseDataTodayInner')
          ..add('id', id)
          ..add('subject', subject)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('room', room))
        .toString();
  }
}

class StudentHome200ResponseDataTodayInnerBuilder
    implements
        Builder<
          StudentHome200ResponseDataTodayInner,
          StudentHome200ResponseDataTodayInnerBuilder
        > {
  _$StudentHome200ResponseDataTodayInner? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  String? _room;
  String? get room => _$this._room;
  set room(String? room) => _$this._room = room;

  StudentHome200ResponseDataTodayInnerBuilder() {
    StudentHome200ResponseDataTodayInner._defaults(this);
  }

  StudentHome200ResponseDataTodayInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _subject = $v.subject;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _room = $v.room;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentHome200ResponseDataTodayInner other) {
    _$v = other as _$StudentHome200ResponseDataTodayInner;
  }

  @override
  void update(
    void Function(StudentHome200ResponseDataTodayInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  StudentHome200ResponseDataTodayInner build() => _build();

  _$StudentHome200ResponseDataTodayInner _build() {
    final _$result =
        _$v ??
        _$StudentHome200ResponseDataTodayInner._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'StudentHome200ResponseDataTodayInner',
            'id',
          ),
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'StudentHome200ResponseDataTodayInner',
            'subject',
          ),
          startTime: BuiltValueNullFieldError.checkNotNull(
            startTime,
            r'StudentHome200ResponseDataTodayInner',
            'startTime',
          ),
          endTime: BuiltValueNullFieldError.checkNotNull(
            endTime,
            r'StudentHome200ResponseDataTodayInner',
            'endTime',
          ),
          room: BuiltValueNullFieldError.checkNotNull(
            room,
            r'StudentHome200ResponseDataTodayInner',
            'room',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
