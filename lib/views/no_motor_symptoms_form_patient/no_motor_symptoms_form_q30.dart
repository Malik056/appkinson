// ignore_for_file: unused_local_variable

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../model/no_motor_symptoms_form.dart';
import '../../services/end_points.dart';
import 'no_motor_symptoms_form_q1.dart';
import 'no_motor_symptoms_form_q2.dart';
import 'no_motor_symptoms_form_q3.dart';
import 'no_motor_symptoms_form_q4.dart';
import 'no_motor_symptoms_form_q5.dart';
import 'no_motor_symptoms_form_q6.dart';
import 'no_motor_symptoms_form_q7.dart';
import 'no_motor_symptoms_form_q8.dart';
import 'no_motor_symptoms_form_q9.dart';
import 'no_motor_symptoms_form_q10.dart';
import 'no_motor_symptoms_form_q11.dart';
import 'no_motor_symptoms_form_q12.dart';
import 'no_motor_symptoms_form_q13.dart';
import 'no_motor_symptoms_form_q14.dart';
import 'no_motor_symptoms_form_q15.dart';
import 'no_motor_symptoms_form_q16.dart';
import 'no_motor_symptoms_form_q17.dart';
import 'no_motor_symptoms_form_q18.dart';
import 'no_motor_symptoms_form_q19.dart';
import 'no_motor_symptoms_form_q20.dart';
import 'no_motor_symptoms_form_q21.dart';
import 'no_motor_symptoms_form_q22.dart';
import 'no_motor_symptoms_form_q23.dart';
import 'no_motor_symptoms_form_q24.dart';
import 'no_motor_symptoms_form_q25.dart';
import 'no_motor_symptoms_form_q26.dart';
import 'no_motor_symptoms_form_q27.dart';
import 'no_motor_symptoms_form_q28.dart';
import 'no_motor_symptoms_form_q29.dart';

class NoMotorSymptomsFormQ30 extends StatefulWidget {
  final int idPatient;

  NoMotorSymptomsFormQ30({Key key, this.idPatient}) : super(key: key);
  @override
  _NoMotorSymptomsFormQ30 createState() =>_NoMotorSymptomsFormQ30(this.idPatient);
}

enum SigningCharacter { Si, No, Nada }
SigningCharacter _character30;
int selectedStateRadioQ30 = 0;

class _NoMotorSymptomsFormQ30 extends State<NoMotorSymptomsFormQ30> {
  final int idPatient;
  _NoMotorSymptomsFormQ30(this.idPatient);
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[350],
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.topCenter,
              child: Text(
                "Creer que le pasan cosas que otras personas le dicen que no son verdad.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Ralewaybold",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(children: <Widget>[
              Divider(
                height: 80,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'Si',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.Si,
                groupValue: _character30,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character30 = value;
                    selectedStateRadioQ30 = 1;
                  });
                },
              ),
              Divider(
                height: 100,
              ),
              RadioListTile<SigningCharacter>(
                title: const Text(
                  'No',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                value: SigningCharacter.No,
                groupValue: _character30,
                onChanged: (SigningCharacter value) {
                  setState(() {
                    _character30 = value;
                    selectedStateRadioQ30 = 0;
                  });
                },
              ),
              Divider(
                height: 50,
              ),
              ElevatedButton(
                child: Text("Guardar registro", style: TextStyle(fontSize: 20)),
                style: buttonStyleStadiumPaddingH50PrimaryWhite(context),
                //onPressed: () => save(),
                onPressed: () async {
                  NoMotorSymptomsForm patientForm = new NoMotorSymptomsForm();
                  patientForm.q1 = BringAnswer1().send();
                  patientForm.q2 = BringAnswer2().send();
                  patientForm.q3 = BringAnswer3().send();
                  patientForm.q4 = BringAnswer4().send();
                  patientForm.q5 = BringAnswer5().send();
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
                  patientForm.q17 = BringAnswer17().send();
                  patientForm.q18 = BringAnswer18().send();
                  patientForm.q19 = BringAnswer19().send();
                  patientForm.q20 = BringAnswer20().send();
                  patientForm.q21 = BringAnswer21().send();
                  patientForm.q22 = BringAnswer22().send();
                  patientForm.q23 = BringAnswer23().send();
                  patientForm.q24 = BringAnswer24().send();
                  patientForm.q25 = BringAnswer25().send();
                  patientForm.q26 = BringAnswer26().send();
                  patientForm.q27 = BringAnswer27().send();
                  patientForm.q28 = BringAnswer28().send();
                  patientForm.q29 = BringAnswer29().send();
                  patientForm.q30 = BringAnswer30().send();
                  patientForm.date = new DateTime.now();
                  
                  String id = await Utils().getFromToken('id');
                  String token = await Utils().getToken();
                  var savedEmotional = await EndPoints().registerNoMotorSymptomsForm(patientForm, idPatient, token);
                  int acumulative = patientForm.q1 + patientForm.q2 + patientForm.q3 + patientForm.q4 + patientForm.q5 + patientForm.q6 + patientForm.q7 + patientForm.q8 + patientForm.q9 + patientForm.q10 + patientForm.q11 + patientForm.q12 + patientForm.q13 + patientForm.q14 + patientForm.q15 + patientForm.q16 + patientForm.q17 + patientForm.q18 + patientForm.q19 + patientForm.q20 + patientForm.q21 + patientForm.q22 + patientForm.q23 + patientForm.q24 + patientForm.q25 + patientForm.q26 + patientForm.q27 + patientForm.q28 + patientForm.q29 + patientForm.q30;
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
                  debugPrint(acumulative.toString());
                  RoutesGeneral().toPop(context);
                },
              ),
            ]),

            /*Expanded(
            flex: 1,
          */
          ),
        ],
      ),
    );
  }
  total(int result){
    debugPrint(result.toString());
    showDialog(
    context: context,
    builder:(BuildContext context) => const AlertDialog(title: Text('Material Alert!')));
  }
  
}


class BringAnswer30 {
  int send() {
    return selectedStateRadioQ30;
  }
}
class RestartQ30 {
  void setTile(){
    _character30 = SigningCharacter.Nada;
  }
}