import 'package:danef_dictionary/config/themes.dart';
import 'package:danef_dictionary/screens/home_page.dart';
import 'package:danef_dictionary/screens/splash_screen.dart';
import 'package:danef_dictionary/widgets/theme_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(context),
            home: SplashScreen(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeSwitcher.of(context)
          .isDarkModeOn ? darkTheme(context) : lightTheme(context),
      home: _home,
    );
  }
}

Future<bool> _determineAppTheme() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isDarkModeOn = (preferences.getBool('isDarkModeOn') ?? false);
  await Future.delayed(Duration(seconds: 3));
  return isDarkModeOn;
}