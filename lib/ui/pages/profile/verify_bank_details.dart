import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/banks.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/text_fields/onboarding_drop_down.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/alert_dialogs/action_completed.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/text_fields/onboarding_text_field.dart';
import '../../widgets/screen_title.dart';

class VerifyBankDetails extends StatefulWidget {
  const VerifyBankDetails({super.key});

  @override
  State<VerifyBankDetails> createState() => _VerifyBankDetailsState();
}

class _VerifyBankDetailsState extends State<VerifyBankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Add Bank Account Details',
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
                      ScreenTitle(
                          title: 'Add Bank Account Details',
                          subtitle: 'Add a new bank account details with ease'
                      ),
                      SizedBox(height: 16.h,),
                      Clickable(
                        onPressed: (){
                          baseBottomSheet(
                            context: context,
                            content: Banks(),
                          );
                        },
                        child: OnboardingDropDown(
                          hintText: "Select Bank",
                          label: 'Bank',
                          value: null,
                          enabled: false,
                          items: const [],
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      OnboardingTextField(
                        label: 'Account Number',
                        hintText: 'Enter Account Number',
                        //controller: _loginChoice,
                        validator: FieldValidator.validate,
                        keyboardType: TextInputType.text,
                        bottomHintText: 'Enter 10 digit account number',
                      ),
                      SizedBox(height: 24.h,),
                      OnboardingTextField(
                        label: 'Account Name',
                        hintText: 'Auto-mated',
                        enabled: false,
                        //controller: _loginChoice,
                        validator: FieldValidator.validate,
                        keyboardType: TextInputType.text,
                        bottomHintText: 'Your account name is automatically generated from your account number',
                      ),
                      SizedBox(height: 16.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Set as Default ',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                Text(
                                  'Set this account number as the default for withdrawal',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )







                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Column(
                children: [
                  CustomButton(
                      buttonText: 'Add Bank Account Number',
                      suffixIcon: AppAsset.building3,
                      onPressed: () {
                        baseDialog(
                          context: context,
                          content: ActionCompleted(
                            asset: AppAsset.warning,
                            title: 'Add Bank Account Details ?',
                            assetSize: 80,
                            subtitle:
                            'Are you sure you want to add this bank account as a withdrawal option?',
                            buttonText: 'Yes, Add Bank Account',
                            onPressed: () {
                              popNavigation(context: context);
                            },
                          ),
                        );
                      }
                  ),
                  SizedBox(height: 12.h,),
                  Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        'You can only add a maximum of two (2) Bank Accounts.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
