import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grande_serra/utils/env.dart';
import 'package:grande_serra/utils/request.dart';
import 'package:radio_player/radio_player.dart';
import '../models/radios.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController();
  String _video = '';

  RadiosModel radio = RadiosModel(
    title: 'RÁDIO ARH TELECOM',
    url: 'https://live.arhtelecom.com.br/streaming.mp3',
    youtube: 'https://www.youtube.com/@grandeserrafm909',
    instagram: 'https://www.instagram.com/f.washington.araujo/',
    whatsapp: 'https://api.whatsapp.com/send?phone=558781405099',
    facebook: 'https://www.facebook.com/grandeserrafm',
    cidade: 'Araripina',
    video: '',
  );

  RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: this.radio?.title ?? this.radio.title,
      url: this.radio?.url ?? this.radio.url,
      imagePath: 'images/app_icon.png',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });
  }

  set _setRadio(value) {
    radio = value;
  }

  @override
  void initState() {
    super.initState();
    this.initRadioPlayer();
  }

  _changeRadio(radio) {
    setState(() {
      _video = radio.video;
      _radioPlayer.pause();
      this.radio = radio;
      _radioPlayer.setChannel(
        title: this.radio!.title,
        url: this.radio!.url,
        imagePath: 'images/app_icon.png',
      );

      new Timer(const Duration(milliseconds: 500), () {
        _radioPlayer.play();
      });
    });
  }

  Future<void> _openUrl(url) async {
    try {
      var canLaunchNatively = await launch(url);
    } catch (e) {
      print("unable to launch");
    }
  }

  getHeight(altura) {
    return altura / 2 - 100;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.4,
              child: Image.asset(
                'images/bg_app.jpeg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900.withOpacity(0.5),
                    Colors.white.withOpacity(0.5),
                    Colors.red.withOpacity(0.5),
                    Colors.white.withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              width: width,
              height: height,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Center(
                      child: Image.asset(
                        'images/app_icon.png',
                        width: 200.0,
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 240.0,
                              width: 330.0,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(1000.0),
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            width: 200.0,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                                color: Color(0XFF2d3240),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1000.0))),
                                            child: Column(
                                              children: [
                                                Spacer(),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  "RÁDIO ARH TELECOM",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        !isPlaying
                                                            ? FontAwesomeIcons
                                                                .solidCirclePlay
                                                            : FontAwesomeIcons
                                                                .solidCirclePause,
                                                        color:
                                                            Color(0xFFffcc00),
                                                        size: 50.0,
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        !isPlaying
                                                            ? 'Ouvir'
                                                            : 'Pause',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFffcc00),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () => {
                                                    isPlaying
                                                        ? _radioPlayer.pause()
                                                        : _radioPlayer.play()
                                                  },
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _openUrl("https://arhtelecom.com.br/");
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 10.0,
                                    top: 10.0,
                                  ),
                                  height: 50.0,
                                  width: 50.0,
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFffcc00),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(1000.0),
                                    ),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.link,
                                    size: 18.0,
                                    color: Color(0xFF5a384a),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _openUrl(this.radio!.whatsapp);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 10.0,
                                    top: 10.0,
                                  ),
                                  height: 50.0,
                                  width: 50.0,
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFffcc00),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(1000.0),
                                    ),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 20.0,
                                    color: Color(0xFF5a384a),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _openUrl(this.radio!.instagram);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 10.0,
                                    top: 10.0,
                                  ),
                                  height: 50.0,
                                  width: 50.0,
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFffcc00),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(1000.0),
                                    ),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.instagram,
                                    size: 20.0,
                                    color: Color(0xFF5a384a),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
