import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/authentication/forgot_password/forgot_password.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/profile/profile_option.dart';

class ChooseOption extends StatelessWidget {
  const ChooseOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Forgot Password',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            top: 32.h,
            bottom: 50.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send my Verification Code to',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textSecondary
              ),
            ),
            SizedBox(height: 16.h,),
            ProfileOption(
                asset:AppAsset.email2,
                label:'Send Via Email',
                subtitle: '',
                onPressed: (){
                  pushNavigation(context: context, widget: const ForgotPassword(), routeName: NamedRoutes.forgotPassword);
                }
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.phone,
                label:'Send to Mobile Number',
                subtitle: '',
                onPressed: (){
                  pushNavigation(context: context, widget: const ForgotPassword(isEmail: false,), routeName: NamedRoutes.forgotPassword);
                }
            ),
          ],
        ),
      ),
    );
  }
}
