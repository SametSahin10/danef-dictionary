import 'package:danef_dictionary/config/themes.dart';
import 'package:danef_dictionary/screens/home_page.dart';
import 'package:danef_dictionary/screens/splash_screen.dart';
import 'package:danef_dictionary/widgets/theme_inherited_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(EasyLocalization(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _determineAppTheme(),
      builder: (_, themeSnapshot) {
        if (themeSnapshot.hasData) {
          var isDarkModeOn = themeSnapshot.data;
          return ThemeSwitcherWidget(
            initialDarkModeOn: isDarkModeOn,
            child: DanefDictionary(HomePage()),
          );
        } else {
          final data = EasyLocalizationProvider.of(context).data;
          return EasyLocalizationProvider(
            data: data,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                EasyLocalizationDelegate(
                    locale: data.locale,
                    path: "resources/langs"
                )
              ],
              supportedLocales: [Locale('tr', 'TR')],
              locale: data.locale,
              theme: lightTheme(context),
              home: SplashScreen(),
            ),
          );
        }
      },
    );
  }
}

class DanefDictionary extends StatelessWidget {
  Widget _home;

  DanefDictionary(this._home);

  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalizationDelegate(
            locale: data.locale,
            path: "resources/langs"
          )
        ],
        supportedLocales: [Locale('tr', 'TR')],
        locale: data.locale,
        theme: ThemeSwitcher.of(context)
            .isDarkModeOn ? darkTheme(context) : lightTheme(context),
        home: _home,
      ),
    );
  }
}

Future<bool> _determineAppTheme() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isDarkModeOn = (preferences.getBool('isDarkModeOn') ?? false);
  await Future.delayed(Duration(seconds: 2));
  return isDarkModeOn;
}