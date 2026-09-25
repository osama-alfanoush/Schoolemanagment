// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Announcement extends Announcement {
  @override
  final int id;
  @override
  final int senderUserId;
  @override
  final String audience;
  @override
  final String title;
  @override
  final String body;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;
  @override
  final String? templateKey;
  @override
  final String? idempotencyKey;

  factory _$Announcement([void Function(AnnouncementBuilder)? updates]) =>
      (AnnouncementBuilder()..update(updates))._build();

  _$Announcement._({
    required this.id,
    required this.senderUserId,
    required this.audience,
    required this.title,
    required this.body,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.templateKey,
    this.idempotencyKey,
  }) : super._();
  @override
  Announcement rebuild(void Function(AnnouncementBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AnnouncementBuilder toBuilder() => AnnouncementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Announcement &&
        id == other.id &&
        senderUserId == other.senderUserId &&
        audience == other.audience &&
        title == other.title &&
        body == other.body &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        templateKey == other.templateKey &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, senderUserId.hashCode);
    _$hash = $jc(_$hash, audience.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, templateKey.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Announcement')
          ..add('id', id)
          ..add('senderUserId', senderUserId)
          ..add('audience', audience)
          ..add('title', title)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('templateKey', templateKey)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class AnnouncementBuilder
    implements Builder<Announcement, AnnouncementBuilder> {
  _$Announcement? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _senderUserId;
  int? get senderUserId => _$this._senderUserId;
  set senderUserId(int? senderUserId) => _$this._senderUserId = senderUserId;

  String? _audience;
  String? get audience => _$this._audience;
  set audience(String? audience) => _$this._audience = audience;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _templateKey;
  String? get templateKey => _$this._templateKey;
  set templateKey(String? templateKey) => _$this._templateKey = templateKey;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  AnnouncementBuilder() {
    Announcement._defaults(this);
  }

  AnnouncementBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _senderUserId = $v.senderUserId;
      _audience = $v.audience;
      _title = $v.title;
      _body = $v.body;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _templateKey = $v.templateKey;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Announcement other) {
    _$v = other as _$Announcement;
  }

  @override
  void update(void Function(AnnouncementBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Announcement build() => _build();

  _$Announcement _build() {
    final _$result =
        _$v ??
        _$Announcement._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Announcement', 'id'),
          senderUserId: BuiltValueNullFieldError.checkNotNull(
            senderUserId,
            r'Announcement',
            'senderUserId',
          ),
          audience: BuiltValueNullFieldError.checkNotNull(
            audience,
            r'Announcement',
            'audience',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'Announcement',
            'title',
          ),
          body: BuiltValueNullFieldError.checkNotNull(
            body,
            r'Announcement',
            'body',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Announcement',
            'schoolId',
          ),
          templateKey: templateKey,
          idempotencyKey: idempotencyKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
