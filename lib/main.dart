import 'package:flutter/material.dart';
import 'package:grande_serra/pages/inicio.dart';
import 'package:grande_serra/pages/video.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    supportedLocales: [const Locale('pt', 'BR')],
    home: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/video': (context) => VideoView(),
      },
    ),
  ));
}
