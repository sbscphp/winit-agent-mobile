import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/add_bank_details.dart';
import 'package:winit_agent/ui/widgets/custom_divider.dart';
import 'package:winit_agent/ui/widgets/text_fields/multi_select_dropdown.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/text_fields/onboarding_drop_down.dart';
import '../../widgets/text_fields/onboarding_text_field.dart';

class AddBusinessDetails extends StatefulWidget {
  const AddBusinessDetails({super.key});

  @override
  State<AddBusinessDetails> createState() => _AddBusinessDetailsState();
}

class _AddBusinessDetailsState extends State<AddBusinessDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Business Details',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(title: 'Add Business Details',
                  subtitle: 'Add business details to your WinIt Agent account setup.'
              ),
              SizedBox(height: 24.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCheckBox(
                      height: 24,
                      width: 24,
                      color: ColorPath.mischkaGrey,
                      onchanged: (value){

                      }
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'Personal Details is the same as Business Details',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Tax Identification Number',
                hintText: 'Enter Tax Identification Number',
                //controller: _loginChoice,
                validator: FieldValidator.validate,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Business Phone Number 2 (optional)',
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
                label: 'Business Email address 1',
                hintText: 'Enter email',
                //controller: _loginChoice,
                validator: EmailValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Business Email address 2 (optional)',
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
                bottomHintText: 'We currently operate only within Lagos State. ',
              ),
              SizedBox(height: 16.h,),
              OnboardingTextField(
                label: 'Business Address',
                hintText: 'Enter Business Address',
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
              SizedBox(height: 16.h,),
              currentBusiness(),
              SizedBox(height: 42.h,),
              CustomButton(
                  onPressed: (){
                    pushNavigation(context: context, widget: const AddBankDetails(), routeName: NamedRoutes.addBankDetails);
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }

  currentBusiness(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenTitle(
            title: 'Current Business',
            titleColor: ColorPath.oxfordBlue,
            titleFontWeight: FontWeight.w700,
            subtitle: 'Please select the type(s) of business you currently operate'
        ),
        SizedBox(height: 16.h,),
        ScreenTitle(
            title: 'Financial Agent',
            titleFontWeight: FontWeight.w600,
            subtitle: 'I currently operate POS as a business'
        ),
        SizedBox(height: 16.h,),
        MultiSelectDropdown(
          label: 'Bank(s)/ FinTech(s)',
          hintText: 'Select all the Bank(s)/FinTech(s) you currently work with',
          dropdownTitle: 'POS Principal',
          dropdownSubtitle: 'A list of POS Companies',
          options: [
            'Apple',
            'Banana',
            'Orange',
            'Pear',
            'Melon'
          ],
          selectedItemsReturned: (value){
            print('returned items::::$value>>>>>');
          },

        ),
        CustomDivider(
          verticalSpace: 16.h,
        ),
        ScreenTitle(
            title: 'Lottery',
            titleFontWeight: FontWeight.w600,
            subtitle: 'I currently work as an agent for a lottery company'
        ),
        SizedBox(height: 16.h,),
        MultiSelectDropdown(
          label: 'Lottery Company',
          hintText: 'Select all the lottery companies you currently work with',
          dropdownTitle: 'Lottery Agent',
          dropdownSubtitle: 'A list of lottery Companies',
          options: [
            'Apple',
            'Banana',
            'Orange',
            'Pear',
            'Melon'
          ],
          selectedItemsReturned: (value){
            print('returned items::::$value>>>>>');
          },

        ),
        CustomDivider(
          verticalSpace: 16.h,
        ),
        ScreenTitle(
            title: 'Others',
            titleFontWeight: FontWeight.w600,
            subtitle: 'Please specify your current business'
        ),
        SizedBox(height: 16.h,),
        OnboardingTextField(
          label: 'Business type',
          hintText: 'Enter Details',
          //controller: _loginChoice,
          keyboardType: TextInputType.text,
          bottomHintText: 'e.g., retail, catering, beauty salon',
        ),
      ],
    );
  }
}
