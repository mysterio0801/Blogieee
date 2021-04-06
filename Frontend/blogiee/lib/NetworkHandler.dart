import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHandler{
  String baseurl = "http://192.168.43.120:5000";
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future<dynamic> get(String url) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response  = await http.get(Uri.parse(url), headers: {"Authorization" : "Bearer $token"});
    print(token);
    if(response.statusCode == 200 || response.statusCode == 201){
      print(json.decode(response.body));
      return json.decode(response.body);
      
    }
  }

  Future<http.Response> post(String url, Map<String, String> body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response  = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type" : "application/json",
        "Authorization": "Bearer $token"},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type" : "application/json",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  NetworkImage getImage(String username){
    String url = formater("/uploads//$username.jpg");
    return NetworkImage(url);
  }

  String formater(String url){
    return baseurl+url;
  }
}