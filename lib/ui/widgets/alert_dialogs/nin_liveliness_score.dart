import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/onboarding/identity_verification_vm.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/utilities/navigator.dart';
import '../../pages/onboarding/identity_verification/bvn/bvn_requirement.dart';
import '../custom_button.dart';
import '../custom_painter/dotted_border.dart';
import '../custom_svg.dart';

class NinLivelinessScore extends ConsumerWidget {
  const NinLivelinessScore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(identificationViewModel);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetViewer(asset: AppAsset.success, height: 120.h, width:120.w,),
          SizedBox(height: 32.h,),
          CustomPaint(
            painter: DottedBorder(
                color: ColorPath.fogPurple,
                borderRadius: BorderRadius.all(Radius.circular(16.r))
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              decoration: BoxDecoration(
                  color: ColorPath.chalkBlue,
                  borderRadius: BorderRadius.all(Radius.circular(16.r))
              ),
              child: Column(
                children: [
                  Text(
                    'Liveliness Check Score',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textSecondary
                    ),
                  ),
                  SizedBox(height: 6.h,),
                  Text(
                    '${vm.matchPercentage}%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: ColorPath.blueBlue
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h,),
          Text(
            'Congratulations! Your NIN Liveliness Validation Check is Completed ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h,),
          CustomButton(
              buttonText:'Continue Onboarding',
              onPressed: () {
                pushAndClearNavigation(context: context, widget: const BvnRequirement(), routeName: NamedRoutes.bvnRequirement, clearRoute: NamedRoutes.login,);

              }
          )



        ],
      ),
    );
  }
}
