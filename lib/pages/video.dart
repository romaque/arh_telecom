import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radio_player/radio_player.dart';
import 'package:wakelock/wakelock.dart';
import '../models/radios.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String video;

  VideoView(this.video);
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final _pageController = PageController();
  late VideoPlayerController _controller;
  bool acao = false;

  bool isPlaying = false;

  @override
  void initState() {
    Wakelock.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video),
    )..initialize().then((_) {
        setState(() {});
      });

    _controller.value.isPlaying ? _controller.pause() : _controller.play();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Wakelock.disable();
    super.dispose();
    _controller.dispose();
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
      home: GestureDetector(
        onTap: () {
          setState(() {
            acao = !acao;
          });
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            if (acao)
              Column(
                children: [
                  Spacer(),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.all(20.0),
                      width: 250.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                  setState(() {});
                                },
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close_outlined,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
