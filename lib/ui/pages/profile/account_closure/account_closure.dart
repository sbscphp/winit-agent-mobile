import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/onboarding/identity_verification_notes.dart';
import '../../../widgets/screen_title.dart';

class AccountClosure extends StatelessWidget {
  const AccountClosure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Account Closure',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            top: 32.h,
            bottom: 50.h
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: BoxDecoration(
                      color: ColorPath.pigPink,
                      borderRadius: BorderRadius.all(Radius.circular(11.5.r)),
                    ),
                    child: Center(
                      child: CustomAssetViewer(asset: AppAsset.warning2, height: 27.6.h, width: 27.6.w,),
                    ),
                  ),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child:ScreenTitle(
                        title: 'Close My WinIt Account',
                        titleSize: 16.sp,
                        subtitle: 'Initiate the process to close your account'
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              Text(
                'Are you sure you want to close your WinIt Agent account? Once your account is suspended, all linked services will be inaccessible. This means you will no longer be able to',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textSecondary
                ),
              ),
              SizedBox(height: 24.h,),
              IdentityVerificationNotes(
                  asset: AppAsset.bulletPoint4,
                  sizeBoxAsSeparator: true,
                  notes: [
                    {
                      'title': 'Access your wallet',
                      'subtitle': 'View balances, deposit, or withdraw funds'
                    },
                    {
                      'title': 'Purchase tickets',
                      'subtitle': 'Buy or reserve any tickets within the system'
                    },
                    {
                      'title': 'Carry out transactions',
                      'subtitle': 'Send, receive, or process payments through your account'
                    }
                  ]
              ),
              SizedBox(height: 96.h,),
              CustomButton(
                  buttonText: 'Initiate Account Closure',
                  suffixIcon: AppAsset.warning3,
                  onPressed: () {
          
                  }
              ),
              SizedBox(height: 16.h,),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: ColorPath.remyPink
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.8.h,
                          horizontal:4.8.w
                      ),
                      decoration: BoxDecoration(
                        color: ColorPath.pigPink2,
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      ),
                      child: Center(
                        child: CustomAssetViewer(asset: AppAsset.alert, height: 14.4.h, width: 14.4.w,),
                      ),
                    ),
                    SizedBox(width: 12.w,),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color:  ColorPath.troutGrey,
                          ),
                          children: [
                            TextSpan(
                              text: 'Before closing your account, please ensure you have withdrawn all funds from your WinIt Agent wallet. For more details see ',
                            ),
                            TextSpan(
                              text: 'Terms of use',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPath.ribbonRed,
                                decorationColor: ColorPath.ribbonRed,
                                decoration: TextDecoration.underline
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // pushNavigation(context: context,
                                  //     widget: const InAppWebView(
                                  //         url: terms,
                                  //         title: 'Privacy Policy'
                                  //     ),
                                  //     routeName: NamedRoutes.inAppWebView
                                  // );
                                },
                            ),
          
                          ],
                        ),
                      ),
                    )
          
                  ],
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
