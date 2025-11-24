import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winit_agent/core/data/states/base_state.dart';


class OnboardingVm extends BaseState{

  String? onboardingStep;

  updateOnboardingStep({required String? val}){
    onboardingStep = val;
  }
}

final onboardingViewModel = ChangeNotifierProvider.autoDispose<OnboardingVm>((ref){
  return OnboardingVm();
});