import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/constants/app_constants.dart';
import 'package:winit_agent/core/data/data_provider/onboarding_data_provider/onboarding_data_provider.dart';
import 'package:winit_agent/core/data/enum/view_state.dart';
import 'package:winit_agent/core/data/states/base_state.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/locator.dart';

class OnboardingVm extends BaseState{

  String? onboardingStep;

  updateOnboardingStep({required String? val}){
    onboardingStep = val;
  }
}

final onboardingViewModel = ChangeNotifierProvider.autoDispose<OnboardingVm>((ref){
  return OnboardingVm();
});