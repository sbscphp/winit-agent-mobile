import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_svg.dart';

class ReactivateAccount extends StatelessWidget {
  const ReactivateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Reactivate Account',
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
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 52.h,
                width: 52.w,
                decoration: BoxDecoration(
                  color: ColorPath.pigPink,
                  borderRadius: BorderRadius.all(Radius.circular(13.r)),
                ),
                child: Center(
                  child: CustomAssetViewer(asset: AppAsset.warning2, height: 31.2.h, width: 31.2.w,),
                ),
              ),
            ),
            SizedBox(height: 23.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                'WINT AGENT ACCOUNT DEACTIVATED',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Important Notice on Your Account Closure',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16.h,),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding:EdgeInsets.symmetric(
                  vertical: 6.h,
                  horizontal: 12.w
                ),
                decoration: BoxDecoration(
                  color: ColorPath.chalkBlue,
                  border: Border.all(color: ColorPath.blueBlue.withCustomOpacity(0.32), width: 1.w),
                  borderRadius: BorderRadius.all(Radius.circular(8.r))
                ),
                child: Text(
                  'Date Deactivated: 18 Sept, 2025',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorPath.blueBlue
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(2, (index){
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 8.w
                        ),
                        decoration: BoxDecoration(
                            color: ColorPath.hummingBirdBlue,
                            border: Border.all(color: ColorPath.easternBlue.withCustomOpacity(0.16), width: 1.w),
                            borderRadius: BorderRadius.all(Radius.circular(8.r))
                        ),
                        child: Text(
                          'Step ${index + 1}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: ColorPath.charcoalBlack
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              index == 0 ? 'Submit your Request':'Admin Review',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(height: 4.h,),
                            Text(
                              index == 0 ? 'Send an email to Customer Service requesting account reactivation. Please include the following details in your email\n\n1. Your Agent ID.\n2. Your registered email address\n3. Your registered phone number'
                              :'Our Admin Officer will receive and review your request along with the details you provided.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textTertiary
                              ),
                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 16.h,),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: ColorPath.athensGrey3
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAssetViewer(asset: AppAsset.alert2),
                  SizedBox(width: 12.w,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color:  ColorPath.hazeGreen,
                        ),
                        children: [
                          TextSpan(
                            text: 'Next Step: ',
                          ),
                          TextSpan(
                            text: 'You will receive an email from us with the next steps to complete your account reactivation.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.charcoalBlack
                            ),
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
    );
  }
}
