import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';

import '../../core/constants/app_dimension.dart';
import '../../core/constants/color_path.dart';

class BottomDock extends StatelessWidget {
  final Widget child;
  const BottomDock({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          top: 16.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 24.h
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.whiteText,
        boxShadow: [
          BoxShadow(
            color: ColorPath.margueritePurple.withCustomOpacity(0.32),
            spreadRadius: 0,
            blurRadius: 32,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child:SafeArea(
        child: child,
      ),
    );
  }
}
