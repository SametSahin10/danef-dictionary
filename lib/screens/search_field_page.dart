import 'package:danef_dictionary/screens/home_screen.dart';
import 'package:danef_dictionary/widgets/meaning_widget.dart';
import 'package:danef_dictionary/widgets/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SearchFieldScreen extends StatefulWidget {
  @override
  _SearchFieldScreenState createState() => _SearchFieldScreenState();
}

class _SearchFieldScreenState extends State<SearchFieldScreen>
    with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();
  bool _isClearIconVisible = false;
  bool _isMeaningVisible = false;
  bool _isSearchAgainVisible = false;

  final FocusNode _focusNode = FocusNode();

  AnimationController searchFieldAnimController;
  AnimationController meaningAnimFromRightController;
  Animation searchFieldAnimation;
  Animation meaningAnimFromRight;

  String _word = "Word";
  String _meaning = "Meaning";

  @override
  void initState() {
    var actualHeight = _getActualHeight();
    var animationEnd = -actualHeight * 0.375;
    searchFieldAnimController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this)
          ..addListener(() => setState(() {}));
    searchFieldAnimation = Tween(begin: 0.0, end: animationEnd)
        .chain(CurveTween(curve: Curves.fastOutSlowIn))
        .animate(searchFieldAnimController);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        searchFieldAnimController.forward();
      }
    });

    meaningAnimFromRightController =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this)
          ..addListener(() => setState(() {}));
    meaningAnimFromRight = Tween(begin: 400.0, end: 0.0)
        .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn))
        .animate(meaningAnimFromRightController);
    KeyboardVisibility.onChange.listen((visible) {
      if (!visible) {
        if (!_isMeaningVisible) {
          searchFieldAnimController.reverse();
        }
      }
    });
//    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
//      if (!visible) {
//        if (!_isMeaningVisible) {
//          searchFieldAnimController.reverse();
//        }
//      }
//    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    searchFieldAnimController.dispose();
    meaningAnimFromRightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          opacity: _isMeaningVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 700),
          child: Center(
            child: Transform.translate(
              offset: Offset(meaningAnimFromRight.value, 0),
              child: Meaning(word: _word, meaning: _meaning),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, searchFieldAnimation.value),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Material(
                  shadowColor: Colors.green,
                  elevation: 2.5,
                  borderRadius: BorderRadius.circular(12),
                  child: SearchField(
                    textEditingController: _textEditingController,
                    focusNode: _focusNode,
                    isClearIconVisible: _isClearIconVisible,
                    clearMeaning: _clearMeaning,
                    showMeaning: _showMeaning,
                    setWordAndMeaning: _setWordAndMeaning,
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _isSearchAgainVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 1000),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FlatButton.icon(
                  padding: EdgeInsets.all(10),
                  icon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  label: Text(
                    tr("Search again"),
                    style: TextStyle(fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 0.8),
                      borderRadius: BorderRadius.circular(12)),
                  textColor: Colors.green,
                  onPressed: _focusOnSearchField),
            ),
          ),
        )
      ],
    );
  }

  _clearMeaning() {
    if (_isMeaningVisible) {
      print('fading out meaning');
      _isMeaningVisible = false;
    }
  }

  _showMeaning() {
    meaningAnimFromRightController.forward();
    setState(() {
      _isMeaningVisible = true;
      _isSearchAgainVisible = true;
    });
  }

//  _clearEnvironment() {
//    _focusNode.unfocus();
//    _textEditingController.clear();
//    meaningAnimationController.reverse();
//    searchFieldAnimController.reverse();
//  }

  _setWordAndMeaning(String word, String meaning) {
    print('setting word and meaning');
    print('word: $word');
    print('meaning: $meaning');
    setState(() {
      _word = word;
      _meaning = meaning;
    });
  }

  _focusOnSearchField() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  double _getActualHeight() {
    // Subtracts padding and toolbar height and returns the actual height
    // left for widgets to reside.
    var rawHeight = ScreenSizes.height;
    var padding = ScreenSizes.padding;
    var actualHeight =
        rawHeight - padding.top - padding.bottom - kToolbarHeight;
    return actualHeight;
  }
}
