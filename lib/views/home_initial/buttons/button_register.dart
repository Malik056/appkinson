import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        style: buildButtonStyle(
          border: roundedRadius18,
          background: Colors.blue[700],
          horiztonalPadding: 50,
          forground: Colors.white,
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesGeneral().toRegister(context);
        },
        // child: Image.asset(
        //  "assets/images/cerebroAzul.png",
        // height: size.height * 0.25,
        //  ),
        child: Text("Registrarse ", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
