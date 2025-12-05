import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/authentication/password_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/authentication/login.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/text_fields/custom_text_field.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../core/utilities/validator.dart';
import '../../../widgets/authentication/password_requirement.dart';
import '../../../widgets/clickable.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/screen_title.dart';
import '../../../widgets/show_flush_bar.dart';
import '../../../widgets/text_fields/onboarding_text_field.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {

  final _formKey = GlobalKey<FormState>();
  final _pwd = TextEditingController();
  final _newPwd = TextEditingController();
  final _confirmPwd = TextEditingController();

  bool _hidePwd = true;
  bool _hideNewPwd = true;
  bool _hideConfirmPwd = true;

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(passwordViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Change Password',
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenTitle(title: 'Change Password',
                              subtitle: 'Enter your old password to continue'
                          ),
                          SizedBox(height: 24.h,),
                          CustomTextField(
                            label: 'Current Password',
                            hintText: 'Enter Current Password',
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
                          ),
                          SizedBox(height: 24.h,),
                          CustomTextField(
                            label: 'New Password',
                            hintText: 'Enter New Password',
                            obscure: _hideNewPwd,
                            controller: _newPwd,
                            validator: FieldValidator.validate,
                            keyboardType: TextInputType.text,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16.w, left: 16.w),
                              child: Clickable(
                                onPressed: (){
                                  setState(() {
                                    _hideNewPwd = !_hideNewPwd;
                                  });
                                },
                                child: CustomAssetViewer(
                                  asset:_hideNewPwd ? AppAsset.pwdHidden : AppAsset.pwdVisible,
                                  colorFilter: ColorFilter.mode(ColorPath.gullGrey, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            onChanged: (value) => vm.checkPassWordRequirement(password: _newPwd.text),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: PasswordRequirement(),
                          ),
                          SizedBox(height: 24.h,),
                          CustomTextField(
                            label: 'Confirm New Password',
                            hintText: 'Confirm New Password',
                            obscure: _hideConfirmPwd,
                            controller: _confirmPwd,
                            validator: (value) => FieldValidator.compareAndConfirm(value, source: _newPwd.text, errorMessage: "Your Passwords don't match"),
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


                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomButton(
                    buttonText: 'Update Password',
                    onPressed: () async{

                      final validate = _formKey.currentState!.validate();
                      if(validate){

                        if(!vm.isPwdValid()){
                          showFlushBar(
                              context: context,
                              message: "Your Password does not meet the requirement",
                              success: false
                          );
                          return;
                        }

                        Utilities.hideKeyboard(context);

                        await vm.updatePassword(
                            pwd: _pwd.text,
                            newPwd: _newPwd.text,
                            confirmPwd: _confirmPwd.text
                        );

                        if(vm.secondState == ViewState.retrieved){
                          pushAndClearNavigation(context: context, widget: const Login(), routeName: NamedRoutes.login, clearRoute: NamedRoutes.landing);
                        }

                        showFlushBar(
                            context: context,
                            message: vm.message,
                          success: vm.secondState == ViewState.retrieved
                        );



                      }

                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
