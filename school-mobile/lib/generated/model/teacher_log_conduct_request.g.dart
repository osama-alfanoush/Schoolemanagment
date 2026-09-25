// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_log_conduct_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TeacherLogConductRequestCategoryEnum
_$teacherLogConductRequestCategoryEnum_positive =
    const TeacherLogConductRequestCategoryEnum._('positive');
const TeacherLogConductRequestCategoryEnum
_$teacherLogConductRequestCategoryEnum_warning =
    const TeacherLogConductRequestCategoryEnum._('warning');
const TeacherLogConductRequestCategoryEnum
_$teacherLogConductRequestCategoryEnum_incident =
    const TeacherLogConductRequestCategoryEnum._('incident');

TeacherLogConductRequestCategoryEnum
_$teacherLogConductRequestCategoryEnumValueOf(String name) {
  switch (name) {
    case 'positive':
      return _$teacherLogConductRequestCategoryEnum_positive;
    case 'warning':
      return _$teacherLogConductRequestCategoryEnum_warning;
    case 'incident':
      return _$teacherLogConductRequestCategoryEnum_incident;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TeacherLogConductRequestCategoryEnum>
_$teacherLogConductRequestCategoryEnumValues =
    BuiltSet<TeacherLogConductRequestCategoryEnum>(
      const <TeacherLogConductRequestCategoryEnum>[
        _$teacherLogConductRequestCategoryEnum_positive,
        _$teacherLogConductRequestCategoryEnum_warning,
        _$teacherLogConductRequestCategoryEnum_incident,
      ],
    );

Serializer<TeacherLogConductRequestCategoryEnum>
_$teacherLogConductRequestCategoryEnumSerializer =
    _$TeacherLogConductRequestCategoryEnumSerializer();

class _$TeacherLogConductRequestCategoryEnumSerializer
    implements PrimitiveSerializer<TeacherLogConductRequestCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'positive': 'positive',
    'warning': 'warning',
    'incident': 'incident',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'positive': 'positive',
    'warning': 'warning',
    'incident': 'incident',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TeacherLogConductRequestCategoryEnum,
  ];
  @override
  final String wireName = 'TeacherLogConductRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    TeacherLogConductRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  TeacherLogConductRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => TeacherLogConductRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$TeacherLogConductRequest extends TeacherLogConductRequest {
  @override
  final int studentUserId;
  @override
  final TeacherLogConductRequestCategoryEnum category;
  @override
  final String title;
  @override
  final String note;

  factory _$TeacherLogConductRequest([
    void Function(TeacherLogConductRequestBuilder)? updates,
  ]) => (TeacherLogConductRequestBuilder()..update(updates))._build();

  _$TeacherLogConductRequest._({
    required this.studentUserId,
    required this.category,
    required this.title,
    required this.note,
  }) : super._();
  @override
  TeacherLogConductRequest rebuild(
    void Function(TeacherLogConductRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherLogConductRequestBuilder toBuilder() =>
      TeacherLogConductRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherLogConductRequest &&
        studentUserId == other.studentUserId &&
        category == other.category &&
        title == other.title &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherLogConductRequest')
          ..add('studentUserId', studentUserId)
          ..add('category', category)
          ..add('title', title)
          ..add('note', note))
        .toString();
  }
}

class TeacherLogConductRequestBuilder
    implements
        Builder<TeacherLogConductRequest, TeacherLogConductRequestBuilder> {
  _$TeacherLogConductRequest? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  TeacherLogConductRequestCategoryEnum? _category;
  TeacherLogConductRequestCategoryEnum? get category => _$this._category;
  set category(TeacherLogConductRequestCategoryEnum? category) =>
      _$this._category = category;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  TeacherLogConductRequestBuilder() {
    TeacherLogConductRequest._defaults(this);
  }

  TeacherLogConductRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _category = $v.category;
      _title = $v.title;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherLogConductRequest other) {
    _$v = other as _$TeacherLogConductRequest;
  }

  @override
  void update(void Function(TeacherLogConductRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherLogConductRequest build() => _build();

  _$TeacherLogConductRequest _build() {
    final _$result =
        _$v ??
        _$TeacherLogConductRequest._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TeacherLogConductRequest',
            'studentUserId',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'TeacherLogConductRequest',
            'category',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'TeacherLogConductRequest',
            'title',
          ),
          note: BuiltValueNullFieldError.checkNotNull(
            note,
            r'TeacherLogConductRequest',
            'note',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
