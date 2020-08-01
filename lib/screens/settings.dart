import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/config/constants.dart';
import 'package:danef_dictionary/widgets/theme_inherited_widget.dart';
import 'package:easy_localization/public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr("settings.app_bar_title")),
      ),
      body: SettingsBody(),
    );
  }
}

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: <Widget>[
        ListTile(
          leading: ThemeSwitcher.of(context).isDarkModeOn
              ? Icon(Icons.wb_sunny)
              : Image.asset(Assets.moon, width: 20, height: 20),
          title: Text(
            ThemeSwitcher.of(context).isDarkModeOn
                ? tr("settings.turn_on_the_lights")
                : tr("settings.turn_off_the_lights"),
            style: TextStyle(fontSize: 20),
          ),
          onTap: () => ThemeSwitcher.of(context).switchDarkMode(),
        ),
        ListTile(
          leading: Icon(
            Icons.share,
            color: ThemeSwitcher.of(context).isDarkModeOn
                ? Colors.white
                : Colors.black,
          ),
          title: Text(
            tr("settings.share"),
            style: TextStyle(fontSize: 20),
          ),
          onTap: launchShare,
        ),
        ListTile(
          leading: Icon(
            Icons.mail,
            color: ThemeSwitcher.of(context).isDarkModeOn
                ? Colors.white
                : Colors.black,
          ),
          title: Text(
            tr("settings.give_feedback"),
            style: TextStyle(fontSize: 20),
          ),
          onTap: launchMailClient,
        ),
        ListTile(
          leading: Icon(
            Icons.star,
            color: ThemeSwitcher.of(context).isDarkModeOn
                ? Colors.white
                : Colors.black,
          ),
          title: Text(
            tr("settings.rate_the_app"),
            style: TextStyle(fontSize: 20),
          ),
          onTap: launchGooglePlayPage,
        ),
        ListTile(
          leading: Icon(
            Icons.group,
            color: ThemeSwitcher.of(context).isDarkModeOn
                ? Colors.white
                : Colors.black,
          ),
          title: Text(
            tr("settings.attributions"),
            style: TextStyle(fontSize: 20),
          ),
          onTap: launchGooglePlayPage,
        ),
        Lottie.asset(
          Assets.developer_working_anim_path,
          width: screenWidth * 0.4,
          height: screenHeight * 0.4,
        ),
        GestureDetector(
          child: Column(
            children: <Widget>[
              Text(
                tr("settings.developer_desc_text"),
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'sametsahin.dev',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          onTap: launchDeveloperPortfolio,
        )
      ],
    );
  }
}


launchShare() async {
  const url = Constants.googlePlayUrl;
  await Share.share(url);
}

launchMailClient() async {
  const url = Constants.feedbackUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch url: $url';
  }
}

launchGooglePlayPage() async {
  const url = Constants.googlePlayUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch url: $url';
  }
}

launchDeveloperPortfolio() async {
  const url = Constants.developerPortfolioUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch url: $url';
  }
}
