import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen_title.dart';
import '../step_counter.dart';

class GamePurchaseHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final int stepValue;
  const GamePurchaseHeader({super.key, required this.title, required this.subtitle, required this.stepValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StepCounter(value: stepValue),
        SizedBox(width: 16.w,),
        Expanded(
          child:ScreenTitle(title: title,
              titleSize: 16.sp,
              subtitle: subtitle
          ),
        )
      ],
    );
  }
}
