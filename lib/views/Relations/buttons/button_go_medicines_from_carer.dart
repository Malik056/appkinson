import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/Medicines/medicines.dart';
import 'package:flutter/material.dart';

class ButtonGoMedicinesFromCarer extends StatelessWidget {
  final int idPatient;

  ButtonGoMedicinesFromCarer({required this.idPatient});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String? token = await Utils().getToken();
          if (token == null) {
            //TODO: Handle null (TAHA)
            return;
          }
          items = await EndPoints().getMedicinesAlarms(idPatient, token);
          RoutesPatient().toScheduleMedicines(context, idPatient);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/2-MEDICINAS.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
