import 'package:flutter/material.dart';
import 'package:grande_serra/screen/home_screen.dart';

void main() {
  runApp(new MaterialApp(
    home: HomeView(),
  ));
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/programacao': (context) => HomeScreen(),
        '/pedidos': (context) => HomeScreen()
      },
    );
  }
}
