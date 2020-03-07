import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/config/constants.dart';
import 'package:danef_dictionary/widgets/theme_inherited_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Preferences(),
    );
  }
}

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  FluttieAnimationController _developerWorkingAnimation;
  bool _animationReady = false;
  
  @override
  void initState() {
    _prepareAnimation();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildListView(),
        Expanded(
          child: Column(
            children: <Widget>[
              _animationReady ? AnimatedOpacity(
                opacity: _animationReady ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: FluttieAnimation(
                  _developerWorkingAnimation,
                  size: Size(350, 350)
                ),
              ) : Container(),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Developer: Samet Şahin',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'sametsahin.dev',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: _launchDeveloperPortfolio,
              )
            ],
          ),
        )
      ],
    );
  }
  
  Widget _buildListView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: ThemeSwitcher.of(context).isDarkModeOn ?
            Icon(Icons.wb_sunny):
            Image.asset(Assets.moon, width: 20, height: 20),
            title: Text(
              ThemeSwitcher.of(context).isDarkModeOn ?
              'Turn on the lights' : 'Turn off the lights',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () => ThemeSwitcher.of(context).switchDarkMode(),
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: ThemeSwitcher.of(context).isDarkModeOn ?
              Colors.white : Colors.black,
            ),
            title: Text(
              'Share',
              style: TextStyle(fontSize: 20),
            ),
            onTap: _launchShare,
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: ThemeSwitcher.of(context).isDarkModeOn ?
              Colors.white : Colors.black,
            ),
            title: Text(
              'Give feedback',
              style: TextStyle(fontSize: 20),
            ),
            onTap: _launchMailClient,
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: ThemeSwitcher.of(context).isDarkModeOn ?
              Colors.white : Colors.black,
            ),
            title: Text(
              'Rate the app',
              style: TextStyle(fontSize: 20),
            ),
            onTap: _launchGooglePlayPage,
          ),
        ],
      ),
    );
  }

  _prepareAnimation() async {
    final instance = Fluttie();
    final developerWorkingComposition =
      await instance.loadAnimationFromAsset(Assets.developer_working_anim_path);
    _developerWorkingAnimation = await instance.prepareAnimation(
      developerWorkingComposition,
      repeatMode: RepeatMode.START_OVER,
      repeatCount: RepeatCount.infinite()
    );
    if (mounted) {
      setState(() {
        _animationReady = true;
        _developerWorkingAnimation.start();
      });
    }
  }

}

_launchShare() async {
  const url = Constants.googlePlayUrl;
  await Share.share(url);
}

_launchMailClient() async {
  const url = Constants.feedbackUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch url: $url';
  }
}

_launchGooglePlayPage() async {
  const url = Constants.googlePlayUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch url: $url';
  }
}

_launchDeveloperPortfolio() async {
  const url = Constants.developerPortfolioUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch url: $url';
  }
}

