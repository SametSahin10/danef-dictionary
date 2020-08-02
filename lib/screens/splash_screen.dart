import 'package:danef_dictionary/utils/navigation.dart';
import 'package:danef_dictionary/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _isSponsorTextVisible = false;

  @override
  void initState() {
    _showSponsorText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: greenGradient),
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Text(
                  tr("title"),
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontFamily: "DidactGothic",
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: AnimatedOpacity(
                opacity: _isSponsorTextVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1500),
                child: Center(
                  child: Text(
                    tr("splash_screen.sponsored_by_text"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'OpenSans',
                      color: Colors.white,
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

  _showSponsorText() async {
    await Future.delayed(Duration(milliseconds: 500)).then((_) {
      setState(() {
        _isSponsorTextVisible = true;
      });
    });
    await Future.delayed(Duration(milliseconds: 1500)).then((_) {
      pushHomeScreen(context);
    });
  }
}
