import 'dart:convert';

import 'package:http/http.dart';

class Network {
  final String url;

  Network(this.url);

  Future getData() async {
    print('Calling uri: $url');
    Response response = await get(url);
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      print(response.statusCode);
    }
  }
}