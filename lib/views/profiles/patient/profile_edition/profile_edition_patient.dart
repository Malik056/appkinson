import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/model/user.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/profiles/patient/patient_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileEditionPatient extends StatefulWidget {
  @override
  __ProfileEdition createState() => __ProfileEdition();
}

TextEditingController nameController = new TextEditingController();

class __ProfileEdition extends State<ProfileEditionPatient> {
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Ingrese su Nuevo Nombre", hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                style: buildButtonStyle(
                  border: roundedRadius18,
                  forground: Colors.white,
                  background: Colors.blue,
                  horiztonalPadding: 50,
                ),
                //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                onPressed: () async {
                  var m = new Method2();
                  var user = await m.send();

                  /*
              setState(() {
              nameCarer = nameControllerCarer.text;
            });
            */
                  /*
              debugPrint(user.name);
              var lista = token.split(".");
              var payload = lista[1];

              switch (payload.length % 4) {
                case 1:
                  break; // this case can't be handled well, because 3 padding chars is illeagal.
                case 2:
                  payload = payload + "==";
                  break;
                case 3:
                  payload = payload + "=";
                  break;
              }

              var decoded = utf8.decode(base64.decode(payload));
              currentUser = json.decode(decoded);
              debugPrint(currentUser['id'].toString());
              */
                  String? id = await Utils().getFromToken('id');
                  String? token = await Utils().getToken();
                  if (id == null || token == null) {
                    //TODO: Handle null (TAHA)
                    return;
                  }
                  String save = await EndPoints().modifyUsers(user, id, token);
                  debugPrint(save);
                  setState(() {
                    namePatient = nameController.text;
                  });

                  if (save == 'Actualizado') {
                    Navigator.pop(context);
                  }

                  Navigator.pop(context);
                },
                child: Text("Confirmar cambios", style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ));
  }
}

class Method2 {
  Future<User> send() async {
    var newUser = new User(name: nameController.text);
    debugPrint(newUser.name);
    return newUser;
  }
}
