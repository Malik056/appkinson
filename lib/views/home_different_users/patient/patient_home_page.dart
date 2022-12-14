// ignore_for_file: unused_element

import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/home_different_users/patient/buttons/button_go_no_motor_symptoms.dart';
import 'package:appkinson/views/relations/buttons/button_go_reporter.dart';
import 'package:flutter/material.dart';
import 'buttons/button_go_calendar.dart';
import 'buttons/button_go_profile.dart';
import 'buttons/button_go_relations_request.dart';
import 'buttons/button_go_medicines_schedule.dart';
import 'buttons/button_go_toolbox.dart';
import 'buttons/button_go_weekly_form.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePage createState() => _PatientHomePage();
}

class _PatientHomePage extends State<PatientHomePage> {
  bool shouldPop = false;
  String? token;
  var id;
  @override
  void initState() {
    //_obtenerToken();
    super.initState();
  }

  Future<void> _obtenerToken() async {
    token = await Utils().getToken();
    this.id = await Utils().getFromToken('id');
    print("iddddd:" + id.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          return shouldPop;
        },
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue[400]!, Colors.blue[900]!],
                        ),
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/starsBackGround.png"),
                        )),
                    //  child: Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 265,
                          left: 255,
                          child: ButtonGoRelationsRequest(),
                        ),
                        Positioned(
                          top: 240,
                          left: 137,
                          child: ButtonGoReporter(idPatient: this.id),
                        ),
                        /*
                          Positioned(
                            top: 250,
                            right: 125,
                            child: ButtonGoReminder(),
                          ),
                          */
                        Image.asset(
                          "assets/images/coronadr.png",
                          width: 150,
                          fit: BoxFit.fitWidth,
                          height: size.height * 0.4,
                          alignment: Alignment.bottomLeft,
                        ),
                        Positioned(
                            top: 70,
                            left: 200,
                            child: Text(
                              "??Qu?? \nHaremos \nHoy?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "Raleway2"),
                            )),
                      ],
                    ),
                    //  ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ButtonGoCalendar(),
                              Text(
                                "Calendario \n",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 17,
                                    fontFamily: "Raleway2"),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              ButtonGoMedicinesSchedule(),
                              Text(
                                "Medicamentos \n",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 17,
                                    fontFamily: "Raleway2"),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              ButtonGoNoMotorSymptoms(),
                              Text(
                                "S??ntomas \nNo Motores",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 17,
                                    fontFamily: "Raleway2"),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ButtonGoProfile(),
                              Text(
                                "Perfil \n",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 17,
                                    fontFamily: "Raleway2"),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              ButtonGoToolBox(),
                              Text(
                                "Actividades &\n Juegos",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 18,
                                    fontFamily: "Raleway2"),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              ButtonGoWeeklyForm(),
                              Text(
                                "Estado \nde ??nimo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 17,
                                    fontFamily: "Raleway2"),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.width, size.width, size.width - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
