import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: roundedRadius18,
          horiztonalPadding: 50,
          background: Colors.grey[100],
          forground: Colors.blue,
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          RoutesGeneral().toLogin(context);
        },
        child: Text("Iniciar Sesión ", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
