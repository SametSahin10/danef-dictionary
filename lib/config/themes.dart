import 'package:flutter/material.dart';

lightTheme(context) {
  return ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    accentColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    disabledColor: Colors.green,
    indicatorColor: Colors.green,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          borderSide: BorderSide(
              color: Colors.green
          )
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.5
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
            color: Colors.green,
            width: 1.5
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
          color: Colors.green,
          width: 1
        )
      ),
      hintStyle: TextStyle(fontSize: 18),
    ),
    hintColor: Colors.green
  );
}

darkTheme(context) {
  return ThemeData(
    primarySwatch: Colors.green,
    primaryColor: Colors.black,
    accentColor: Colors.green,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        color: Colors.green
    ),
    disabledColor: Colors.green,
    indicatorColor: Colors.green,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
            color: Colors.green
        )
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
            color: Colors.green
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
            color: Colors.green,
            width: 1.5
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(
            color: Colors.green,
            width: 1
        )
      ),
      hintStyle: TextStyle(fontSize: 18),
    ),
    hintColor: Colors.green
  );
}