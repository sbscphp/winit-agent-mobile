import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';

class CountdownCircle extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;
  const CountdownCircle({super.key, required this.textColor, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 42.74.h,
      width: 42.74.w,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.blackText.withAlpha((255 * 0.7).toInt()),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          //border: Border.all(color: ColorPath.ribbonRed2, width: 1.w)
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                      color:textColor
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                      fontWeight: FontWeight.w800,
                      color:textColor
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );



    return Container(
      height: 44.5.h,
      width: 44.5.w,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: ColorPath.ribbonRed2, width: 1.w)
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                      color:
                      ColorPath.ribbonRed),
                ),
                SizedBox(height: 2.h,),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                      fontWeight: FontWeight.w800,
                      color:Theme.of(context).colorScheme.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
