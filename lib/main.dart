import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Danef Dictionary',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Danef Dictionary'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SearchFieldWidget(),
    );
  }
}

class SearchFieldWidget extends StatefulWidget {
  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  var dummmyWords = ['aaaxxx', 'bbbxxxx', 'cccccxxxx', 'dddxxxx'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1.5,
                ),
                borderRadius: new BorderRadius.circular(16.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1.5,
                ),
                borderRadius: new BorderRadius.circular(16.0),
              ),
            )),
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
      ),
    );
  }

  List<String> _getSuggestions(String pattern) {
    List<String> suggestionsToReturn = new List();
    for (final word in dummmyWords) {
      if (word.contains(pattern)) {
        suggestionsToReturn.add(pattern);
      }
    }
    return suggestionsToReturn;
  }
}
