library utils.request;

import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class request {
  static Future<dynamic> get(String url) async {
    http.Response response;

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }else{
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> post(String url, Map body) async {

    http.Response response;

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };

    response = await http.post(
      url,
      body: body,
      headers: requestHeaders,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }else{
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> put(String url, Map body) async {

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };

    final response = await http.put(
      url,
      body: body,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }else{
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> delete(String url) async {

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };

    final response = await http.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    }else{
      throw json.decode(response.body);
    }
  }
}