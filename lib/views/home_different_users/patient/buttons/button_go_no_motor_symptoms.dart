import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:flutter/material.dart';

//import '../../register/register_page.dart';

class ButtonGoNoMotorSymptoms extends StatelessWidget {
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
        onPressed: () async {
          String id = await Utils().getFromToken('id');
          // ignore: unused_local_variable
          String token = await Utils().getToken();
          RoutesPatient().toNoMotorSymptoms(context, int.parse(id));
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/condiciones.png",
          height: size.height * 0.09,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
