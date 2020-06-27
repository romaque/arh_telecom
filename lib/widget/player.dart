import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audio_notification.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grande_serra/models/radios.dart';
import 'package:volume/volume.dart';

class Player extends StatefulWidget {
  RadiosModel radio;

  Player(this.radio);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool _statusPlay = false;
  int maxVol, currentVol;
  String _currentUrl;
  AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _play() async {
    setState(() {
      this._statusPlay = true;
    });

    _audioPlayer.release();

    AudioNotification audioObject = AudioNotification(
      smallIconFileName: "ic_launcher",
      title: "AO VIVO",
      subTitle: "Radio Grande Serra",
      isLocal: false,
      notificationDefaultActions: NotificationDefaultActions.ALL,
    );

    final Result result = await _audioPlayer.play(
      widget.radio.url,
      repeatMode: true,
      respectAudioFocus: true,
      audioNotification: audioObject,
      //playerMode: PlayerMode.FOREGROUND,
      position: Duration(milliseconds: 0)
    );

    if (result == Result.ERROR) {
      print("something went wrong in play method :(");
    }
  }

  Future<void> _stop() async {
    setState(() {
      this._statusPlay = false;
    });

    final Result result = await _audioPlayer.stop();
    if (result == Result.FAIL) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.ERROR) {
      print("something went wrong in stop :(");
    }
  }

  _updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._updateVolumes();
    AudioPlayer.logEnabled = false;
    _currentUrl = widget.radio.url;
    _setVol(currentVol);
  }

  _setVol(int i) async {
    await Volume.setVol(i);
  }

  @override
  Widget build(BuildContext context) {
    if(_currentUrl != widget.radio.url){
      _currentUrl = widget.radio.url;
      _stop();
      _play();
    }

    return Column(
      children: <Widget>[
        GestureDetector(
          child: Icon(
            !this._statusPlay
                ? FontAwesomeIcons.playCircle
                : FontAwesomeIcons.stopCircle,
            color: Color(0xFFF7B200),
            size: 160.0,
          ),
          onTap: () => {
            if (!this._statusPlay) {this._play()} else {this._stop()}
          },
        ),
        SizedBox(
          height: 30.0,
        ),
        Center(
          child: Container(
            width: 270.0,
            child: Row(
              children: <Widget>[
                Icon(
                  (currentVol != null && currentVol > 0)
                      ? FontAwesomeIcons.volumeUp
                      : FontAwesomeIcons.volumeMute,
                  color: Color(0xFFFF482D),
                  size: 38.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                (currentVol != null || maxVol != null)
                    ? Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xFFFF482D),
                            inactiveTrackColor: Color(0xFFF7B200),
                            trackHeight: 8.0,
                            thumbColor: Color(0xFFFF482D),
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 12.0),
                            overlayColor: Colors.purple.withAlpha(32),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 14.0),
                          ),
                          child: Slider(
                            value: currentVol / 1.0,
                            max: maxVol / 1.0,
                            min: 0,
                            onChanged: (double d) {
                              Volume.controlVolume(AudioManager.STREAM_MUSIC);
                              _setVol(d.toInt());
                              _updateVolumes();
                            },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
