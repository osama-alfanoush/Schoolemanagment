// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CalendarEvent extends CalendarEvent {
  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String type;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$CalendarEvent([void Function(CalendarEventBuilder)? updates]) =>
      (CalendarEventBuilder()..update(updates))._build();

  _$CalendarEvent._({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  CalendarEvent rebuild(void Function(CalendarEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CalendarEventBuilder toBuilder() => CalendarEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CalendarEvent &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        type == other.type &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CalendarEvent')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('type', type)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class CalendarEventBuilder
    implements Builder<CalendarEvent, CalendarEventBuilder> {
  _$CalendarEvent? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  DateTime? _endDate;
  DateTime? get endDate => _$this._endDate;
  set endDate(DateTime? endDate) => _$this._endDate = endDate;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  CalendarEventBuilder() {
    CalendarEvent._defaults(this);
  }

  CalendarEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _type = $v.type;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CalendarEvent other) {
    _$v = other as _$CalendarEvent;
  }

  @override
  void update(void Function(CalendarEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CalendarEvent build() => _build();

  _$CalendarEvent _build() {
    final _$result =
        _$v ??
        _$CalendarEvent._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'CalendarEvent', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'CalendarEvent',
            'title',
          ),
          description: description,
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'CalendarEvent',
            'type',
          ),
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'CalendarEvent',
            'startDate',
          ),
          endDate: endDate,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'CalendarEvent',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
