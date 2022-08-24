import 'package:appkinson/model/user.dart';
import 'package:appkinson/routes/routes_doctor.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/Medicines/medicines.dart';
import 'package:appkinson/views/relations/doctor_patients.dart';
import 'package:appkinson/views/relations/doctor_patients.dart';
import 'package:flutter/material.dart';

import '../doctor_patients.dart';

class ButtonGoMedicinesFromDoctor extends StatelessWidget {
  final int idPatient;

  ButtonGoMedicinesFromDoctor({@required this.idPatient});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        shape: CircleBorder(),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          print('patient bboton ${idPatient.toString()}');
          String token = await Utils().getToken();
          items = await EndPoints().getMedicinesAlarms(idPatient, token);
          RoutesPatient().toScheduleMedicines(context, idPatient);
          //  RoutesDoctor().toPatientAlarmAndMedicine(context, idPatient);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/2-MEDICINAS.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}