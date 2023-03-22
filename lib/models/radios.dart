import 'dart:convert';

class RadiosModel {
  final String title;
  final String url;
  final String facebook;
  final String whatsapp;
  final String instagram;
  final String youtube;

  RadiosModel({
    this.title,
    this.url,
    this.youtube,
    this.instagram,
    this.whatsapp,
    this.facebook,
  });

  factory RadiosModel.fromJson(Map<String, dynamic> json) {
    return RadiosModel(
      title: json['title'],
      url: json['url'],
      youtube: json['youtube'],
      instagram: json['instagram'],
      whatsapp: json['whatsapp'],
      facebook: json['facebook'],
    );
  }
}
