import 'dart:convert';
import 'dart:io';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/profiles/carer/carer_profile_screen.dart';
import 'package:appkinson/views/profiles/patient/patient_profile_screen.dart';
import 'package:flutter/material.dart';

//import '../../register/register_page.dart';

class ButtonGoProfile extends StatefulWidget {
  @override
  _ButtonGoProfileState createState() => _ButtonGoProfileState();
}

class _ButtonGoProfileState extends State<ButtonGoProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        shape: CircleBorder(),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String token = await Utils().getToken();
          print(token);
          var patient = await EndPoints().getUserName(token);

          var codeList = json.decode(patient);
          //namePatient
          //print('hey' + codeList[0]['NAME']);
          namePatient = codeList[0]['NAME'];
          emailPatient = codeList[0]['EMAIL'];
          var res =
              await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFilePatient = res;
          });

          print(imageFilePatient.uri.toFilePath());
          RoutesPatient().toPatientProfile(context);
        },
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.grey[50],
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/perfil2.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
