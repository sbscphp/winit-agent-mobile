import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/enum/otp_type.dart';
import 'package:winit_agent/core/data/view_models/authentication/password_vm.dart';
import 'package:winit_agent/core/data/view_models/onboarding/registration_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/authentication/otp.dart';
import 'package:winit_agent/ui/widgets/authentication/password_requirement.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import 'package:winit_agent/ui/widgets/text_fields/onboarding_text_field.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../../../core/utilities/validator.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/screen_title.dart';


class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {

  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _confirmEmail = TextEditingController();
  final _ref = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hidePwd = true;
  bool _hideConfirmPwd = true;

  @override
  Widget build(BuildContext context) {
    final pwdVm = ref.watch(passwordViewModel);
    final vm = ref.watch(registrationViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Create a WinIt Agent Account',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenTitle(title: 'Let’s Get you started 🔐 🚀 ',
                      subtitle: 'Enter basic details to setup your WinIt Agent Account.'
                  ),
                  SizedBox(height: 24.h,),
                  OnboardingTextField(
                    label: 'Your Phone Number',
                    hintText: 'Enter Phone Number',
                    controller: _phone,
                    validator: FieldValidator.validate,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                      NigerianPhoneNumberFormatter()
                    ],
                    bottomHintText: 'Make sure you can access this phone number. It will serve as your temporary Agent ID and login credential until you complete self-onboarding and receive your permanent Agent ID.',
                  ),
                  SizedBox(height: 24.h,),
                  OnboardingTextField(
                    label: 'Email address',
                    hintText: 'Enter email address',
                    controller: _email,
                    validator: EmailValidator.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24.h,),
                  OnboardingTextField(
                    label: 'Confirm Email address',
                    hintText: 'Confirm email address',
                    controller: _confirmEmail,
                    validator: (value) => FieldValidator.compareAndConfirm(value, source: _email.text, errorMessage: 'Your emails don’t match.'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24.h,),
                  OnboardingTextField(
                    label: 'Referral code (if any)',
                    hintText: 'Enter Referral code',
                    controller: _ref,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 24.h,),
                  OnboardingTextField(
                    label: 'Password',
                    hintText: 'Enter Password',
                    obscure: _hidePwd,
                    controller: _pwd,
                    validator: FieldValidator.validate,
                    keyboardType: TextInputType.text,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w),
                      child: Clickable(
                        onPressed: (){
                          setState(() {
                            _hidePwd = !_hidePwd;
                          });
                        },
                        child: CustomAssetViewer(
                            asset:_hidePwd ? AppAsset.pwdHidden : AppAsset.pwdVisible,
                          colorFilter: ColorFilter.mode(ColorPath.gullGrey, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    onChanged: (value) => pwdVm.checkPassWordRequirement(password: _pwd.text),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: PasswordRequirement(),
                  ),
                  SizedBox(height: 24.h,),
                  OnboardingTextField(
                    label: 'Confirm Password',
                    hintText: 'Confirm Password',
                    obscure: _hideConfirmPwd,
                    controller: _confirmPwd,
                    validator: (value) => FieldValidator.compareAndConfirm(value, source: _pwd.text, errorMessage: "Your Passwords don't match"),
                    keyboardType: TextInputType.text,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w),
                      child: Clickable(
                        onPressed: (){
                          setState(() {
                            _hideConfirmPwd = !_hideConfirmPwd;
                          });
                        },
                        child: CustomAssetViewer(
                          asset:_hideConfirmPwd ? AppAsset.pwdHidden : AppAsset.pwdVisible,
                          colorFilter: ColorFilter.mode(ColorPath.gullGrey, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 42.h,),
                  CustomButton(
                      buttonText: 'Create an Account',
                      onPressed: () async{
                        final _validate = _formKey.currentState!.validate();
                        if(_validate){
                          await vm.register(
                              phone: _phone.text,
                              email: _email.text,
                              refCode: _ref.text,
                              pwd: _pwd.text,
                              confirmPwd: _confirmPwd.text
                          );

                          if(vm.state == ViewState.retrieved){
                            //ref.read(onboardingViewModel).updateOnboardingStep(val: vm.loginData?.user?.registrationStep);
                            replaceNavigation(context: context, widget: Otp(otpType: OtpType.createAccount, identifier: Utilities.cleanPhoneNumber(phoneNumber: _phone.text)), routeName: NamedRoutes.otp);
                          }else{
                            showFlushBar(
                                context: context,
                                message: vm.message,
                              success: false
                            );
                          }
                        }
                      }
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
