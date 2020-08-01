import 'package:danef_dictionary/screens/home_page.dart';
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
