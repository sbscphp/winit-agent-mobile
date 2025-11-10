import 'package:flutter/material.dart';
import 'package:winit_agent/core/constants/color_path.dart';



extension CustomColorScheme on ColorScheme {
  // Custom text color variants

  //brand
  Color get brandColor => brightness == Brightness.light ? ColorPath.stratosBlue : Colors.white;
  Color get brandColor2 => brightness == Brightness.light ? ColorPath.lasGreen : Colors.white;
  Color get brandColor3 => brightness == Brightness.light ? ColorPath.turquoiseGreen : Colors.white;

  //text
  Color get blackText => brightness == Brightness.light ? Colors.black : Colors.white;
  Color get whiteText => brightness == Brightness.light ? Colors.white : Colors.black;

  Color get textPrimary => brightness == Brightness.light ? ColorPath.charcoalBlack : Colors.white;
  Color get textSecondary => brightness == Brightness.light ? ColorPath.troutGrey : Colors.white;
  Color get textTertiary => brightness == Brightness.light ? ColorPath.manateeGrey : Colors.white;
  Color get text4 => brightness == Brightness.light ? ColorPath.santasGrey : Colors.white;



  //widgets
  //text-field
  Color get textFieldFillColor => brightness == Brightness.light ? ColorPath.athensGrey : Colors.white;
  Color get onboardingTextFieldFillColor => Colors.transparent;
  Color get textFieldLabel => brightness == Brightness.light ? ColorPath.oxfordBlue: Colors.white;
  Color get textFieldBorder => brightness == Brightness.light ? ColorPath.mischkaGrey : Colors.white;
  Color get textFieldFocusedBorder => ColorPath.mischkaGrey;
  Color get textFieldHint => brightness == Brightness.light ? ColorPath.paleGrey : Colors.white;
  Color get textFieldSuffixIcon => textPrimary;

}