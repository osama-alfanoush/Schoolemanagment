// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_setting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SchoolSetting extends SchoolSetting {
  @override
  final int id;
  @override
  final String schoolName;
  @override
  final String? schoolMotto;
  @override
  final String academicYear;
  @override
  final String? address;
  @override
  final String primaryColor;
  @override
  final String accentColor;
  @override
  final String sidebarStyle;
  @override
  final String borderRadius;
  @override
  final String fontStyle;
  @override
  final String? schoolLogo;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$SchoolSetting([void Function(SchoolSettingBuilder)? updates]) =>
      (SchoolSettingBuilder()..update(updates))._build();

  _$SchoolSetting._({
    required this.id,
    required this.schoolName,
    this.schoolMotto,
    required this.academicYear,
    this.address,
    required this.primaryColor,
    required this.accentColor,
    required this.sidebarStyle,
    required this.borderRadius,
    required this.fontStyle,
    this.schoolLogo,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  SchoolSetting rebuild(void Function(SchoolSettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SchoolSettingBuilder toBuilder() => SchoolSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SchoolSetting &&
        id == other.id &&
        schoolName == other.schoolName &&
        schoolMotto == other.schoolMotto &&
        academicYear == other.academicYear &&
        address == other.address &&
        primaryColor == other.primaryColor &&
        accentColor == other.accentColor &&
        sidebarStyle == other.sidebarStyle &&
        borderRadius == other.borderRadius &&
        fontStyle == other.fontStyle &&
        schoolLogo == other.schoolLogo &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, schoolName.hashCode);
    _$hash = $jc(_$hash, schoolMotto.hashCode);
    _$hash = $jc(_$hash, academicYear.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, primaryColor.hashCode);
    _$hash = $jc(_$hash, accentColor.hashCode);
    _$hash = $jc(_$hash, sidebarStyle.hashCode);
    _$hash = $jc(_$hash, borderRadius.hashCode);
    _$hash = $jc(_$hash, fontStyle.hashCode);
    _$hash = $jc(_$hash, schoolLogo.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SchoolSetting')
          ..add('id', id)
          ..add('schoolName', schoolName)
          ..add('schoolMotto', schoolMotto)
          ..add('academicYear', academicYear)
          ..add('address', address)
          ..add('primaryColor', primaryColor)
          ..add('accentColor', accentColor)
          ..add('sidebarStyle', sidebarStyle)
          ..add('borderRadius', borderRadius)
          ..add('fontStyle', fontStyle)
          ..add('schoolLogo', schoolLogo)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class SchoolSettingBuilder
    implements Builder<SchoolSetting, SchoolSettingBuilder> {
  _$SchoolSetting? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _schoolName;
  String? get schoolName => _$this._schoolName;
  set schoolName(String? schoolName) => _$this._schoolName = schoolName;

  String? _schoolMotto;
  String? get schoolMotto => _$this._schoolMotto;
  set schoolMotto(String? schoolMotto) => _$this._schoolMotto = schoolMotto;

  String? _academicYear;
  String? get academicYear => _$this._academicYear;
  set academicYear(String? academicYear) => _$this._academicYear = academicYear;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _primaryColor;
  String? get primaryColor => _$this._primaryColor;
  set primaryColor(String? primaryColor) => _$this._primaryColor = primaryColor;

  String? _accentColor;
  String? get accentColor => _$this._accentColor;
  set accentColor(String? accentColor) => _$this._accentColor = accentColor;

  String? _sidebarStyle;
  String? get sidebarStyle => _$this._sidebarStyle;
  set sidebarStyle(String? sidebarStyle) => _$this._sidebarStyle = sidebarStyle;

  String? _borderRadius;
  String? get borderRadius => _$this._borderRadius;
  set borderRadius(String? borderRadius) => _$this._borderRadius = borderRadius;

  String? _fontStyle;
  String? get fontStyle => _$this._fontStyle;
  set fontStyle(String? fontStyle) => _$this._fontStyle = fontStyle;

  String? _schoolLogo;
  String? get schoolLogo => _$this._schoolLogo;
  set schoolLogo(String? schoolLogo) => _$this._schoolLogo = schoolLogo;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  SchoolSettingBuilder() {
    SchoolSetting._defaults(this);
  }

  SchoolSettingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _schoolName = $v.schoolName;
      _schoolMotto = $v.schoolMotto;
      _academicYear = $v.academicYear;
      _address = $v.address;
      _primaryColor = $v.primaryColor;
      _accentColor = $v.accentColor;
      _sidebarStyle = $v.sidebarStyle;
      _borderRadius = $v.borderRadius;
      _fontStyle = $v.fontStyle;
      _schoolLogo = $v.schoolLogo;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SchoolSetting other) {
    _$v = other as _$SchoolSetting;
  }

  @override
  void update(void Function(SchoolSettingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SchoolSetting build() => _build();

  _$SchoolSetting _build() {
    final _$result =
        _$v ??
        _$SchoolSetting._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SchoolSetting', 'id'),
          schoolName: BuiltValueNullFieldError.checkNotNull(
            schoolName,
            r'SchoolSetting',
            'schoolName',
          ),
          schoolMotto: schoolMotto,
          academicYear: BuiltValueNullFieldError.checkNotNull(
            academicYear,
            r'SchoolSetting',
            'academicYear',
          ),
          address: address,
          primaryColor: BuiltValueNullFieldError.checkNotNull(
            primaryColor,
            r'SchoolSetting',
            'primaryColor',
          ),
          accentColor: BuiltValueNullFieldError.checkNotNull(
            accentColor,
            r'SchoolSetting',
            'accentColor',
          ),
          sidebarStyle: BuiltValueNullFieldError.checkNotNull(
            sidebarStyle,
            r'SchoolSetting',
            'sidebarStyle',
          ),
          borderRadius: BuiltValueNullFieldError.checkNotNull(
            borderRadius,
            r'SchoolSetting',
            'borderRadius',
          ),
          fontStyle: BuiltValueNullFieldError.checkNotNull(
            fontStyle,
            r'SchoolSetting',
            'fontStyle',
          ),
          schoolLogo: schoolLogo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'SchoolSetting',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
