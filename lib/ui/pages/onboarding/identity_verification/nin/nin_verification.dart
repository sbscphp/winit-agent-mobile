import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/nin/nin_liveliness_check.dart';

import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/utilities/utilities.dart';
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

  final _nin = TextEditingController();
  final _confirmNin = TextEditingController();
  final _formKey = GlobalKey<FormState>();


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
          child: Form(
            key: _formKey,
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
                          controller: _nin,
                          keyboardType: TextInputType.number,
                          bottomHintText: 'Dial *346# on your mobile phone and select "NIN Retrieval',
                          validator: (value) => FieldValidator.validateLength(value, requiredLength: 11, errorMessage: 'NIN must be 11 digits.'),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(height: 24.h,),
                        OnboardingTextField(
                          label: 'Confirm NIN',
                          hintText: 'Enter 11-digit NIN',
                          controller: _confirmNin,
                          validator: (value) => FieldValidator.compareAndConfirm(value, source: _nin.text, errorMessage: 'Your NINs don’t match.'),
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
                CustomButton(
                    buttonText: 'Continue',
                    onPressed: (){
                      Utilities.hideKeyboard(context);
                      final validate = _formKey.currentState!.validate();
                      if(validate){
                        pushNavigation(context: context, widget: NinLivelinessCheck(nin: _nin.text,), routeName: NamedRoutes.ninLivelinessCheck);
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
