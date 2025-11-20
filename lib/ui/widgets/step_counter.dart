import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';

import '../../core/constants/color_path.dart';

class StepCounter extends StatelessWidget {
  final int value;
  const StepCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:EdgeInsets.symmetric(
          vertical: 4.h,
          horizontal: 8.w
      ),
      decoration: BoxDecoration(
          color: ColorPath.hummingBirdBlue,
          border: Border.all(color: ColorPath.easternBlue.withCustomOpacity(0.16), width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(8.r))
      ),
      child: Text(
        'Step $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorPath.charcoalBlack
        ),
      ),
    );
  }
}
