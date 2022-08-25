import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_doctor.dart';
import 'package:flutter/material.dart';

class ButtonGoPatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 30,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          //items = await EndPoints().getMedicinesAlarms( currentUser['id'].toString(), token);
          RoutesDoctor().toPatientList(context);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/15-PACIENTES.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
