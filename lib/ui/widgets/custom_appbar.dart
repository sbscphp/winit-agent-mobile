import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/leading_icon.dart';


customAppBar({
  required BuildContext context,
  String? title,
  FontWeight? titleFontWeight,
  double? titleSize,
  List<Widget>? actions,
  bool centerTitle = false,
  VoidCallback? leadingIconOnPressed,
  double? appBarElevation,
  final Color? textColor,
  bool useCustomTitleWidget = false,
  Widget? titleWidget,
  bool showLeadingIcon = true,
  double? leadingWidth,
  Widget? leadingIcon,
  double preferredHeight = 0,
  Color? bottomDividerColor,
  Color? backgroundColor,
  bool hideTooBarHeight = false,
}){
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;
  return AppBar(
    leadingWidth: leadingWidth,
    automaticallyImplyLeading: showLeadingIcon,
    scrolledUnderElevation: 0,
    centerTitle: centerTitle,
    backgroundColor: backgroundColor ?? colorScheme.brandColor,
    title: useCustomTitleWidget ? titleWidget :
    title != null ?  Text(
        title,
      style: textTheme.bodyLarge?.copyWith(
        fontSize: titleSize?.sp,
          fontWeight: titleFontWeight ?? FontWeight.w700,
          color: textColor ?? colorScheme.whiteText
      ),
    ):null,
    leading: showLeadingIcon ? leadingIcon ?? LeadingIcon(
      onPressed: leadingIconOnPressed,
    ):null,
    toolbarHeight: hideTooBarHeight ? 0 : 72.h,
    // bottom: PreferredSize(
    //   preferredSize: Size.fromHeight(preferredHeight.h),
    //   child: Container(
    //     color: bottomDividerColor ?? ColorPath.athensGrey2,
    //     height: 1.h,
    //   ),
    // ),
    actions: actions,
  );
}