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
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SearchFieldWidget(),
    );
  }
}

class SearchFieldWidget extends StatefulWidget {
  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
              borderRadius: new BorderRadius.circular(16.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
              borderRadius: new BorderRadius.circular(16.0)),
          hintText: 'Search a word',
          hintStyle: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
