import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/views/register/register_page.dart';
import 'package:flutter/material.dart';

class ButtonGoRegisterLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        style: buildButtonStyle(
          border: roundedRadius18,
          background: Colors.blue,
          horiztonalPadding: 50,
          forground: Colors.white,
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => RegisterPage());
          Navigator.pushReplacement(context, route);
        },
        child: Text("¿No Tiene una Cuenta? ", style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
