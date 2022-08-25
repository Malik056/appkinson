// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q0.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q1.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q2.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q3.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q4.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q5.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q6.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q7.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q8.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q9.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q10.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q11.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q12.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q13.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q14.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q15.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q16.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q17.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q18.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q19.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q20.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q21.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q22.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q23.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q24.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q25.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q26.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q27.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q28.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q29.dart';
import '../no_motor_symptoms_form_patient/no_motor_symptoms_form_q30.dart';

class NoMotorSymptomsFormQ extends StatefulWidget {
  final int idPatient;

  NoMotorSymptomsFormQ({Key key, this.idPatient}) : super(key: key);
  @override
  _NoMotorSymptomsFormQ createState() => _NoMotorSymptomsFormQ(this.idPatient);
}

class _NoMotorSymptomsFormQ extends State<NoMotorSymptomsFormQ> {
  final int idPatient;
  _NoMotorSymptomsFormQ(this.idPatient);
  final controller = PageController(
    initialPage: 0,
  );

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    bool shouldPop = true;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
        onWillPop: () async {
        RestartQ1().setTile();
        RestartQ2().setTile();
        RestartQ3().setTile();
        RestartQ4().setTile();
        RestartQ5().setTile();
        RestartQ6().setTile();
        RestartQ7().setTile();
        RestartQ8().setTile();
        RestartQ9().setTile();
        RestartQ10().setTile();
        RestartQ11().setTile();
        RestartQ12().setTile();
        RestartQ13().setTile();
        RestartQ14().setTile();
        RestartQ15().setTile();
        RestartQ16().setTile();
        RestartQ17().setTile();
        RestartQ18().setTile();
        RestartQ19().setTile();
        RestartQ20().setTile();
        RestartQ21().setTile();
        RestartQ22().setTile();
        RestartQ23().setTile();
        RestartQ24().setTile();
        RestartQ25().setTile();
        RestartQ26().setTile();
        RestartQ27().setTile();
        RestartQ28().setTile();
        RestartQ29().setTile();
        RestartQ30().setTile();
          return shouldPop;
        },
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Síntomas No Motores",
        ),
        backgroundColor: Colors.blue,
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          NoMotorSymptomsFormQ0(),
          NoMotorSymptomsFormQ1(),
          NoMotorSymptomsFormQ2(),
          NoMotorSymptomsFormQ3(),
          NoMotorSymptomsFormQ4(),
          NoMotorSymptomsFormQ5(),
          NoMotorSymptomsFormQ6(),
          NoMotorSymptomsFormQ7(),
          NoMotorSymptomsFormQ8(),
          NoMotorSymptomsFormQ9(),
          NoMotorSymptomsFormQ10(),
          NoMotorSymptomsFormQ11(),
          NoMotorSymptomsFormQ12(),
          NoMotorSymptomsFormQ13(),
          NoMotorSymptomsFormQ14(),
          NoMotorSymptomsFormQ15(),
          NoMotorSymptomsFormQ16(),
          NoMotorSymptomsFormQ17(),
          NoMotorSymptomsFormQ18(),
          NoMotorSymptomsFormQ19(),
          NoMotorSymptomsFormQ20(),
          NoMotorSymptomsFormQ21(),
          NoMotorSymptomsFormQ22(),
          NoMotorSymptomsFormQ23(),
          NoMotorSymptomsFormQ24(),
          NoMotorSymptomsFormQ25(),
          NoMotorSymptomsFormQ26(),
          NoMotorSymptomsFormQ27(),
          NoMotorSymptomsFormQ28(),
          NoMotorSymptomsFormQ29(),
          NoMotorSymptomsFormQ30(
            idPatient: idPatient,
          ),
        ],
      ),
    ),
  );
  }
}
