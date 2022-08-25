import 'package:appkinson/constants/globals.dart';
import 'package:flutter/material.dart';

class ButtonLinkPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        style: buildButtonStyle(
          border: roundedRadius30,
          horiztonalPadding: 50,
          background: Colors.blue,
          forground: Colors.white,
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          //addUser();
        },
        child: Text("Agregar Paciente", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
