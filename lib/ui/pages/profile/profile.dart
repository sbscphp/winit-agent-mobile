import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile/profile_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: true,
        leadingIcon: ProfileImage(),
        title: 'My Profile',
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
            profileOption(
                AppAsset.avatar3,
                'Personal Information',
                'Setup and Update your personal details',
                (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.bankDetails,
                'Bank Account Details',
                'Manage Account number for withdrawal',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.pin,
                'Transaction Pin',
                'Setup transaction PIN for your Account',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.faq,
                'FAQ',
                'FAQs on winIt Agent App',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.support,
                'Support',
                'Contact support to help solve issue with system use.',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.support,
                'Referral Management',
                'Refer other agent and Earn with ease today. ',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.legal,
                'Legal',
                'Privacy Policy, Terms of Use, Cookies etc. ',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.logout,
                'Logout',
                'Log out of your winIt Agent account',
                    (){}
            ),
            SizedBox(height: 24.h,),
            profileOption(
                AppAsset.logout,
                'Account Closure',
                'Initiate the process to close your account',
                    (){}
            ),

          ],
        ),
      ),
    );
  }

  profileOption(String asset, String label, String subtitle, VoidCallback onPressed){
    return Clickable(
      onPressed: onPressed,
      child: WinitContainer(
          padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                          color: ColorPath.chalkBlue,
                          borderRadius: BorderRadius.all(Radius.circular(6.r))
                      ),
                      child: Center(
                        child: CustomAssetViewer(asset: asset, height: 14.h, width: 14.w,),
                      ),
                    ),
                    SizedBox(width: 12.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           label,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.textPrimary
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Text(
                            subtitle,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textTertiary
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10.w,),
              Icon(Icons.arrow_forward_ios_rounded, size: 14.w, color: ColorPath.blueBlue,)
            ],
          )
      ),
    );
  }
}
