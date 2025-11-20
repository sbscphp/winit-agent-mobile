import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';


class CountdownCircle extends StatelessWidget {
  final String label;
  final String value;
  final Color textColor;
  const CountdownCircle({super.key, required this.textColor, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 46.08.h,
      width: 54.91.w,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.textPrimary,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
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
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color:textColor
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
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

  }
}
