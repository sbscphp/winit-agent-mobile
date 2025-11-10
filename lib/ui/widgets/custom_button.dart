import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../core/constants/app_asset.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double? buttonWidth;
  final double? buttonHeight;
  final double buttonTextSize;
  final VoidCallback? onPressed;
  final double buttonHorizontalPadding;
  final Color? bgColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final FontWeight buttonTextFontWeight;
  final Color? disableBgColor;
  final bool showLoader;
  final Widget? childWidget;
  final Color? loaderColor;
  final bool useBorderColor;
  final String? suffixIcon;
  final bool useSuffixIcon;


  const CustomButton({
    super.key,
    this.buttonWidth = double.infinity,
    this.buttonTextFontWeight = FontWeight.w800,
    this.buttonTextSize = 14,
    this.borderColor,
    this.bgColor,
    this.buttonTextColor,
    required this.onPressed,
    this.buttonText = 'Continue',
    this.buttonHeight,
    this.disableBgColor,
    this.showLoader = false,
    this.loaderColor,
    this.childWidget,
    this.useBorderColor = false,
    this.buttonHorizontalPadding = 24,
    this.suffixIcon,
    this.useSuffixIcon = true
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final height = buttonHeight?.h ?? 48.h;

    final buttonChild = showLoader
        ? Container(
      padding: EdgeInsets.all(6.w),
      height: 30.h,
      width: 30.h,
      child: CircularProgressIndicator(
        color: loaderColor ?? Colors.white,
        strokeWidth: 2,
      ),
    )
        : childWidget ??
        FittedBox(
          child: Row(
            children: [
              Text(
                buttonText,
                style: textTheme.bodyLarge?.copyWith(
                  color: buttonTextColor ??
                      (useBorderColor
                          ? borderColor ?? Colors.grey
                          : colorScheme.whiteText),
                  fontWeight: buttonTextFontWeight,
                  fontSize: buttonTextSize.sp,
                ),
              ),
              if(useSuffixIcon)SizedBox(width: 8.w,),
              if(useSuffixIcon)CustomAssetViewer(asset: suffixIcon ?? AppAsset.defaultButtonIcon),
            ],
          ),
        );

    return SizedBox(
      height: height,
      width: buttonWidth,
      child: useBorderColor
          ? TextButton(
        onPressed: showLoader ? null : onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10000.r),
            side: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
          ),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent, // removes splash
          overlayColor: Colors.transparent,
        ),
        child: buttonChild,
      )
          : ElevatedButton(
        onPressed: showLoader ? null : onPressed,
        style: ElevatedButton.styleFrom(
          side: null,
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding.w),
          elevation: 0,
          backgroundColor: bgColor ?? colorScheme.brandColor,
          disabledBackgroundColor:
          disableBgColor ?? colorScheme.brandColor.withCustomOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10000.r),
          ),
        ),
        child: buttonChild,
      ),
    );
  }
}
