import 'package:danef_dictionary/widgets/search_field.dart';
import 'package:flutter/material.dart';

class SearchFieldPage extends StatefulWidget {
  @override
  _SearchFieldPageState createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage>
                            with TickerProviderStateMixin {
  final _textEditingController = TextEditingController();
  bool _isClearIconVisible = false;

  final FocusNode _focusNode = FocusNode();

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this)..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: -250.0).chain(
                  CurveTween(
                    curve: Curves.fastOutSlowIn
                  )
                ).animate(animationController);
    _focusNode.addListener(() {
      print('Has focus: ${_focusNode.hasFocus}');
      if (_focusNode.hasFocus) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(0, animation.value),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

//  List<String> _getSuggestions(String pattern) {
//
//  }
}