import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/alert_dialogs/action_completed.dart';
import '../../../widgets/alert_dialogs/base_dialog.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/display_image.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/text_fields/onboarding_drop_down.dart';
import '../../../widgets/text_fields/onboarding_text_field.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Personal Details',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(title: 'Personal Details',
                  subtitle: 'Add more details to your WinIt Agent account setup. '
              ),
              SizedBox(height: 24.h,),
              WinitContainer(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w
                ),
                  child: Row(
                    children: [
                      Stack(
                       clipBehavior: Clip.none,
                        children: [
                          DisplayImage(
                            addOverlay: true,
                            imageUrl: 'https://www.shutterstock.com/image-vector/portrait-handsome-man-confident-young-600nw-2616154679.jpg',
                            firstName: 'Ayodeji',
                            lastName: 'Ogundijo',
                            initialsSize: 16,
                            size: 43,
                          ),
                          Positioned(
                            left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: Center(child: CustomAssetViewer(asset: AppAsset.edit2, height: 16.h, width: 16.w,)))
                        ],
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dairo Agent LLC',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.textSecondary
                              ),
                            ),
                            SizedBox(height: 4.h,),
                            Text(
                              'KSF - 002390',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textTertiary
                              ),
                            ),
                                ],
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 24.h,),
              OnboardingTextField(
                label: 'Account linked Phone Number',
                hintText: 'Enter Account linked Phone Number',
                //controller: _loginChoice,
                validator: FieldValidator.validate,
                enabled: false,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(18),
                  NigerianPhoneNumberFormatter()
                ],
                bottomHintText: 'You cannot change your temporary Agent ID until you complete the full self-onboarding process',
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Phone Number 2 (optional)',
                hintText: 'Enter Phone Number',
                isCompulsory: false,
                //controller: _loginChoice,
                validator: FieldValidator.validate,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(18),
                  NigerianPhoneNumberFormatter()
                ],
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Email address 1',
                hintText: 'Enter email',
                //controller: _loginChoice,
                validator: EmailValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Email address 2 (optional)',
                hintText: 'Enter email',
                isCompulsory: false,
                //controller: _loginChoice,
                validator: EmailValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h,),
              OnboardingDropDown(
                hintText: "Select an option",
                label: 'Local Government (Lagos State) of residence',
                //value: null,
                items: ['a','b','c','d'],
                onChanged: (value){
        
                },
                bottomHintText: 'We currently operate only within Lagos State. ',
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Full House Address',
                hintText: 'Enter House Address',
                //controller: _loginChoice,
                keyboardType: TextInputType.text,
                bottomHintText: 'This should be inclusive of your house number, street name and other relevant details',
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Closest Landmark/Nearest Bus-stop',
                hintText: 'Enter Details',
                //controller: _loginChoice,
                keyboardType: TextInputType.text,
                bottomHintText: 'A well-known location near your address (e.g., shopping mall, petrol station, school, or bus stop). This helps us easily identify and confirm your location.',
              ),
              SizedBox(height: 42.h,),
              CustomButton(
                buttonText: 'Save Changes',
                  onPressed: (){
                    baseDialog(
                      context: context,
                      content: ActionCompleted(
                        title: 'Changes Saved ',
                        assetSize: 80,
                        subtitle:
                        'New Changes Saved and Updated',
                        onPressed: () {
                          popNavigation(context: context);
                        },
                      ),
                    );
                  }
              ),
        
        
            ],
          ),
        ),
      ),
    );
  }
}
