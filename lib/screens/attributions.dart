import 'package:danef_dictionary/config/app_colors.dart';
import 'package:danef_dictionary/config/constants.dart';
import 'package:easy_localization/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';

class AttributionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.attributionsScreenBackgroundColorLight,
      appBar: AppBar(
        backgroundColor: AppColors.attributionsScreenBackgroundColorLight,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          tr("settings.attributions"),
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: "DidactGothic",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Html(
              data: Constants.attrTextLoadingWordsAnim,
              onLinkTap: (url) => launchURL(url),
              style: {
                "div": Style(color: Colors.white, fontSize: FontSize.medium)
              },
            ),
            SizedBox(height: screenHeight * 0.025),
            Html(
              data: Constants.attrTextGettingWordsFromCloudAnim,
              onLinkTap: (url) => launchURL(url),
              style: {
                "div": Style(color: Colors.white, fontSize: FontSize.medium)
              },
            ),
            SizedBox(height: screenHeight * 0.025),
            Html(
              data: Constants.attrTextSleepingCatAnim,
              onLinkTap: (url) => launchURL(url),
              style: {
                "div": Style(color: Colors.white, fontSize: FontSize.medium)
              },
            ),
            SizedBox(height: screenHeight * 0.025),
            Html(
              data: Constants.attrTextDeveloperWorkingAnim,
              onLinkTap: (url) => launchURL(url),
              style: {
                "div": Style(color: Colors.white, fontSize: FontSize.medium)
              },
            ),
          ],
        ),
      ),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch URL');
  }
}
