import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/authentication/password_vm.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/authentication/password_requirement.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/text_fields/custom_text_field.dart';

class PasswordAction extends ConsumerStatefulWidget {
  final bool fromForgotPassword;
  final String? userId;
  const PasswordAction({super.key, this.fromForgotPassword = true, this.userId});

  @override
  ConsumerState<PasswordAction> createState() => _PasswordActionState();
}

class _PasswordActionState extends ConsumerState<PasswordAction> {

  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();
  final _currentPwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _hidePwd = true;
  bool _hideConfirmPwd = true;
  bool _hideCurrentPwd = true;


  @override
  Widget build(BuildContext context) {
    final pwdVm = ref.watch(passwordViewModel);
    return BusyOverlay(
      show: pwdVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: widget.fromForgotPassword ? 'Create Password':'Change Password',
        ),
        body:  Padding(
          padding: EdgeInsets.only(top: 45.h, bottom: AppDimension.paddingBottom, left: AppDimension.paddingLeft, right: AppDimension.paddingRight),
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
                        CustomTextField(
                          label: 'Enter New Password',
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
                              child: CustomSvg(
                                  asset:_hidePwd ? AppAsset.pwdHidden : AppAsset.pwdVisible),
                            ),
                          ),
                          onChanged: (value) => pwdVm.checkPassWordRequirement(password: _pwd.text),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: PasswordRequirement(),
                        ),
                        SizedBox(height: 24.h,),
                        CustomTextField(
                          label: 'Confirm New Password',
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
                              child: CustomSvg(
                                  asset:_hideConfirmPwd ? AppAsset.pwdHidden : AppAsset.pwdVisible),
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
                  buttonText: widget.fromForgotPassword ? 'Create Password':'Update Password',
                  onPressed: () async{
                    final validate = _formKey.currentState!.validate();
                    if(validate){

                      if(!pwdVm.isPwdValid()){
                        showFlushBar(
                            context: context,
                            message: "Your Password does not meet the requirement",
                            success: false
                        );
                        return;
                      }

                      Utilities.hideKeyboard(context);

                      if(widget.fromForgotPassword){

                        await pwdVm.createNewPassword(
                            pwd: _pwd.text,
                            confirmPwd: _confirmPwd.text,
                            userId: widget.userId,
                        );

                        if(pwdVm.state == ViewState.retrieved){
                          popUntilNavigation(context: context, route: NamedRoutes.login);
                        }

                        showFlushBar(
                            context: context,
                            message: pwdVm.message,
                          success: pwdVm.state == ViewState.retrieved
                        );
                      }else{

                        //todo: implement update password flow

                      }
                    }

                  }
              ),



            ],
          ),
        ),
      ),
    );
  }
}
