import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';

import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';

class ListHeader extends StatelessWidget {
  final String label;
  final String subtitle;
  final VoidCallback? onPressed;
  final bool showAllVisible;
  final String? showAllLabel;
  final Widget? titleWidget;
  const ListHeader({super.key, this.titleWidget, this.showAllLabel, required this.label, required this.subtitle, this.showAllVisible = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget ?? Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              SizedBox(height: 2.h,),
              FittedBox(
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textTertiary
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 40.w,),
        if(showAllVisible)Clickable(
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                showAllLabel ?? 'Show All',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorPath.blueBlue
                ),
              ),
              SizedBox(width: 8.w,),
              CustomAssetViewer(asset: AppAsset.coloredTopRightChevron, height: 16.h, width: 16.w,)
            ],
          ),
        )
      ],
    );
  }
}
