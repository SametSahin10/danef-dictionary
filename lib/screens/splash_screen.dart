import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 5)),
      builder: (context, _) {
         return Scaffold(
           body: Center(
             child: Text(
               'Loading...',
               style: TextStyle(fontSize: 24),
             ),
           ),
         );
      },
    );
  }
}
