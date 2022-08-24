import 'dart:io';

import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/views/calendar/calendar_screen_view2.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q1.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2_on.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q3.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q4.dart';
import 'package:appkinson/model/symptoms_form_patient_m.dart';

import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';

import 'package:appkinson/views/symptoms_form_doctor/video_plugin.dart';

import 'package:flutter/material.dart';

class VideoScreenDoctor extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

File fileMediaDoctor;

class _symptomsFormQ29 extends State<VideoScreenDoctor> {
  MediaSource source;
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
                      border: Border(
                          top: BorderSide(width: 2, color: Colors.grey[350]),
                          bottom:
                              BorderSide(width: 1, color: Colors.grey[350])),
                    ),
                    child: fileMediaDoctor == null
                        ? Icon(Icons.play_circle_outline, size: 240)
                        : (source == MediaSource.image
                            ? Image.file(fileMediaDoctor)
                            : VideoWidget(fileMediaDoctor)),
                  ),
                ),
                const SizedBox(height: 24),
                RaisedButton(
                  child: Text('Volver'),
                  shape: StadiumBorder(),
                  //onPressed: () => save(),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
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
              ],
            ),
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      fileMediaDoctor = null;
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
        fileMediaDoctor = result;
      });
    }
  }

  Future delete() async {
    setState(() {
      fileMediaDoctor = null;
    });
  }

  Future save() async {}

  void onChangedStateValue(Object value) {
    setState(() {
      selectedStateRadio = value;
    });
  }

  void onChangedDyskinesiaValue(Object value) {
    setState(() {
      selectedDyskinesiaRadio = value;
    });
  }
}