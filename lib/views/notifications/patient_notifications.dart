import 'package:appkinson/views/notifications/notification_plugin.dart';
import 'package:flutter/material.dart';
import '../side_menus/custom_drawer_menu_patient.dart';

class PatientNotifications extends StatefulWidget {
  @override
  _PatientNotifications createState() => _PatientNotifications();
}

class _PatientNotifications extends State<PatientNotifications> {
  // FSBStatus status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawerMenuPatient(),
        body: PatientNotifications0(),
        // FoldableSidebarBuilder(
        //   status: status,
        //   drawer: CustomDrawerMenuPatient(),
        //   screenContents: PatientNotifications0(),
        // ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (!Scaffold.of(context).isDrawerOpen) {
                  Scaffold.of(context).openDrawer();
                } else {
                  Scaffold.of(context).closeDrawer();
                }
                // status = status == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
              });
            }),
      ),
    );
  }
}

class PatientNotifications0 extends StatefulWidget {
  @override
  _PatientNotifications0 createState() => _PatientNotifications0();
}

class _PatientNotifications0 extends State<PatientNotifications0> {
  bool valueSymptoms = false;
  bool valueCheerUp = false;
  @override
  void initState() {
    super.initState();
    notificationPlugin.setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          new SwitchListTile(
            value: valueSymptoms,
            onChanged: onChangeValueSymptoms,
            activeColor: Colors.amberAccent,
            secondary: new Icon(Icons.sick),
            title: new Text(
              'S??ntomas',
              style: new TextStyle(fontSize: 20.0),
            ),
            subtitle: new Text('??Recuerde registrar sus s??ntomas todos los d??as!'),
          ),
          SizedBox(
            height: 30,
          ),
          new SwitchListTile(
            value: valueCheerUp,
            onChanged: onChangeValueCheerUp,
            activeColor: Colors.amberAccent,
            secondary: new Icon(Icons.emoji_emotions_sharp),
            title: new Text(
              'Estado de ??nimo',
              style: new TextStyle(fontSize: 20.0),
            ),
            subtitle: new Text('??Recuerde registrar su estado de ??nimo cada semana!'),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {}
  onNotificationClick(String payload) {}

  void onChangeValueSymptoms(bool value) async {
    setState(() {
      valueSymptoms = value;
    });
    if (value == true) {
      await notificationPlugin.showDailyAtTime();
    } else {
      await notificationPlugin.cancelNotification();
    }
  }

  void onChangeValueCheerUp(bool value) async {
    setState(() {
      valueCheerUp = value;
    });
    if (value == true) {
      await notificationPlugin.showWeeklyAtDayTime();
    } else {
      await notificationPlugin.cancelNotification();
    }
  }
}
