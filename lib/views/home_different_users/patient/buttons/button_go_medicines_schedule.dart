import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/views/Medicines/medicines.dart';
import 'package:flutter/material.dart';
import 'package:appkinson/utils/utils.dart';

class ButtonGoMedicinesSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String? id = await Utils().getFromToken('id');
          String? token = await Utils().getToken();
          if(token == null || id == null) {//TODO: Handle NULL (TAHA)
            return;
          }
          items = await EndPoints().getMedicinesAlarms(id, token);
          RoutesPatient().toScheduleMedicines(context, int.parse(id));
        },
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
