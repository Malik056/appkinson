import 'package:appkinson/views/home_different_users/patient/patient_home_page.dart';
import 'package:appkinson/views/relation_request/relations_requets.dart';
import 'package:flutter/material.dart';
import 'package:appkinson/views/profiles/patient/patient_profile_screen.dart';
import 'package:appkinson/views/profiles/patient/profile_edition/profile_edition_patient.dart';

class CustomDrawerMenuPatient extends StatelessWidget {
  final Function? closeDrawer;

  const CustomDrawerMenuPatient({Key? key, this.closeDrawer}) : super(key: key);

  Widget decideImage() {
    if (imageFilePatient == null) {
      return Image.asset(
        "assets/images/user.png",
        width: 100,
        height: 100,
      );
    } else {
      return Image.file(
        imageFilePatient!,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.blue,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: decideImage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(nameController.text)
                ],
              )),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Profile");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => PatientProfileScreen()));
            },
            leading: Icon(Icons.person),
            title: Text(
              "Tu perfil",
            ),
          ),
          /*Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");

            },
            leading: Icon(Icons.settings),
            title: Text("Ajustes"),
          ),*/
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => PatientHomePage()));
            },
            leading: Icon(Icons.home),
            title: Text("Ir al Home"),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => RelationsRequest()));
            },
            leading: Icon(Icons.notifications),
            title: Text("Notificaciones"),
          ),
        ],
      ),
    );
  }
}
