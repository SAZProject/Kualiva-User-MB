import 'package:flutter/material.dart';
import 'package:like_it/common/utility/sized_utils.dart';

String _appTheme = "light";
GlobalCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData theme(BuildContext context) {
  var brightness = Theme.of(context).brightness;
  if (brightness == Brightness.dark) {
    return ThemeHelper().themeData(ColorSchemes.darkModeScheme);
  } else {
    return ThemeHelper().themeData(ColorSchemes.lightModeScheme);
  }
}

class ThemeHelper {
  final Map<String, GlobalCodeColors> _supportedCustomColor = {
    "light": GlobalCodeColors(),
    "dark": GlobalCodeColors(),
  };

  GlobalCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? GlobalCodeColors();
  }

  ThemeData _getThemeData(ColorScheme colorScheme) {
    return ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.standard,
        colorScheme: colorScheme,
        brightness: colorScheme.brightness,
        fontFamily: "K2D",
        textTheme: TextThemes.textTheme(colorScheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            elevation: 0,
            visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
            padding: EdgeInsets.zero,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(
              color: appTheme.black900.withOpacity(0.6),
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
            padding: EdgeInsets.zero,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0XFFEEEEEE);
            }
            return Colors.transparent;
          }),
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        ),
        dividerTheme: const DividerThemeData(thickness: 4, space: 4));
  }

  GlobalCodeColors themeColor() => _getThemeColors();

  ThemeData themeData(ColorScheme colorScheme) => _getThemeData(colorScheme);
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) {
    Color color = appTheme.black900;
    if (colorScheme == ColorSchemes.darkModeScheme) {
      color = colorScheme.onPrimaryContainer.withOpacity(1);
    } else {
      color = appTheme.black900;
    }
    return TextTheme(
      bodyLarge: TextStyle(
        color: color,
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: color,
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: color,
        fontSize: 12.fontSize,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        color: color,
        fontSize: 34.fontSize,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: TextStyle(
        color: appTheme.yellowA700,
        fontSize: 32.fontSize,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: appTheme.black900,
        fontSize: 28.fontSize,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color: color,
        fontSize: 24.fontSize,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: TextStyle(
        color: color,
        fontSize: 13.fontSize,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: TextStyle(
        color: color,
        fontSize: 11.fontSize,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        color: color,
        fontSize: 20.fontSize,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: color,
        fontSize: 16.fontSize,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: color,
        fontSize: 14.fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
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
    onPrimaryContainer: Color.fromRGBO(0, 0, 0, 1),
    onSecondaryContainer: Color.fromRGBO(255, 255, 255, 1),
  );

  static const darkModeScheme = ColorScheme.dark(
    primary: Color(0XFFFFAE00),
    primaryContainer: Color(0XFFFD0002),
    secondaryContainer: Color(0XFFBFBABA),
    errorContainer: Color(0XFFED4C5C),
    onError: Color(0XFF5BC0F8),
    onErrorContainer: Color(0XFF000D3C),
    onPrimary: Color(0XFF000FFF),
    onPrimaryContainer: Color.fromRGBO(255, 255, 255, 1),
    onSecondaryContainer: Color.fromRGBO(0, 0, 0, 1),
  );
}

class GlobalCodeColors {
  //white
  Color get white => Colors.white;
  //Amber
  Color get amber100 => const Color(0XFFFFEBBF);
  Color get amber300 => const Color(0XFFFFC957);
  Color get amber700 => const Color(0XFFE1A303);
  Color get amberA200 => const Color(0XFFFFC93C);
  //Black
  Color get black900 => const Color(0XFF000000);
  //Blue
  Color get blue500 => const Color(0XFF2A94F4);
  //Bluegray
  Color get blueGray100 => const Color(0XFFCCCCCC);
  //Cyan
  Color get cyan900 => const Color(0XFF0B4870);
  Color get cyanA200 => const Color(0XFF00FFFF);
  Color get cyanA400 => const Color(0XFF04CCFF);
  //deepOrange
  Color get deep0rangeA100 => const Color(0XFFDBA17B);
  //Gray
  Color get gray200 => const Color(0XFFEEEEEE);
  Color get gray300 => const Color(0XFFE6E6E6);
  Color get gray500 => const Color(0XFF999999);
  Color get gray600 => const Color(0XFF6B6B6B);
  Color get gray60001 => const Color(0XFF8A8282);
  Color get gray800 => const Color(0XFF444444);
  Color get gray80001 => const Color(0XFF4A1E59);
  //Green
  Color get greenA700 => const Color(0XFF03CE00);
  //Indigo
  Color get indigo400 => const Color(0XFF4289C1);
  //LightBlue
  Color get lightBlue700 => const Color(0XFF0081C9);
  Color get lightBlue900 => const Color(0XFF0E538C);
  Color get lightBlueA100 => const Color(0XFF86E5FF);
  //LightGreen
  Color get lightGreenA400 => const Color(0XFF73FF2D);
  Color get lightGreenA40001 => const Color(0XFF54FF00);
  //Orange
  Color get orange300 => const Color(0XFFFFBE55);
  Color get orangeA180 => const Color(0XFFFFD781);
  //Pink
  Color get pink900 => const Color(0XFF772730);
  //Purple
  Color get purpleA700 => const Color(0XFF8800FF);
  // Red
  Color get red300 => const Color(0XFFCC9271);
  Color get redA700 => const Color(0XFFB80000);
  Color get redA70001 => const Color(0XFFFF0000);
  //yellow
  Color get yellow900 => const Color(0XFFF07B0F);
  Color get yellowA700 => const Color(0XFFFFDD00);
}
