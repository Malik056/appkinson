import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:flutter/material.dart';

//import '../../register/register_page.dart';

class ButtonGoGame extends StatelessWidget {
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
            RoutesPatient().toGame(context);
          },
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/11-GAMES-JUEGOS.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Juego Tap",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
