import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/views/login/login_page.dart';
import 'package:flutter/material.dart';

class ButtonGoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        style: buildButtonStyle(
          border: roundedRadius18,
          horiztonalPadding: 50,
          forground: Colors.blue,
          background: Colors.white,
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => LoginPage());
          Navigator.pushReplacement(context, route);
        },
        child: Text("¿Ya Tiene una Cuenta? ", style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
