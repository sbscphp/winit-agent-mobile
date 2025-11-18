import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/color_path.dart';
import '../clickable.dart';
import '../custom_svg.dart';
import '../winit_container.dart';

class ProfileOption extends StatelessWidget {
  final String asset;
  final String label;
  final String subtitle;
  final VoidCallback onPressed;
  const ProfileOption({super.key, required this.asset, required this.label, required this.subtitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
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
