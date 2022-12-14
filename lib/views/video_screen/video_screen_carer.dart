import 'dart:io';
import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';


import 'package:appkinson/views/symptoms_form_doctor/video_plugin.dart';

import 'package:flutter/material.dart';

class VideoScreenCarer extends StatefulWidget {
  @override
  _SymptomsFormQ29 createState() => _SymptomsFormQ29();
}

File? fileMediaCarer;

class _SymptomsFormQ29 extends State<VideoScreenCarer> {
  MediaSource? source;
  int selectedStateRadio = 0;
  int selectedDyskinesiaRadio = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    border: Border(top: BorderSide(width: 2, color: Colors.grey), bottom: BorderSide(width: 1, color: Colors.grey)),
                  ),
                  child: fileMediaCarer == null ? Icon(Icons.play_circle_outline, size: 240) : (source == MediaSource.image ? Image.file(fileMediaCarer!) : VideoWidget(fileMediaCarer!)),
                )),
                const SizedBox(height: 24),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                ButtonTheme(
                  minWidth: 120.0,
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text('Volver'),
                    style: buildButtonStyle(
                      border: StadiumBorder(),
                      background: Theme.of(context).primaryColor,
                      forground: Colors.white,
                    ),
                    //onPressed: () => save(),
                    onPressed: () async {
                      /*
                      SymptomsFormPatientM patientForm =
                          new SymptomsFormPatientM();

                      patientForm.q1 = BringAnswerPatient1().send();
                      patientForm.q2 = BringAnswerPatient2().send();
                      //patientForm.q3 = BringAnswer2On().send();
                      //patientForm.q4 = BringAnswerPatientQ3().send();
                      //patientForm.q5 = BringAnswerPatientQ4().send();

                      patientForm.video = fileMedia;
                      patientForm.formDate = dateChoosed;

                      debugPrint('enviado');
                      var savedDone = await EndPoints()
                          .registerSymptomsFormPatient(
                              patientForm, currentUser['id'].toString(), token);

                      //void _getDataSource() {
                      //meetings = <Meeting>[];

                      //final DateTime today = DateTime.now();
                      int hora = dateChoosed.hour;
                      final DateTime startTime = DateTime(dateChoosed.year,
                          dateChoosed.month, dateChoosed.day, hora, 0, 0);
                      final DateTime endTime =
                          startTime.add(const Duration(hours: 1));
                      Meeting m = new Meeting('on', startTime, endTime,
                          const Color(0xFF0F8644), false);
                      debugPrint(m.eventName);
                      //setState(() {
                      meetings.add(m);
                      */
                      //});

                      //return meetings;
                      //}

                      // RoutesPatient().toCalendar(context);
                      RoutesGeneral().toPop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      fileMediaCarer = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMediaCarer = result;
      });
    }
  }

  Future delete() async {
    setState(() {
      fileMediaCarer = null;
    });
  }

  Future save() async {}

  void onChangedStateValue(int value) {
    setState(() {
      selectedStateRadio = value;
    });
  }

  void onChangedDyskinesiaValue(int value) {
    setState(() {
      selectedDyskinesiaRadio = value;
    });
  }
}
