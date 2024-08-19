import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_it/common/style/theme_helper.dart';
import 'package:like_it/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
    await Future.delayed(const Duration(seconds: 1));
    SystemChrome.restoreSystemUIOverlays();
  });

  await EasyLocalization.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translation',
      startLocale: const Locale("en"),
      fallbackLocale: const Locale("en"),
      useFallbackTranslations: true,
      useOnlyLangCode: true,
      child: MyApp(savedThemeMode: savedThemeMode),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.standard,
        colorScheme: ColorSchemes.lightModeScheme,
        brightness: Brightness.light,
        textTheme: GoogleFonts.k2dTextTheme(),
      ),
      dark: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.standard,
        colorScheme: ColorSchemes.darkModeScheme,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.k2dTextTheme(ThemeData.dark().textTheme),
      ),
      initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
      debugShowFloatingThemeButton: true,
      builder: (light, dark) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'LPK GO',
        theme: light,
        darkTheme: dark,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: (settings) => generateRoute(settings),
      ),
    );
  }
}
