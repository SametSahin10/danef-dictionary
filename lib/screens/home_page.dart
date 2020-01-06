import 'package:danef_dictionary/screens/Archive.dart';
import 'package:danef_dictionary/screens/favorite_words.dart';
import 'package:danef_dictionary/screens/search_field_page.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Danef Dictionary'),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: FancyBottomNavigation(
        arcHeight: 65,
        circleHeight: 50,
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.list, title: 'Word List'),
          TabData(iconData: Icons.search, title: 'Search'),
          TabData(iconData: Icons.favorite, title: 'Favorites'),
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