import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/nin/nin_liveliness_check.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/text_fields/onboarding_text_field.dart';
import '../../../../widgets/screen_title.dart';

class NinVerification extends StatefulWidget {
  const NinVerification({super.key});

  @override
  State<NinVerification> createState() => _NinVerificationState();
}

class _NinVerificationState extends State<NinVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Identity Verification with NIN',
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
                      ScreenTitle(title: 'Enter National Identification Number (NIN)',
                          subtitle: 'Enter your 11-digit NIN'
                      ),
                      SizedBox(height: 16.h,),
                      OnboardingTextField(
                        label: 'NIN',
                        hintText: 'Enter 11-digit NIN',
                        //controller: _loginChoice,
                        validator: FieldValidator.validate,
                        keyboardType: TextInputType.text,
                        bottomHintText: 'Dial *346# on your mobile phone and select "NIN Retrieval',
                      ),
                      SizedBox(height: 24.h,),
                      OnboardingTextField(
                        label: 'Confirm NIN',
                        hintText: 'Enter 11-digit NIN',
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
                    pushNavigation(context: context, widget: const NinLivelinessCheck(), routeName: NamedRoutes.ninLivelinessCheck);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
