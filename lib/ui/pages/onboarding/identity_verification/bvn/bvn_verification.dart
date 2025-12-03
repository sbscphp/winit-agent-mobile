import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/onboarding/identity_verification_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/identity_verification_result.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/identity_verification_summary.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/data/enum/view_state.dart';
import '../../../../../core/utilities/utilities.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_fields/onboarding_text_field.dart';
import '../../../../widgets/screen_title.dart';

class BvnVerification extends ConsumerStatefulWidget {
  const BvnVerification({super.key});

  @override
  ConsumerState<BvnVerification> createState() => _BvnVerificationState();
}

class _BvnVerificationState extends ConsumerState<BvnVerification> {

  final _bvn = TextEditingController();
  final _confirmBvn = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(identificationViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'BVN Verification Process',
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenTitle(title: 'Enter Bank Verification Number (BVN)',
                              subtitle: 'Enter your 11 digit BVN below'
                          ),
                          SizedBox(height: 16.h,),
                          OnboardingTextField(
                            label: 'BVN',
                            hintText: 'Enter 11-digit BVN',
                            controller: _bvn,
                            keyboardType: TextInputType.number,
                            bottomHintText: 'To check your BVN, dial *565* 0# on the phone number linked to your BVN',
                            validator: (value) => FieldValidator.validateLength(value, requiredLength: 11, errorMessage: 'BVN must be 11 digits.'),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          SizedBox(height: 24.h,),
                          OnboardingTextField(
                            label: 'Confirm BVN',
                            hintText: 'Confirm BVN',
                            controller: _confirmBvn,
                            validator: (value) => FieldValidator.compareAndConfirm(value, source: _bvn.text, errorMessage: 'Your BVNs don’t match.'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                CustomButton(
                    buttonText: 'Continue',
                    onPressed: ()async{
                      Utilities.hideKeyboard(context);
                      final validate = _formKey.currentState!.validate();
                      if(validate){
                        await vm.bvnVerification(bvn: _bvn.text);

                        if(vm.secondState == ViewState.retrieved){
                          pushNavigation(context: context, widget: const IdentityVerificationResult(), routeName: NamedRoutes.identityVerificationResult);
                        }

                        showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.secondState == ViewState.retrieved
                        );
                      }

                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
