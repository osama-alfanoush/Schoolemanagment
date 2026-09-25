// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_settings_index200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollSettingsIndex200Response
    extends PayrollSettingsIndex200Response {
  @override
  final HrPayrollSetting? general;
  @override
  final PayrollAccountSetting? accounts;
  @override
  final BuiltList<PayrollComponent> components;
  @override
  final BuiltList<SocialInsuranceScheme> socialInsuranceSchemes;

  factory _$PayrollSettingsIndex200Response([
    void Function(PayrollSettingsIndex200ResponseBuilder)? updates,
  ]) => (PayrollSettingsIndex200ResponseBuilder()..update(updates))._build();

  _$PayrollSettingsIndex200Response._({
    this.general,
    this.accounts,
    required this.components,
    required this.socialInsuranceSchemes,
  }) : super._();
  @override
  PayrollSettingsIndex200Response rebuild(
    void Function(PayrollSettingsIndex200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PayrollSettingsIndex200ResponseBuilder toBuilder() =>
      PayrollSettingsIndex200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollSettingsIndex200Response &&
        general == other.general &&
        accounts == other.accounts &&
        components == other.components &&
        socialInsuranceSchemes == other.socialInsuranceSchemes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, general.hashCode);
    _$hash = $jc(_$hash, accounts.hashCode);
    _$hash = $jc(_$hash, components.hashCode);
    _$hash = $jc(_$hash, socialInsuranceSchemes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollSettingsIndex200Response')
          ..add('general', general)
          ..add('accounts', accounts)
          ..add('components', components)
          ..add('socialInsuranceSchemes', socialInsuranceSchemes))
        .toString();
  }
}

class PayrollSettingsIndex200ResponseBuilder
    implements
        Builder<
          PayrollSettingsIndex200Response,
          PayrollSettingsIndex200ResponseBuilder
        > {
  _$PayrollSettingsIndex200Response? _$v;

  HrPayrollSettingBuilder? _general;
  HrPayrollSettingBuilder get general =>
      _$this._general ??= HrPayrollSettingBuilder();
  set general(HrPayrollSettingBuilder? general) => _$this._general = general;

  PayrollAccountSettingBuilder? _accounts;
  PayrollAccountSettingBuilder get accounts =>
      _$this._accounts ??= PayrollAccountSettingBuilder();
  set accounts(PayrollAccountSettingBuilder? accounts) =>
      _$this._accounts = accounts;

  ListBuilder<PayrollComponent>? _components;
  ListBuilder<PayrollComponent> get components =>
      _$this._components ??= ListBuilder<PayrollComponent>();
  set components(ListBuilder<PayrollComponent>? components) =>
      _$this._components = components;

  ListBuilder<SocialInsuranceScheme>? _socialInsuranceSchemes;
  ListBuilder<SocialInsuranceScheme> get socialInsuranceSchemes =>
      _$this._socialInsuranceSchemes ??= ListBuilder<SocialInsuranceScheme>();
  set socialInsuranceSchemes(
    ListBuilder<SocialInsuranceScheme>? socialInsuranceSchemes,
  ) => _$this._socialInsuranceSchemes = socialInsuranceSchemes;

  PayrollSettingsIndex200ResponseBuilder() {
    PayrollSettingsIndex200Response._defaults(this);
  }

  PayrollSettingsIndex200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _general = $v.general?.toBuilder();
      _accounts = $v.accounts?.toBuilder();
      _components = $v.components.toBuilder();
      _socialInsuranceSchemes = $v.socialInsuranceSchemes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollSettingsIndex200Response other) {
    _$v = other as _$PayrollSettingsIndex200Response;
  }

  @override
  void update(void Function(PayrollSettingsIndex200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollSettingsIndex200Response build() => _build();

  _$PayrollSettingsIndex200Response _build() {
    _$PayrollSettingsIndex200Response _$result;
    try {
      _$result =
          _$v ??
          _$PayrollSettingsIndex200Response._(
            general: _general?.build(),
            accounts: _accounts?.build(),
            components: components.build(),
            socialInsuranceSchemes: socialInsuranceSchemes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'general';
        _general?.build();
        _$failedField = 'accounts';
        _accounts?.build();
        _$failedField = 'components';
        components.build();
        _$failedField = 'socialInsuranceSchemes';
        socialInsuranceSchemes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PayrollSettingsIndex200Response',
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
