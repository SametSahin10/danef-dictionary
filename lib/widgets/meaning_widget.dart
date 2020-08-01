import 'package:flutter/material.dart';

class Meaning extends StatefulWidget {
  String word = 'Word';
  String meaning = "Meaning";

  Meaning({this.word, this.meaning});

  @override
  _MeaningState createState() => _MeaningState();
}

class _MeaningState extends State<Meaning> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 8,
                top: 8,
                bottom: 6),
              child: Text(
                widget.word,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'OpenSans'
                ),
              ),
            ),
            Divider(
              indent: 18,
              endIndent: 18,
              thickness: 0.5,
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 18,
                  right: 8,
                  top: 4,
                  bottom: 12),
              child: Text(
                widget.meaning,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'OpenSans'
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(
            width: 0.5,
            color: Colors.green
          )
        ),
      ),
    );
  }
}
