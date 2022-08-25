import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:flutter/material.dart';

class ButtonGoFormFeelsFromCarer extends StatelessWidget {
  final int idPatient;

  ButtonGoFormFeelsFromCarer({@required this.idPatient});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesPatient().toFeelsForm(context, idPatient);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/6-SENTIMIENTOS.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
