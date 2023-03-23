import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radio_player/radio_player.dart';
import 'layouts/main.dart';
import 'models/radios.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController();
  RadiosModel radio;
  List<RadiosModel> radios = [
    RadiosModel(
      title: 'ARARIPINA - PE',
      url: 'https://araripina.grandeserra.com.br/streaming.mp3',
      youtube: 'https://www.youtube.com/@grandeserrafm909',
      instagram: 'https://www.instagram.com/grandeserrafm/',
      whatsapp: 'https://api.whatsapp.com/send?phone=558792091545819',
      facebook: 'https://www.facebook.com/grandeserrafm',
    ),
    RadiosModel(
      title: 'OURICURI - PE',
      url: 'https://ouricuri.grandeserra.com.br/streaming.mp3',
      youtube: 'https://www.youtube.com/@GrandeSerraOuricuri',
      instagram: 'https://www.instagram.com/grandeserraouricuri/',
      whatsapp: 'https://api.whatsapp.com/send?phone=5587991640342',
      facebook: 'https://www.facebook.com/radiogsouricuri',
    ),
  ];

  RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: this.radio?.title ?? this.radios[0].title,
      url: this.radio?.url ?? this.radios[0].url,
      imagePath: 'images/logo.png',
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
      _radioPlayer.pause();
      this.radio = radio;
      _radioPlayer.setChannel(
        title: this.radio?.title,
        url: this.radio?.url,
        imagePath: 'images/logo.png',
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
      home: this.radio == null
          ? Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'images/bg_inicio.jpeg',
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                    ),
                  ),
                  Container(
                    height: height,
                    child: Column(
                      children: [
                        Spacer(),
                        Center(
                          child: Stack(
                            children: [
                              Opacity(
                                child: Image.asset(
                                  'images/logo.png',
                                  color: Colors.blue,
                                  width: 200.0,
                                ),
                                opacity: 0.2,
                              ),
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 0.7,
                                    sigmaY: 0.7,
                                  ),
                                  child: Image.asset(
                                    'images/logo.png',
                                    width: 200.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _changeRadio(radios[0]);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 7.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF492a5f),
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Araripina',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _changeRadio(radios[1]);
                              },
                              child: Container(
                                width: 120.0,
                                height: 50.0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 7.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFffc700),
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Ouricuri',
                                    style: TextStyle(
                                      color: Color(0xFF492a5f),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(
                          height: height / 8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      this.radio.title == 'ARARIPINA - PE'
                          ? 'images/bg_app_araripina.jpeg'
                          : 'images/bg_app.jpeg',
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                    ),
                  ),
                  Container(
                    width: width,
                    height: height,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: GestureDetector(
                              onTap: () {
                                _radioPlayer.pause();
                                setState(() {
                                  this.radio = null;
                                });
                              },
                              child: Container(
                                color: Colors.amber.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_circle_left_rounded,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text("Voltar para seleção"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: getHeight(height),
                          ),
                          Container(
                            height: 300.0,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    height: 240.0,
                                    width: 330.0,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 10.0,
                                          left: -30.0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                            child: Image.asset(
                                              'images/aovivo.png',
                                              height: 60.0,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(1000.0),
                                                  ),
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.all(10.0),
                                                  width: 200.0,
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                      color: Color(0XFF2d3240),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  1000.0))),
                                                  child: Column(
                                                    children: [
                                                      Spacer(),
                                                      SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Text(
                                                        "GRANDE SERRA FM",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      Text(
                                                        this.radio.title,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFffcc00),
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Ouvindo",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 17.0,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      GestureDetector(
                                                        child: Icon(
                                                          !isPlaying
                                                              ? FontAwesomeIcons
                                                                  .solidPlayCircle
                                                              : FontAwesomeIcons
                                                                  .solidPauseCircle,
                                                          color:
                                                              Color(0xFFffcc00),
                                                          size: 50.0,
                                                        ),
                                                        onTap: () => {
                                                          isPlaying
                                                              ? _radioPlayer
                                                                  .pause()
                                                              : _radioPlayer
                                                                  .play()
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
                                  height: 5.0,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        _openUrl(this.radio.facebook);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 10.0,
                                          top: 10.0,
                                        ),
                                        height: 35.0,
                                        width: 35.0,
                                        padding: EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFffcc00),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(1000.0),
                                          ),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.facebookF,
                                          size: 18.0,
                                          color: Color(0xFF5a384a),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _openUrl(this.radio.whatsapp);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 10.0,
                                          top: 10.0,
                                        ),
                                        height: 35.0,
                                        width: 35.0,
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
                                        _openUrl(this.radio.instagram);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 10.0,
                                          top: 10.0,
                                        ),
                                        height: 35.0,
                                        width: 35.0,
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
                                    GestureDetector(
                                      onTap: () {
                                        _openUrl(this.radio.youtube);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: 10.0,
                                          top: 10.0,
                                        ),
                                        height: 35.0,
                                        width: 35.0,
                                        padding: EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFffcc00),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(1000.0),
                                          ),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.youtube,
                                          size: 18.0,
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
