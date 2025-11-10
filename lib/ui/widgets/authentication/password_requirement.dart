import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../../core/data/view_models/authentication/password_vm.dart';

class PasswordRequirement extends ConsumerWidget {
  const PasswordRequirement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(passwordViewModel);
    return ListView.separated(
      itemCount: vm.pwdRequirements.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        final requirement = vm.pwdRequirements[index];
        final isPassed = vm.results[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           CustomAssetViewer(asset: isPassed ? AppAsset.requirementPassed:AppAsset.requirementFailed, height: 14.h, width: 14.w,),
            SizedBox(width: 4.w,),
            Expanded(
              child:  Text(
                requirement,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isPassed ?ColorPath.hazeGreen:Theme.of(context).colorScheme.textSecondary
                ),
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.h,);
      },
    );
  }
}
