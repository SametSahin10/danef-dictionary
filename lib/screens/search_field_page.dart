import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchFieldPage extends StatefulWidget {
  @override
  _SearchFieldPageState createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage> {
  var dummmyWords = ['aaaxxx', 'bbbxxxx', 'cccccxxxx', 'dddxxxx'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(16.0),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              textAlign: TextAlign.center,
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                  borderRadius: new BorderRadius.circular(24.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ),
                  borderRadius: new BorderRadius.circular(16.0),
                ),
                hintStyle: TextStyle(fontSize: 18.0),
                hintText: 'Search a word')),
            suggestionsCallback: (pattern) {
              return pattern.isEmpty ? null : _getSuggestions(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: Icon(Icons.beach_access),
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (suggestion) {
              print(suggestion);
            },
          )),
    );
  }

  List<String> _getSuggestions(String pattern) {
    List<String> suggestionsToReturn = new List();
    for (final word in dummmyWords) {
      if (word.contains(pattern)) {
        suggestionsToReturn.add(word);
      }
    }
    return suggestionsToReturn;
  }
}