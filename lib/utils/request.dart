library utils.request;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class httpCliente {
  static Future<dynamic> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response;

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }

    response = await http.get(
      Uri.parse(url),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data;
    } else {
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> post(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response;

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }

    response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: requestHeaders,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> put(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }

    final response = await http.put(
      Uri.parse(url),
      body: json.encode(body),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> patch(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }

    final response = await http.patch(
      Uri.parse(url),
      body: json.encode(body),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body);
    }
  }

  static Future<dynamic> delete(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }

    final response = await http.delete(
      Uri.parse(url),
      headers: requestHeaders,
    );

    return [];
  }

  static Future<dynamic> deleteAll(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }
    ;

    final response = await http.delete(
      Uri.parse(url),
      body: json.encode(body),
      headers: requestHeaders,
    );

    return [];
  }

  static file(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response;

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/pdf',
    };

    var token = prefs.getString('apiToken');

    if (token != null) {
      requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
    }

    response = await http.get(
      Uri.parse(url),
      headers: requestHeaders,
    );

    return response.bodyBytes;
  }

  static Future<dynamic> uploadImage(List<int> imageBytes) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mastri.envoysistemas.com.br/files'),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: '${DateTime.now().millisecondsSinceEpoch.toString()}.png',
        contentType: MediaType('image', 'png'),
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = json.decode(responseBody);
      return (data);
    } else {
      throw json.decode(
          'Erro durante o upload. Código de status: ${response.statusCode}');
    }
  }
}
