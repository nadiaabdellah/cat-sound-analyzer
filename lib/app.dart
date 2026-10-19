import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cat_sound_analyzer/core/settings.dart';
import 'package:cat_sound_analyzer/screens/home_screen.dart';

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: darkModeNotifier,
      builder: (_, isDark, __) {
        return ValueListenableBuilder<Locale>(
          valueListenable: languageNotifier,
          builder: (_, locale, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Cat Sound',
              locale: locale,
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.teal,
                brightness: Brightness.dark,
              ),
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: CatSound(),
            );
          },
        );
      },
    );
  }
}