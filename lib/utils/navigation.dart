import 'package:danef_dictionary/screens/attributions.dart';
import 'package:danef_dictionary/screens/home_screen.dart';
import 'package:danef_dictionary/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void pushHomeScreen(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    PageTransition(
      child: HomeScreen(),
      type: PageTransitionType.rightToLeftWithFade,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    ),
    (route) => false,
  );
}

void pushSettingsScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => SettingsScreen()),
  );
}

void pushAttributionsScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => AttributionsScreen()),
  );
}