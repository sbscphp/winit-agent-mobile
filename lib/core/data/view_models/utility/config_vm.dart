import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/models/agent_settlement_card_config.dart';
import 'package:winit_agent/core/data/models/agent_wallet_policy_config.dart';


import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/utility_data_provider/utility_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/frontend_links_configuration.dart';
import '../../models/registration_configuration.dart';
import '../../states/base_state.dart';

class ConfigVm extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //registration config
  RegistrationConfiguration? _registrationConfig;

  //front-end links config
  FrontendLinksConfiguration? _frontendLinksConfiguration;

  //agent wallet config
  AgentWalletPolicyConfig? _agentWalletPolicyConfig;

  //agent settlement card config
  AgentSettlementCardConfig? _agentSettlementCardConfig;

  bool get useEmailVerification => _registrationConfig?.verifyEmailOtp ?? false;
  bool get useLga => _registrationConfig?.useLga ?? true;
  bool get useLgaArea => _registrationConfig?.useLgaArea ?? false;

  bool get isWalletEnabled => _agentWalletPolicyConfig?.agentAccountEnabled ?? false;
  bool get showCommissionSettledCard => _agentSettlementCardConfig?.isEnabled ?? false;

  // String get faqLink => _frontendLinksConfiguration?.faq ?? 'https://winit-web-staging.winitgames.com/faq';
  // String get claimPrizeLink => _frontendLinksConfiguration?.claimPrize ?? 'https://winit-web-staging.winitgames.com/prize-claim';
  // String get gameRulesLink => _frontendLinksConfiguration?.gameRules ?? 'https://winit-web-staging.winitgames.com/policy?tab=Game%20Rules';
  // String get privacyPolicyLink => _frontendLinksConfiguration?.privacyPolicy ?? 'https://winit-web-staging.winitgames.com/policy';
  // String get contactUsLink => _frontendLinksConfiguration?.contactUs ?? 'https://winit-web-staging.winitgames.com/contact';

  //fetch config
  fetchConfig() async {
    setState(ViewState.busy);
    await _utilityDp.fetchConfig().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _registrationConfig = response.data?.registrationConfiguration;
      _frontendLinksConfiguration = response.data?.frontendLinksConfiguration;
      _agentWalletPolicyConfig = response.data?.agentWalletPolicyConfig;
      _agentSettlementCardConfig = response.data?.agentSettlementCardConfig;
      log('full response:::${response.data?.toJson().toString()}>>>');
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }



















}

final configViewModel = ChangeNotifierProvider<ConfigVm>((ref){
  return ConfigVm();
});