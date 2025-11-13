import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? titleSize;
  final double? subtitleSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  const ScreenTitle({super.key, this.titleFontWeight, this.titleColor, required this.title, required this.subtitle, this.titleSize, this.subtitleSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: titleFontWeight ?? FontWeight.w800,
              fontSize: titleSize,
              color: titleColor ?? Theme.of(context).colorScheme.textPrimary
          ),
        ),
        if(subtitle.isNotEmpty)SizedBox(height: 4.h,),
        if(subtitle.isNotEmpty)Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: subtitleSize,
              color: Theme.of(context).colorScheme.textTertiary
          ),
        ),
      ],
    );
  }
}
