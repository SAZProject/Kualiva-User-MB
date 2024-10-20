import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:like_it/main_provider.dart';
import 'common/app_export.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
    await Future.delayed(const Duration(seconds: 1));
    SystemChrome.restoreSystemUIOverlays();
  });

  await EasyLocalization.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  if (kReleaseMode) {
    await dotenv.load(fileName: '.env');
  } else if (kProfileMode) {
    await dotenv.load(fileName: '.env.profile');
  } else {
    await dotenv.load(fileName: '.env.dev');
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("id"), Locale('en')],
      path: 'assets/translation',
      startLocale: const Locale("en"),
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
    return MainProvider(
      mainChild: Sizer(
        builder: (context, orientation, deviceType) {
          return AdaptiveTheme(
            light: ThemeHelper().themeData(ColorSchemes.lightModeScheme),
            dark: ThemeHelper().themeData(ColorSchemes.darkModeScheme),
            initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
            debugShowFloatingThemeButton: true,
            builder: (light, dark) => MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'LIKE IT',
              theme: light,
              darkTheme: dark,
              initialRoute: AppRoutes.splashScreen,
              onGenerateRoute: (settings) => generateRoute(settings),
            ),
          );
        },
      ),
    );
  }
}
