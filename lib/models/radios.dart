import 'dart:convert';
import 'package:http/http.dart' as http;

class RadiosModel {
  final String title;
  final String url;
  final String slug;
  final String logo;

  RadiosModel(this.title, this.url, this.slug, {this.logo});

  factory RadiosModel.fromJson(Map<String, dynamic> json) {
    return RadiosModel(json['title'], json['url'], json['slug'],
        logo: json['logo']);
  }
}

Future<List<RadiosModel>> fetchRadio() async {
  final res = await http.get('https://radiograndeserra.com.br/streaming.json');

  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);

    List<RadiosModel> programs = body
        .map(
          (dynamic item) => RadiosModel.fromJson(item),
        )
        .toList();

    return programs;
  } else {
    throw "Can't get radio.";
  }
}
