import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color_path.dart';

class WinitContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final Color? bgColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  const WinitContainer({super.key,this.boxShadow, this.borderRadius, this.border, this.bgColor, this.margin, required this.child, this.padding, this.width,this.gradient});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width ?? double.infinity,
      padding: padding ?? EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 12.w
      ),
      margin: margin,
      decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          border: border ?? Border.all(
              color:ColorPath.athensGrey3,
              width: 1.w
          ),
          gradient: gradient,
          boxShadow: boxShadow,
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(12.r))
      ),
      child: child,
    );
  }
}
