import 'dart:convert';
import 'package:appkinson/model/user.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/profiles/doctor/doctor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileEditionDoctor extends StatefulWidget {
  @override
  __ProfileEdition createState() => __ProfileEdition();
}

TextEditingController nameControllerDoctor = new TextEditingController();

class __ProfileEdition extends State<ProfileEditionDoctor> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Text("Cambio de Nombre"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: TextField(
                controller: nameControllerDoctor,
                decoration: InputDecoration(
                    hintText: "Ingrese su Nombre",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
              onPressed: () async {
                var m = new metod2();
                var user = await m.send();
                debugPrint(user.name);

                String id = await Utils().getFromToken('id');
                String token = await Utils().getToken();
                String save = await EndPoints().modifyUsers(user, id, token);

                debugPrint(save);

                setState(() {
                  nameDoctor = nameControllerDoctor.text;
                });

                if (save == 'Actualizado') {
                  RoutesGeneral().toPop(context);
                }

                RoutesGeneral().toPop(context);
              },
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Confirmar cambios", style: TextStyle(fontSize: 13)),
            ),
          ]),
        ));
  }
}

class metod2 {
  Future<User> send() async {
    var newUser = new User(name: nameControllerDoctor.text);
    debugPrint(newUser.name);
    return newUser;
  }
}
