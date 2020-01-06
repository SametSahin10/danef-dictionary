import 'package:danef_dictionary/screens/search_field_page.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danef Dictionary'),
      ),
      body: SearchFieldPage(),
      bottomNavigationBar: FancyBottomNavigation(
        arcHeight: 65,
        circleHeight: 50,
        tabs: [
          TabData(iconData: Icons.list, title: 'Word List'),
          TabData(iconData: Icons.search, title: 'Search'),
          TabData(iconData: Icons.favorite, title: 'Favorites'),
        ],
        onTabChangedListener: (position) {
          setState(() {
            print('changing tabs');
          });
        },
      ),
    );
  }
}
