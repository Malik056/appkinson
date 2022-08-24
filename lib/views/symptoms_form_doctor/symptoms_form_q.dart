import 'package:flutter/material.dart';
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
import '../symptoms_form_doctor/symptoms_form_q29.dart';

class symptomsFormQ extends StatefulWidget {
  @override
  _symptomsFormQ createState() => _symptomsFormQ();
}

class _symptomsFormQ extends State<symptomsFormQ> {
  final controller = PageController(
    initialPage: 0,
  );

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Formulario de Síntomas",
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
          symptomsFormQ1(),
          symptomsFormQ2(),
          symptomsFormQ3(),
          symptomsFormQ4(),
          symptomsFormQ5(),
          /*
          symptomsFormQ6(),
          symptomsFormQ7(),
          symptomsFormQ8(),
          symptomsFormQ9(),
          symptomsFormQ10(),
          symptomsFormQ11(),
          symptomsFormQ12(),
          symptomsFormQ13(),
          symptomsFormQ14(),
          symptomsFormQ15(),
          symptomsFormQ16(),
          symptomsFormQ17(),
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
          symptomsFormQ29(),
        ],
      ),
    );
  }
}
