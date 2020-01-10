import 'package:flutter/material.dart';

lightTheme(context) {
  return ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    accentColor: Colors.green,
    fontFamily: 'TextMeOne',
    scaffoldBackgroundColor: Colors.white,
    disabledColor: Colors.white,
    indicatorColor: Colors.green,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 24,
          fontFamily: 'TextMeOne'
        ),
      ),
    ),
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: 24
      ),
      body1: TextStyle(
        fontSize: 16
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              color: Colors.green
          )
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.5
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            color: Colors.green,
            width: 1.5
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.green,
          width: 1
        )
      ),
      hintStyle: TextStyle(
        fontSize: 20,
      ),
    ),
    hintColor: Colors.green
  );
}

darkTheme(context) {
  return ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.black,
    accentColor: Colors.green,
    fontFamily: 'TextMeOne',
    scaffoldBackgroundColor: Colors.black,
    disabledColor: Colors.green,
    indicatorColor: Colors.green,
    brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 24,
            fontFamily: 'TextMeOne'
          ),
        ),
      ),
      textTheme: TextTheme(
        title: TextStyle(
            fontSize: 24
        ),
        body1: TextStyle(
            fontSize: 16
        ),
      ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            color: Colors.green
        )
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            color: Colors.green
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            color: Colors.green,
            width: 1.5
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            color: Colors.green,
            width: 1
        )
      ),
      hintStyle: TextStyle(fontSize: 20),
    ),
    hintColor: Colors.green
  );
}