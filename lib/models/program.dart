import 'dart:convert';

import 'package:http/http.dart' as http;

class ProgramModel {
  final String image;
  final String apresentador;
  final String audio;
  final String programa;
  final String post_content;
  final String inicio;
  final String fim;

  ProgramModel({this.image, this.apresentador, this.audio, this.programa, this.post_content, this.inicio, this.fim});

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      image: json['image'].toString(),
      apresentador: json['apresentador'].toString(),
      audio: json['audio'].toString(),
      programa: json['post_title'].toString(),
      post_content: json['post_content'].toString(),
      inicio: json['inicio'].toString(),
      fim: json['fim'].toString(),
    );
  }
}

Future<ProgramModel> fetchProgram(String slug) async {
  final response = await http.get('https://radiograndeserra.com.br/wp-json/wp/v2/programacao/ar?radio='+ slug);

  if (response.statusCode == 200) {
    return ProgramModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load program');
  }
}

Future<List<ProgramModel>> fetchPrograms(String slug) async {
  final res = await http.get('https://radiograndeserra.com.br/wp-json/wp/v2/programacao/programas?radio='+ slug);

  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);

    List<ProgramModel> programs = body
        .map(
          (dynamic item) => ProgramModel.fromJson(item),
    ).toList();

    return programs;
  } else {
    throw "Can't get program.";
  }
}

Future<List<dynamic>> fetchMusica(String slug, data) async {
  final res = await http.post('https://radiograndeserra.com.br/wp-json/wp/v2/programacao/email', body: data);

  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);

    return body;
  } else {
    throw "Can't get program.";
  }
}