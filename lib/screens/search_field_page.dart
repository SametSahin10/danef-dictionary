import 'package:danef_dictionary/widgets/meaning_widget.dart';
import 'package:danef_dictionary/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchFieldPage extends StatefulWidget {
  @override
  _SearchFieldPageState createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage>
                            with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();
  bool _isClearIconVisible = false;
  bool _isMeaningVisible = false;

  final FocusNode _focusNode = FocusNode();

  AnimationController searchFieldAnimController;
  AnimationController meaningAnimationController;
  Animation searchFieldAnimation;
  Animation meaningAnimation;

  String _word = "Word";
  String _meaning = "Meaning";

  @override
  void initState() {
    super.initState();
    searchFieldAnimController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this)..addListener(() => setState(() {}));
    searchFieldAnimation = Tween(begin: 0.0, end: -250.0).chain(
                  CurveTween(
                    curve: Curves.fastOutSlowIn
                  )
                ).animate(searchFieldAnimController);
    _focusNode.addListener(() {
      print('Has focus: ${_focusNode.hasFocus}');
      if (_focusNode.hasFocus) {
        searchFieldAnimController.forward();
      }
    });

    meaningAnimationController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this)..addListener(() => setState(() {}));
    meaningAnimation = Tween(begin: 400.0, end: 0.0).chain(
              CurveTween(
                curve: Curves.fastLinearToSlowEaseIn
              )
            ).animate(meaningAnimationController);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    searchFieldAnimController.dispose();
    meaningAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: Transform.translate(
              offset: Offset(meaningAnimation.value, 0),
              child: Meaning(word: _word, meaning: _meaning),
            )
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
                    changeMeaningVisibility: _showMeaning,
                    setWordAndMeaning: _setWordAndMeaning,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
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
                'Search again',
                style: TextStyle(fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.green,
                  width: 0.8
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              textColor: Colors.green,
              onPressed: _focusOnSearchField
            ),
          ),
        )
      ],
    );
  }

  _showMeaning() {
    meaningAnimationController.forward();
  }

  _clearEnvironment() {
    _focusNode.unfocus();
    _textEditingController.clear();
    meaningAnimationController.reverse();
    searchFieldAnimController.reverse();
  }

  _setWordAndMeaning(String word, String meaning) {
    setState(() {
      _word = word;
      _meaning = meaning;
    });
  }

  _focusOnSearchField() {
    FocusScope.of(context).requestFocus(_focusNode);
  }
}