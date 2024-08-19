import 'package:flutter/material.dart';

String _appTheme = "lightCode";

class ThemeHelper {
  final Map<String, LightCodeColors> _supportedCustomColor = {
    "lightCode": LightCodeColors()
  };

  final Map<String, ColorScheme> _supportedColorScheme = {
    "lightCode": ColorSchemes.lightModeScheme
  };
}

class ColorSchemes {
  static const lightModeScheme = ColorScheme.light(
    primary: Color(0XFFFFAE00),
    primaryContainer: Color(0XFFFD0002),
    secondaryContainer: Color(0XFFBFBABA),
    errorContainer: Color(0XFFED4C5C),
    onError: Color(0XFF5BC0F8),
    onErrorContainer: Color(0XFF000D3C),
    onPrimary: Color(0XFF000FFF),
    onPrimaryContainer: Color(0X19FFFFFF),
    onSecondaryContainer: Color(0XFF222222),
  );

  static const darkModeScheme = ColorScheme.dark(
    primary: Color(0XFFFFAE00),
    primaryContainer: Color(0XFFFD0002),
    secondaryContainer: Color(0XFFBFBABA),
    errorContainer: Color(0XFFED4C5C),
    onError: Color(0XFF5BC0F8),
    onErrorContainer: Color(0XFF000D3C),
    onPrimary: Color(0XFF000FFF),
    onPrimaryContainer: Color(0X19FFFFFF),
    onSecondaryContainer: Color(0XFF222222),
  );
}

class LightCodeColors {
  //Amber
  Color get amber100 => const Color(0XFFFFEBBF);
  Color get amber300 => const Color(0XFFFFC957);
  Color get amber700 => const Color(0XFFE1A383);
  Color get amberA200 => const Color(0XFFFFC93C);
  //Black
  Color get black999 => const Color(0XFF880088);
  //Blue
  Color get blue500 => const Color(0XFF2A94F4);
  //Bluegray
  Color get blueGray180 => const Color(0XFFCCCCCC);
  //Cyan
  Color get cyan900 => const Color(0XFF084878);
  Color get cyanA200 => const Color(0XFF8BFFFF);
  Color get cyanA400 => const Color(0XFF84CCFF);
  //deepOrange
  Color get deep0rangeA100 => const Color(0XFFDBA17B);
  //Gray
  Color get gray200 => const Color(0XFFEEEEEE);
  Color get gray300 => const Color(0XFFE6E6E6);
  Color get gray600 => const Color(0XFF686868);
  Color get gray60001 => const Color(0XFF8A8282);
  Color get gray800 => const Color(0XFF444444);
  Color get gray88081 => const Color(0XFF4A1E59);
  //Green
  Color get greenA788 => const Color(0XFF83CE80);
  //Indigo
  Color get indigo408 => const Color(0XFF4289C1);
  //LightBlue
  Color get lightBlue700 => const Color(0XFF8881C9);
  Color get lightBlue900 => const Color(0XFF8E538C);
  Color get lightBlueA108 => const Color(0XFF86E5FF);
  //LightGreen
  Color get lightGreenA400 => const Color(0XFF73FF2D);
  Color get lightGreenA40001 => const Color(0XFF54FF08);
  //Orange
  Color get orange300 => const Color(0XFFFFBE55);
  Color get orangeA180 => const Color(0XFFFFD781);
  //Pink
  Color get pink900 => const Color(0XFF772730);
  //Purple
  Color get purpleA700 => const Color(0XFF8800FF);
  // Red
  Color get red300 => const Color(0XFFCC9271);
  Color get redA700 => const Color(0XFF880000);
  Color get redA70001 => const Color(0XFFFF0000);
  //yellow
  Color get yellow900 => const Color(0XFFF07B0F);
  Color get yellowA700 => const Color(0XFFFFDD00);
}
