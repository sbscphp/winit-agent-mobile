import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/color_path.dart';

class LgbtqContainer extends StatelessWidget {
  final bool showPadding;
  final Widget child;
  final double? borderRadius;
  final List<Color>? gradientColors;
  final bool isCircle;
  const LgbtqContainer({super.key, this.isCircle = false, this.gradientColors, required this.child, this.showPadding = true, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      isCircle ? EdgeInsets.all(3):EdgeInsets.symmetric(vertical: showPadding ? 2.h:0, horizontal: showPadding ? 2.w:0),
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle: BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.all(Radius.circular(borderRadius?.r ?? 8.r)),
        gradient: LinearGradient(
          colors: gradientColors ?? [
            ColorPath.lasGreen,
            ColorPath.ribbonRed,
            ColorPath.blueBlue,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius?.r ?? 8.r)),
          child: child),
    );
  }
}
