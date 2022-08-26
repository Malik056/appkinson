import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/alarms_and_medicine/alarm_and_medicine_page.dart';
import 'package:appkinson/views/home_different_users/admin/admin_home_page.dart';
import 'package:appkinson/views/home_different_users/carer/carer_home_page.dart';
import 'package:appkinson/views/home_different_users/doctor/doctor_home_page.dart';
import 'package:appkinson/views/home_different_users/patient/patient_home_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
// import 'package:nova_alarm_plugin/nova_alarm_plugin.dart';
import 'views/home_initial/home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'constants/constant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  workmanager.executeTask((task, inputData) async {
    switch (task) {
      case TASK_SET_ALARMS:
        print("$TASK_SET_ALARMS was executed. inputData = $inputData");
        var tokenID = await Utils().getFromToken('id');
        List<AlarmAndMedicine> alarms = await EndPoints().getMedicinesAndAlarms(tokenID ?? '');
        var dateTime = new DateTime.now();
        for (var alarm in alarms) {
          int hour = alarm.alarmTime!.hour;
          int minute = alarm.alarmTime!.minute;
          var dateClock = new DateTime(dateTime.year, dateTime.month, dateTime.day, hour, minute);
          var clockId = int.tryParse(
                '${alarm.idMedicine.toString()}${alarm.id.toString()}',
              ) ??
              (-1);
              //TODO: Need null safe Alternative to NovaAlarmPlugin
          // String time = (dateClock.millisecondsSinceEpoch).toString();
          // bool result = await NovaAlarmPlugin.setClock(
          //   time,
          //   clockId,
          //   title: "title: ${alarm.title}",
          //   content: "Tomar ${alarm.dose} de  ${alarm.medicine}",
          // );
          // print(' ${alarm.medicine} time: $time result: ${result.toString()}');
          await Future.delayed(Duration(seconds: 1));
        }
        print('finished');
        break;
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true, onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
  String? token = await Utils().getToken();
  if (token != null) {
    String? type = await Utils().getFromToken('type');
    runApp(MyApp(type ?? ''));
  } else {
    runApp(MyApp(null));
  }
}

class MyApp extends StatefulWidget {
  final String? type;
  MyApp(this.type);
  @override
  _MyAppState createState() => _MyAppState(this.type);
}

class _MyAppState extends State<MyApp> {
  String? token;
  final String? type;
  _MyAppState(this.type);
  @override
  Widget build(BuildContext context) {
    if (type == 'Cuidador') {
      return MaterialApp(debugShowCheckedModeBanner: false, home: CarerHomePage());
    } else if (type == 'Doctor') {
      return MaterialApp(debugShowCheckedModeBanner: false, home: DoctorHomePage());
    } else if (type == 'Paciente') {
      return MaterialApp(debugShowCheckedModeBanner: false, home: PatientHomePage());
    } else if (type == 'Admin') {
      return MaterialApp(debugShowCheckedModeBanner: false, home: AdminHomePage());
    } else {
      return new MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
    }
  }
}
