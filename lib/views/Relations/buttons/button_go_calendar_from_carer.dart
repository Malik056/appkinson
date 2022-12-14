import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_carer.dart';
import 'package:flutter/material.dart';

class ButtonGoCalendarFromCarer extends StatelessWidget {
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
        onPressed: () {
          RoutesCarer().toCalendarCarer(context);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/1-CALENDARIO.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
