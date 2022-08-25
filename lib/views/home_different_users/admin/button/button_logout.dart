import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/views/home_initial/home_page.dart';
import 'package:appkinson/views/login/input_field_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonLogout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          debugPrint("Tapped Log Out....");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs?.clear();
          cleanLogin();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/cerrar-sesion.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
