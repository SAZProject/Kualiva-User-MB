import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_it/router.dart';
import 'package:like_it/splash_onboarding/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('id'), Locale('en')],
      path: 'assets/languages',
      startLocale: const Locale("id"),
      fallbackLocale: const Locale("id"),
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
        brightness: Brightness.light,
        colorSchemeSeed: const Color.fromRGBO(255, 174, 0, 0),
        textTheme: GoogleFonts.k2dTextTheme(),
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color.fromRGBO(255, 174, 0, 0),
        textTheme: GoogleFonts.k2dTextTheme(),
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
        home: const SplashScreen(),
        onGenerateRoute: (settings) => generateRoute(settings),
      ),
    );
  }
}
