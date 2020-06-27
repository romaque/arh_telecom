import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grande_serra/models/program.dart';
import 'package:grande_serra/models/radios.dart';
import 'package:http/http.dart' as http;
class ProgramsScreen extends StatefulWidget {
  RadiosModel radio;

  ProgramsScreen(this.radio);

  @override
  _ProgramsScreenState createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: fetchPrograms(widget.radio.slug),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProgramModel>> snapshot) {
        if (snapshot.hasData) {
          List<ProgramModel> programs = snapshot.data;

          return Container(
              width: width,
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: programs
                  .map(
                    (ProgramModel program) => Container(
                  width: width,

                  child: Card(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            program.image,
                            fit: BoxFit.cover,
                            width: width,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                              padding:
                              EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    program.programa,
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        color: Color(0xFF54585F),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    removeAllHtmlTags(program.post_content),
                                    style: TextStyle(fontSize: 15.0, color: Color(0xFF54585F)),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            )
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  var horario = htmlText.replaceAll(exp, '');

  var expload = horario.split("\r\n");

  return expload[0] + expload[1];
}
