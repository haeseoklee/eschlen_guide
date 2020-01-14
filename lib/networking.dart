import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {

  final key;
  final String url;
  var data;
  var body;

  NetworkHelper({this.url, this.key});

  Future<dynamic> getData() async {

    http.Response response = await http.get(
      Uri.encodeFull(url),
        headers: {
          'Authorization' : key
        }
    );
    if(response.statusCode == 200){
      data = response.body;
    }else{
      data = {};
    }
    return jsonDecode(data);
  }
}