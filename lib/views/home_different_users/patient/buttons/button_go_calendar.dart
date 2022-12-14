import 'dart:convert';

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/calendar/calendar_screen_view2.dart';
import 'package:flutter/material.dart';
import '../../../../routes/routes_patient.dart';

//import '../../register/register_page.dart';

var codeList;

class ButtonGoCalendar extends StatefulWidget {
  @override
  _ButtonGoCalendarState createState() => _ButtonGoCalendarState();
}

class _ButtonGoCalendarState extends State<ButtonGoCalendar> {
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
          meetingPatient = <Meeting>[];
          //SymptomsFormPatientM m= await EndPoints().getSymptomsFormPatient(token,currentUser['id'].toString());\
          String? id = await Utils().getFromToken('id');
          String? token = await Utils().getToken();
          String m = await EndPoints().getSymptomsFormPatient(token, id);
          //final DateTime today = DateTime.now();
          listPacientes = m;
          codeList = json.decode(m);
          //List<String> patients = [];
          for (var a = 0; a < codeList.length; a++) {
            //patients.add(codeList[a]['EMAIL']);
            print('formdate: ${codeList[a]['formdate']}');
            DateTime dateBd = DateTime.parse(codeList[a]['formdate']);
            final DateTime startTime = DateTime(dateBd.year, dateBd.month, dateBd.day, dateBd.hour, 0, 0);
            final DateTime endTime = startTime.add(const Duration(hours: 1));
            if (codeList[a]['Q1'] == 'on' || codeList[a]['Q1'] == 'ON' || codeList[a]['Q1'] == 'ON Bueno') {
              if (codeList[a]['Q2'] != "") {
                meetingPatient.add(Meeting('ON Bueno????', startTime, endTime, Colors.green, false));
              } else {
                meetingPatient.add(Meeting('ON Bueno', startTime, endTime, Colors.green, false));
              }
            }
            if (codeList[a]['Q1'] == 'off' || codeList[a]['Q1'] == 'OFF' || codeList[a]['Q1'] == 'OFF Malo') {
              if (codeList[a]['Q2'] != "") {
                meetingPatient.add(Meeting('OFF Malo????', startTime, endTime, Colors.red, false));
              } else {
                meetingPatient.add(Meeting('OFF Malo', startTime, endTime, Colors.red, false));
              }
            }
            if (codeList[a]['Q1'] == 'on bueno' || codeList[a]['Q1'] == 'ON Muy Bueno') {
              if (codeList[a]['Q2'] != "") {
                meetingPatient.add(Meeting('ON Muy Bueno????', startTime, endTime, Colors.green[700]!, false));
              } else {
                meetingPatient.add(Meeting('ON Muy Bueno', startTime, endTime, Colors.green[700]!, false));
              }
            }
            if (codeList[a]['Q1'] == 'off malo' || codeList[a]['Q1'] == 'OFF Muy Malo') {
              if (codeList[a]['Q2'] != "") {
                meetingPatient.add(Meeting('OFF Muy Malo????', startTime, endTime, Colors.red[800]!, false));
              } else {
                meetingPatient.add(Meeting('OFF Muy Malo', startTime, endTime, Colors.red[800]!, false));
              }
            }
          }
          RoutesPatient().toCalendar(context);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/1-CALENDARIO.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
