import 'package:danef_dictionary/config/assets.dart';
import 'package:danef_dictionary/widgets/theme_inherited_widget.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              ThemeSwitcher.of(context).isDarkModeOn ?
                'Turn on the lights' : 'Turn off the lights',
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              icon: ThemeSwitcher.of(context)
                      .isDarkModeOn ?
              Icon(Icons.wb_sunny) :
              Image.asset(Assets.moon,
                  height: 20,
                  width: 20,
              ),
              onPressed: () => ThemeSwitcher.of(context).switchDarkMode(),
            ),
          ),
        )
      ],
    );
  }
}

