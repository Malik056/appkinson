import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient2.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient3.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2_off.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2_on.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q2.dart';

import 'package:flutter/material.dart';

import 'symptoms_form_patient_q1.dart';
import 'symptoms_form_patient_q2.dart';

class SymptomsFormPatient extends StatefulWidget {
  @override
  _SymptomsForm createState() => _SymptomsForm();
}

class _SymptomsForm extends State<SymptomsFormPatient> {
  final controller = PageController(
    initialPage: 0,
  );

  // ignore: unused_field
  int _current = 0;

  Widget decideForm() {
    debugPrint(BringAnswerPatient2().send().toString());

    if (BringAnswerPatient2().send().toString() == '1') {
      return SymptomsFormPatientQ2ON();
    } else {
      return SymptomsFormPatientQ2OFF();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Formulario de síntomas",
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(3.0),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.vertical,
        children: [
          SymptomsFormPatientQ1(),
          SymptomsFormPatientQ2(),
          ElevatedButton(
            style: buildButtonStyle(
              border: roundedRadius18,
              background: Color.fromRGBO(0, 160, 227, 1),
              forground: Colors.white,
              horiztonalPadding: 50,
            ),
            onPressed: () async {
              // addUsers('jorge', '1234');
              if (BringAnswerPatient2().send().toString() == 'ON') {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => SymptomsFormPatient2()));
              } else {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => SymptomsFormPatient3()));
              }
            },
            child: Text("Pulsa para continuar", style: TextStyle(fontSize: 15)),
          ),
          //debugPrint('hola');
          //debugPrint(BringAnswerPatient2().send());
          // symptomsFormPatientQ3(),
          //symptomsFormPatientQ4(),
          //symptomsFormPatientQ5(),

          /*symptomsFormQ17(),
          symptomsFormQ18(),
          symptomsFormQ19(),
          symptomsFormQ20(),
          symptomsFormQ21(),
          symptomsFormQ22(),
          symptomsFormQ23(),
          symptomsFormQ24(),
          symptomsFormQ25(),
          symptomsFormQ26(),
          symptomsFormQ27(),
          symptomsFormQ28(),*/
        ],
      ),
    );
  }
}
