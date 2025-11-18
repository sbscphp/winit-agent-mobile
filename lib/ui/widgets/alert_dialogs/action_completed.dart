import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_asset.dart';
import '../custom_button.dart';
import '../custom_svg.dart';

class ActionCompleted extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final double? assetSize;
  const ActionCompleted({super.key, this.assetSize, required this.title, required this.subtitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetViewer(asset: AppAsset.success, height: assetSize?.h ?? 48.h, width: assetSize?.w ?? 48.w,),
          SizedBox(height: 32.h,),
          FittedBox(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h,),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h,),
          CustomButton(
              buttonText: 'Close',
              onPressed: onPressed
          )


        ],
      ),
    );
  }
}
