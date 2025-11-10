import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';

import '../custom_svg.dart';

class SettingsAction extends StatelessWidget {
  final String label;
  final String asset;
  final VoidCallback onPressed;
  const SettingsAction({super.key, required this.label, required this.asset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: ColorPath.athensGrey,
            borderRadius: BorderRadius.all(Radius.circular(4.r))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child:Row(
                children: [
                  CustomSvg(asset: asset),
                  SizedBox(width: 10.w,),
                  Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.textSecondary),
                  ),

                ],
              ),
            ),
            SizedBox(width: 20.w,),
            Icon(Icons.arrow_forward_ios, size: 16.w, color: Theme.of(context).colorScheme.textTertiary,)
          ],
        ),
      ),
    );
  }
}
