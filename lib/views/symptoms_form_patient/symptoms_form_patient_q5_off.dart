import 'dart:io';
import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/calendar/calendar_screen_view2.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q1.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2_off.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q3.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q4.dart';
import 'package:appkinson/model/symptoms_form_patient_m.dart';

import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/views/symptoms_form_doctor/video_plugin.dart';

import 'package:flutter/material.dart';

class SymptomsFormPatientQ5OFF extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

class _symptomsFormQ29 extends State<SymptomsFormPatientQ5OFF> {
  File fileMedia;
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
                  child: fileMedia == null ? Icon(Icons.play_circle_outline, size: 240) : (source == MediaSource.image ? Image.file(fileMedia) : VideoWidget(fileMedia)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Capturar video'),
                  style: buildButtonStyle(
                    border: StadiumBorder(),
                    background: Theme.of(context).primaryColor,
                    forground: Colors.white,
                  ),
                  onPressed: () => capture(MediaSource.video),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Eliminar video'),
                  style: buildButtonStyle(
                    border: StadiumBorder(),
                    background: Theme.of(context).primaryColor,
                    forground: Colors.white,
                  ),
                  onPressed: () => delete(),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Guardar registro'),
                  style: buildButtonStyle(
                    border: StadiumBorder(),
                    background: Theme.of(context).primaryColor,
                    forground: Colors.white,
                  ),
                  //onPressed: () => save(),
                  onPressed: () async {
                    SymptomsFormPatientM patientForm = new SymptomsFormPatientM();

                    patientForm.q1 = BringAnswerPatient1().send();
                    patientForm.q2 = BringAnswerPatient2().send();
                    //patientForm.q3 = BringAnswer2Off().send();
                    //patientForm.q4 = BringAnswerPatientQ3().send();
                    //patientForm.q5 = BringAnswerPatientQ4().send();
                    patientForm.video = fileMedia;
                    patientForm.formDate = dateChoosed;

                    debugPrint('enviado');
                    String id = await Utils().getFromToken('id');
                    String token = await Utils().getToken();
                    var savedDone = await EndPoints().registerSymptomsFormPatient(patientForm, id, token);

                    debugPrint(savedDone.toString());

                    int hora = dateChoosed.hour;

                    final DateTime startTime = DateTime(dateChoosed.year, dateChoosed.month, dateChoosed.day, hora, 0, 0);
                    final DateTime endTime = startTime.add(const Duration(hours: 1));
                    Meeting m = new Meeting('off', startTime, endTime, Colors.red, false);
                    debugPrint(m.eventName);
                    //setState(() {
                    meetingPatient.add(m);

                    RoutesPatient().toCalendar(context);
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
      this.fileMedia = null;
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
        fileMedia = result;
      });
    }
  }

  Future delete() async {
    setState(() {
      this.fileMedia = null;
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
