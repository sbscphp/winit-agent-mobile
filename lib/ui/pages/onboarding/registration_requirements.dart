

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/screen_title.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import 'create_account.dart';

class RegistrationRequirements extends StatefulWidget {
  const RegistrationRequirements({super.key});

  @override
  State<RegistrationRequirements> createState() => _RegistrationRequirementsState();
}

class _RegistrationRequirementsState extends State<RegistrationRequirements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'WinIt Agent Account Setup',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: 22.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(title: 'What You’ll Need to Get Started 🚀',
                titleSize: 16.sp,
                subtitle: 'Here’s a quick checklist of the tools and documents you’ll need before starting your onboarding process.'
            ),
            SizedBox(height: 30.h,),
            requirement(title: 'Device & Internet Readiness',
                subtitle: 'Have a smartphone or laptop with a stable internet connection to operate effectively on the WinIT platform.',
                asset: AppAsset.internet,
              assetHeight: 84.h,
              assetWidth: 85.55.w
            ),
            SizedBox(height: 16.h,),
            requirement(title: 'National Identification Number',
                titleColor: ColorPath.blueBlue,
                bgColor: ColorPath.chalkBlue,
                subtitle: 'Keep your NIN handy for quick identity verification during onboarding.',
                swapPositions: true,
                asset: AppAsset.avatar,
                assetHeight: 84.h,
                assetWidth: 79.46.w
            ),
            SizedBox(height: 16.h,),
            requirement(title: 'Bank Verification Number',
                titleColor: ColorPath.piperBrown,
                bgColor: ColorPath.linenBrown,
                subtitle: 'Your BVN is needed for Agent wallet setup and commission payments.',
                asset: AppAsset.building2,
                assetHeight: 84.h,
                assetWidth: 93.41.w
            ),
            SizedBox(height: 22.h,),
            CustomButton(
                buttonText: 'Start Now',
                suffixIcon: AppAsset.chevronTopRight,
                onPressed: () async{
                  pushNavigation(context: context, widget: const CreateAccount(), routeName: NamedRoutes.createAccount);
                }
            ),
            SizedBox(height: 16.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCheckBox(
                    height: 24,
                    width: 24,
                    onchanged: (value){

                    }
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Text(
                    'I consent to the processing of my personal data for background checks and KYC verification (directly by Hope Gain Limited or her authorised third party) as required by law   I understand that the above is required to confirm the accuracy of the information I provided during signup',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary
                    ),
                  ),
                ),
              ],
            )



          ],
        ),
      ),
    );
  }

  requirement({
    required String title,
    required String subtitle,
    required String asset,
    double? assetHeight,
    double? assetWidth,
    Color? bgColor,
    Color? titleColor,
    bool swapPositions = false
}){
    return Container(
      height: 116.h,
      padding: EdgeInsets.symmetric(
          vertical: 22.h,
          horizontal: 16.w
      ),
      decoration: BoxDecoration(
          color: bgColor ?? ColorPath.pigPink,
          borderRadius: BorderRadius.all(Radius.circular(12.r))
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(swapPositions)CustomAssetViewer(asset: asset, height: assetHeight ?? 85.h, width: assetWidth ?? 85.w,) else Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: titleColor ?? ColorPath.ribbonRed
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w,),
            if(swapPositions)Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: titleColor ?? ColorPath.ribbonRed
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                ],
              ),
            )else CustomAssetViewer(asset: asset, height: assetHeight ?? 85.h, width: assetWidth ?? 85.w,)
          ],
        ),
      ),
    );
  }
}
