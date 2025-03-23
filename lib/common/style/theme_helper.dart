import 'package:flutter/material.dart';
import 'package:kualiva/common/utility/sized_utils.dart';

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

  GlobalCodeColors themeColor() => _getThemeColors();

  ThemeData themeData(ColorScheme colorScheme) => _getThemeData(colorScheme);

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          elevation: 0,
          visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: appTheme.black900.withValues(alpha: 0.6),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
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
      dividerTheme: const DividerThemeData(thickness: 4, space: 4),
    );
  }
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) {
    Color color = appTheme.black900;
    if (colorScheme == ColorSchemes.darkModeScheme) {
      color = colorScheme.onPrimaryContainer.withValues(alpha: 1);
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
    primary: Color(0XFFFF8800),
    primaryContainer: Color(0XFFFD0002),
    onPrimary: Color(0XFF000FFF),
    onPrimaryContainer: Color.fromRGBO(0, 0, 0, 1),
    onSecondaryContainer: Color.fromRGBO(255, 255, 255, 1),
  );

  static const darkModeScheme = ColorScheme.dark(
    primary: Color(0XFFFF8800),
    primaryContainer: Color(0XFFFD0002),
    onPrimary: Color(0XFF000FFF),
    onPrimaryContainer: Color.fromRGBO(255, 255, 255, 1),
    onSecondaryContainer: Color.fromRGBO(0, 0, 0, 1),
  );
}

class GlobalCodeColors {
  //white
  Color get white => Colors.white;
  //Amber
  Color get amber700 => const Color(0XFFFFAE00);
  //Black
  Color get black900 => const Color(0XFF000000);
  //Bluegray
  Color get blueGray100 => const Color(0XFFCCCCCC);
  //Gray
  Color get gray200 => const Color(0XFFEEEEEE);
  Color get gray500 => const Color(0XFF999999);
  Color get gray800 => const Color(0XFF444444);
  //Orange
  Color get orange300 => const Color(0XFFFFBE55);
  // Red
  Color get redA700 => const Color(0XFFB80000);
  Color get redA70001 => const Color(0XFFFF0000);
  //yellow
  Color get yellowA700 => const Color(0XFFFFDD00);
}
