import 'dart:convert';

import 'package:appkinson/routes/routes_doctor.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/profiles/doctor/doctor_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../../../constants/globals.dart';

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
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          // var doctor = await EndPoints()
          // .getCarer(user, currentUser['id'].toString(), token);
          String? token = await Utils().getToken();
          if(token == null) { //TODO: Handle NULL (TAHA)
            return;
          }
          var patient = await EndPoints().getUserName(token);

          var codeList = json.decode(patient);
          //namePatient
          print('hey' + codeList[0]['NAME']);
          nameDoctor = codeList[0]['NAME'];
          emailDoctor = codeList[0]['EMAIL'];
          var res =
              await EndPoints().getPhotoUser(token, codeList[0]['PHOTOPATH']);
          this.setState(() {
            imageFileDoctor = res;
          });
          RoutesDoctor().toDoctorProfile(context);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/4-PERFIL.png",
          height: size.height * 0.15,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
