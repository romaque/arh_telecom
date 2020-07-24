import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grande_serra/models/radios.dart';

class RadioModal extends StatefulWidget {
  final ValueChanged<RadiosModel> onCodeChanged;

  RadioModal({this.onCodeChanged});

  @override
  _RadioModalState createState() => _RadioModalState();
}

class _RadioModalState extends State<RadioModal> {
  _changeRadio(item) {
    widget.onCodeChanged(item);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "Faça sua GRANDE escolha",
          style: TextStyle(
              color: Color(0xFF581A4E), fontSize: 19.0, fontFamily: 'Gilroy'),
        ),
      ),
      FutureBuilder(
          future: fetchRadio(),
          builder: (BuildContext context,
              AsyncSnapshot<List<RadiosModel>> snapshot) {
            if (snapshot.hasData) {
              List<RadiosModel> _RadioModals = snapshot.data;

              return Column(
                  children: _RadioModals.map((item) {
                return Container(
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF482D),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 17.0,
                            color: Color(0xFFF7B200),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            item.title.toUpperCase(),
                            style: TextStyle(
                                fontSize: 17.0,
                                decoration: TextDecoration.none,
                                color: Color(0xFFF7B200)),
                          )
                        ],
                      ),
                    ),
                    onTap: () => {this._changeRadio(item)},
                  ),
                );
              }).toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
    ]);
  }
}
