import 'package:danef_dictionary/config/themes.dart';
import 'package:danef_dictionary/screens/home_page.dart';
import 'package:danef_dictionary/widgets/theme_inherited_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherWidget(
      initialDarkModeOn: false,
      child: DanefDictionary(),
    );
  }
}

class DanefDictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeSwitcher.of(context)
          .isDarkModeOn ? darkTheme(context) : lightTheme(context),
      home: HomePage(),
    );
  }
}
