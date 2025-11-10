import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_button.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

class ActionSuccessful extends StatelessWidget {
  final String? asset;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback onPressed;
  final VoidCallback? buttonOnPressed;
  const ActionSuccessful({super.key, this.buttonOnPressed, this.buttonText, this.asset, required this.title, required this.subtitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              CustomSvg(asset: asset ?? AppAsset.logo, height: 48, width: 48,),
              Clickable(
                  onPressed: onPressed ,
                  child: const CustomSvg(asset: AppAsset.logo)),
            ],
          ),
          SizedBox(height: 16.h,),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.textPrimary
            ),
          ),
          SizedBox(height: 5.h,),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.textSecondary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h,),
          CustomButton(
              buttonText: buttonText ?? 'Continue',
              onPressed: buttonOnPressed ?? onPressed
          ),

        ],
      ),
    );
  }
}
