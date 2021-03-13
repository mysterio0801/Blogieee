import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler{
  String baseurl = "https://whispering-sea-27321.herokuapp.com";

  Future<dynamic> get(String url) async{
    url = formater(url);
    var response  = await http.get(url);
    if(response.statusCode == 200 || response.statusCode == 201){
      return json.decode(response.body);
    }
  }

  Future<http.Response> post(String url, Map<String, String> body) async{
    url = formater(url);
    var response  = await http.post(
      url,
      headers: {"Content-type" : "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  String formater(String url){
    return baseurl+url;
  }
}