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
          gradient: greenGradient
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'ADDER',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'OpenSans',
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Text(
                  'Danef Dictionary',
                  style: TextStyle(
                    fontSize: 36,
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
                child: Center(
                  child: Text(
                    'Sponsored by\nMehdi Çetinbaş',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'OpenSans',
                      color: Colors.white
                    ),
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