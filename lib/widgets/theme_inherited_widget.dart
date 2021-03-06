import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitcher extends InheritedWidget {
  final _ThemeSwitcherWidgetState data;

  const ThemeSwitcher({
    Key key,
    @required this.data,
    @required Widget child
  }) : assert(child != null),
       super(key: key, child: child);

  static _ThemeSwitcherWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ThemeSwitcher)
        as ThemeSwitcher)
          .data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this != oldWidget;
  }
}

class ThemeSwitcherWidget extends StatefulWidget {
  final bool initialDarkModeOn;
  final Widget child;

  ThemeSwitcherWidget({Key key, this.initialDarkModeOn, this.child})
      : assert(initialDarkModeOn != null),
        assert(child != null),
        super(key: key);

  @override
  _ThemeSwitcherWidgetState createState() => _ThemeSwitcherWidgetState();
}

class _ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  bool isDarkModeOn;

  void switchDarkMode() async {
    setState(() {
      isDarkModeOn = !isDarkModeOn;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isDarkModeOn', isDarkModeOn);
  }

  @override
  Widget build(BuildContext context) {
    isDarkModeOn = isDarkModeOn ?? widget.initialDarkModeOn;
    return ThemeSwitcher(
      data: this,
      child: widget.child,
    );
  }
}
