import 'package:danef_dictionary/screens/archive.dart';
import 'package:danef_dictionary/screens/favorite_words.dart';
import 'package:danef_dictionary/screens/search_field_page.dart';
import 'package:danef_dictionary/screens/settings.dart';
import 'package:easy_localization/public.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  List<Widget> tabs = [
    Archive(),
    SearchFieldPage(),
    FavoriteWords()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenSizes.height = MediaQuery.of(context).size.height;
    ScreenSizes.padding = MediaQuery.of(context).padding;
    ScreenSizes.devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr("title")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen())
              );
            }
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: FancyBottomNavigation(
        barHeight: 70,
        arcHeight: 65,
        circleHeight: 50,
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.list, title: tr('bottom_nav_bar.word_list')),
          TabData(iconData: Icons.search, title: tr('bottom_nav_bar.search')),
          TabData(iconData: Icons.favorite, title: tr('bottom_nav_bar.favourites')),
        ],
        onTabChangedListener: (position) {
          setState(() {
            _currentIndex = position;
          });
        },
      ),
    );
  }
}

class ScreenSizes {
  static double height;
  static var padding;
  static double devicePixelRatio;
}
