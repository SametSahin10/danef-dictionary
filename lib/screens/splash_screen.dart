import 'package:danef_dictionary/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _isSponsorTextVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showSponsorText());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: GREEN_GRADIENT
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Text(
                'ADDER',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'OpenSans',
                  color: Colors.white
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Text(
                  'Danef Dictionary',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: AnimatedOpacity(
                opacity: _isSponsorTextVisible ? 1.0 : 0.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'Sponsored by: Mehdi Çetinbaş',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'OpenSans',
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showSponsorText() {
    setState(() {
      _isSponsorTextVisible = true;
    });
  }
}