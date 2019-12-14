import 'package:danef_dictionary/screens/search_field_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Danef Dictionary',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Danef Dictionary'),
        ),
        body: SearchFieldPage(),
      ),
    );
  }
}