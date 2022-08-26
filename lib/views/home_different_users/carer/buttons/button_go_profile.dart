import 'dart:convert';

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_carer.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/profiles/carer/carer_profile_screen.dart';
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
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String? token = await Utils().getToken();
          print(token);
          var patientPhoto = await EndPoints().getUserName(token);
          // ignore: unused_local_variable
          var patient = await Utils().getFromToken('nombre');
          String? email = await Utils().getFromToken('email');

          var codeList = json.decode(patientPhoto);
          //namePatient
          //print('hey' + codeList[0]['NAME']);
          nameCarer = codeList[0]['NAME'];
          emailCarer = email??'';

          var res = await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFileCarer = res;
          });

          //print(imageFilePatient.uri.toFilePath());

          // var carer = await EndPoints()
          // .getCarer(user, currentUser['id'].toString(), token);
          RoutesCarer().toCarerProfile(context);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/4-PERFIL.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
