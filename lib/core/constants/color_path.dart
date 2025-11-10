
import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPath {

  //brand colors
  static const stratosBlue = Color(0xff010133);
  static const lasGreen = Color(0xffC7F713);


  //other colors
  static const ghostGrey = Color(0xffCCCCD6);

  static const curiousBlue = Color(0xff23A3D6);
  static const hummingBirdBlue = Color(0xffE9F6FC);
  static const hummingBirdBlue2 = Color(0xffD3EDF8);
  static const silverGrey = Color(0xffCCCCCC);
  static const alizarinRed = Color(0xffD92D20);
  static const easternBlue = Color(0xff1C82AB);
  static const turquoiseGreen = Color(0xff17F7B6);
  static const turquoiseGreen2 = Color(0xff40E2D6);
  static const ribbonRed = Color(0xffF71355);
  static const ribbonRed2 = Color(0xffD90744);
  static const yukonGreen = Color(0xff647C0A);
  static const remyPink = Color(0xffFEE6ED);
  static const glowGreen = Color(0xffF9FEE7);
  static const fetaGreen = Color(0xffF6FEF9);
  static const chillGreen = Color(0xff0E9384);
  static const aeroGreen = Color(0xffCEFDEF);
  static const mintBlue = Color(0xffD4EDF7);
  static const albecentBrown = Color(0xffF7DED4);
  static const birdGreen = Color(0xffD3F8F6);
  static const chalkPurple = Color(0xffEFEBFE);
  static const whisperGrey = Color(0xffEDEDF6);
  static const santasGrey = Color(0xff9899AD);
  static const remyPink2 = Color(0xffFEEBF1);
  static const iceGreen = Color(0xffEDF8FC);
  static const iceBlue = Color(0xffE5F4FB);
  static const hintYellow = Color(0xffFAFEEB);
  static const madrasBlack = Color(0xff333301);
  static const magnoliaPurple = Color(0xffF9F5FF);
  static const waikawaGrey = Color(0xff5D6997);
  static const scandalGreen = Color(0xffD1FADF);
  static const mintGreen = Color(0xffA6F4C5);
  static const meadowGreen = Color(0xff12B76A);
  static const karryBrown = Color(0xffFFE6D5);


  static const grayGrey = Color(0xff8C8C8C);
  static const frenchGrey = Color(0xffB4B3C3);
  static const pigPink = Color(0xffFEE1EA);
  static const charcoalBlack = Color(0xff01011B);
  static const blueBlue = Color(0xff4313F7);
  static const piperBrown = Color(0xffD65623);
  static const linenBrown = Color(0xffFBEBE5);
  static const chalkBlue = Color(0xffE7E1FE);
  static const troutGrey = Color(0xff4C4D61);
  static const manateeGrey = Color(0xff8E8D9D);
  static const oxfordBlue = Color(0xff344054);
  static const mischkaGrey = Color(0xffD0D5DD);
  static const paleGrey = Color(0xff667085);
  static const gullGrey = Color(0xff98A2B3);
  static const hazeGreen = Color(0xff039855);
  static const athensGrey = Color(0xffF3F2F5);
  static const fogPurple = Color(0xffD7CDFE);


















  static Color dynamicColor(String? hexString, Color? fallbackColor) {
    // Return default color if hexString is null or empty
    if (hexString == null || hexString.isEmpty) {
      return fallbackColor ?? stratosBlue;
    }
    try {
      // Remove the '#' character if it exists
      final hexCode = hexString.replaceAll('#', '');

      // Parse the hexadecimal string to an integer
      return Color(int.parse('FF$hexCode', radix: 16));
    } catch (e) {
      debugPrint('Error parsing color: $e');
      return fallbackColor ?? stratosBlue;
    }
  }
  







































}