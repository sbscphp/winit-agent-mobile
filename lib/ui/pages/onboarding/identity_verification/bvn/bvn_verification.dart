import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/identity_verification_summary.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_fields/onboarding_text_field.dart';
import '../../../../widgets/screen_title.dart';

class BvnVerification extends StatefulWidget {
  const BvnVerification({super.key});

  @override
  State<BvnVerification> createState() => _BvnVerificationState();
}

class _BvnVerificationState extends State<BvnVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        //controller: _loginChoice,
                        validator: FieldValidator.validate,
                        keyboardType: TextInputType.text,
                        bottomHintText: 'To check your BVN, dial *565* 0# on the phone number linked to your BVN',
                      ),
                      SizedBox(height: 24.h,),
                      OnboardingTextField(
                        label: 'Confirm BVN',
                        hintText: 'Confirm BVN',
                        //controller: _loginChoice,
                        validator: FieldValidator.validate,
                        keyboardType: TextInputType.text,
                      ),

                    ],
                  ),
                ),
              ),
              CustomButton(
                  buttonText: 'Continue',
                  onPressed: (){
                    pushNavigation(context: context, widget: const IdentityVerificationSummary(), routeName: NamedRoutes.identityVerificationSummary);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
