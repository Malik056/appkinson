import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_doctor.dart';
import 'package:flutter/material.dart';

class ButtonGoCalendarFromDoctor extends StatelessWidget {
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
        onPressed: () {
          RoutesDoctor().toCalendarDoctor(context);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/1-CALENDARIO.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
