import 'dart:io';
import 'package:appkinson/routes/routes_general.dart';
import '../symptoms_form_doctor/video_plugin.dart';
import 'package:flutter/material.dart';
import '../../services/end_points.dart';
import '../../model/symptoms_form.dart';
import '../login/buttons/button_login.dart';
import '../symptoms_form_doctor/symptoms_form_q1.dart';
import '../symptoms_form_doctor/symptoms_form_q2.dart';
import '../symptoms_form_doctor/symptoms_form_q3.dart';
import '../symptoms_form_doctor/symptoms_form_q4.dart';
import '../symptoms_form_doctor/symptoms_form_q5.dart';
import '../symptoms_form_doctor/symptoms_form_q6.dart';
import '../symptoms_form_doctor/symptoms_form_q7.dart';
import '../symptoms_form_doctor/symptoms_form_q8.dart';
import '../symptoms_form_doctor/symptoms_form_q9.dart';
import '../symptoms_form_doctor/symptoms_form_q10.dart';
import '../symptoms_form_doctor/symptoms_form_q11.dart';
import '../symptoms_form_doctor/symptoms_form_q12.dart';
import '../symptoms_form_doctor/symptoms_form_q13.dart';
import '../symptoms_form_doctor/symptoms_form_q14.dart';
import '../symptoms_form_doctor/symptoms_form_q15.dart';
import '../symptoms_form_doctor/symptoms_form_q16.dart';
import '../calendar/calendar_screen.dart';

class symptomsFormQ29 extends StatefulWidget {
  @override
  _symptomsFormQ29 createState() => _symptomsFormQ29();
}

class _symptomsFormQ29 extends State<symptomsFormQ29> {
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
                  child: fileMedia == null
                      ? Icon(Icons.play_circle_outline, size: 240)
                      : (source == MediaSource.image
                          ? Image.file(fileMedia)
                          : VideoWidget(fileMedia)),
                ),
                const SizedBox(height: 24),
                RaisedButton(
                  child: Text('Capturar video'),
                  shape: StadiumBorder(),
                  onPressed: () => capture(MediaSource.video),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                RaisedButton(
                  child: Text('Eliminar video'),
                  shape: StadiumBorder(),
                  onPressed: () => delete(),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 12),
                RaisedButton(
                  child: Text('Guardar registro'),
                  shape: StadiumBorder(),
                  //onPressed: () => save(),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () async {
                    SymptomsForm patientForm = new SymptomsForm();
                    patientForm.q1 = BringAnswer1().send();
                    patientForm.q2 = BringAnswer2().send();
                    patientForm.q3 = BringAnswer3().send();
                    patientForm.q4 = BringAnswer4().send();
                    patientForm.q5 = BringAnswer5().send();
                    /*
                    patientForm.q6 = BringAnswer6().send();
                    patientForm.q7 = BringAnswer7().send();
                    patientForm.q8 = BringAnswer8().send();
                    patientForm.q9 = BringAnswer9().send();
                    patientForm.q10 = BringAnswer10().send();
                    patientForm.q11 = BringAnswer11().send();
                    patientForm.q12 = BringAnswer12().send();
                    patientForm.q13 = BringAnswer13().send();
                    patientForm.q14 = BringAnswer14().send();
                    patientForm.q15 = BringAnswer15().send();
                    patientForm.q16 = BringAnswer16().send();
                    */
                    patientForm.video = fileMedia;
                    patientForm.date = tempDate;
                    var savedDone = await EndPoints().registerSymptomsForm(
                        patientForm, currentUser['id'].toString(), token);

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
