import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:flutter/material.dart';

//import '../../register/register_page.dart';

class ButtonGoAboutParkinson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        ElevatedButton(
          style: buildButtonStyle(
            border: CircleBorder(),
            horiztonalPadding: 10,
            background: Colors.grey[50],
          ),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
          onPressed: () {
            RoutesPatient().toAboutParkinson(context);
          },
          child: Image.asset(
            "assets/images/parkinsonHand.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Sobre Parkinson",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
