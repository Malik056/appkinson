import 'dart:convert';
import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/routes/routes_admin.dart';
import 'package:appkinson/routes/routes_carer.dart';
import 'package:appkinson/routes/routes_doctor.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:flutter/material.dart';
import "../input_field_login.dart";
import '../../../services/end_points.dart';

Map? currentUser;
var token;

class ButtonLogin extends StatefulWidget {
  @override
  _FormButtonLogin createState() => _FormButtonLogin();
}

class _FormButtonLogin extends State<ButtonLogin> {
  @override
  void initState() {
    super.initState();
    Utils().initWorkmanager();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: roundedRadius18,
          horiztonalPadding: 50,
          background: Colors.blue,
          forground: Colors.white,
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          var m = new Method();
          var user = await m.send();
          debugPrint(user.email);
          debugPrint(user.password);
          debugPrint("------");

          token = await EndPoints().authUser(user);

          debugPrint(token);
          Map responseJson = json.decode(token);
          if (responseJson["person"] != null) {
            debugPrint("contraseña invalida");
            invalid(0, context);
          } else if (responseJson["message"] != null) {
            debugPrint("correo invalido");
            invalid(1, context);
          } else {
            await Utils().saveToken(responseJson['token']);
            currentUser = Utils().tokenDecoder(token);
            if (currentUser == null) { //TODO: Handle NULL (TAHA)
              return;
            }
            cleanLogin();
            if (currentUser!['type'] == 'Cuidador') {
              RoutesCarer().toCarerHome(context);
            }
            if (currentUser!['type'] == 'Paciente') {
              bool isSetBackground = await Utils().isSetBackgroundTask();
              if (isSetBackground) {
                print('esta seteaada');
              }
              await Utils().setTaskGetAlarms();
              debugPrint("paciente");
              //getRelationsRequest();
              RoutesPatient().toPatientHome(context);
            }
            if (currentUser!['type'] == 'Doctor') {
              RoutesDoctor().toDoctorHome(context);
            }
            if (currentUser!['type'] == 'Admin') {
              RoutesAdmin().toAdminHome(context);
            }
          }
        },
        child: Text("Iniciar Sesión", style: TextStyle(fontSize: 15)),
      ),
    );
  }
}

invalid(int reason, context) {
  debugPrint("invalidez");
  String invalidReason = '';
  if (reason == 0) {
    invalidReason = "Contraseña invalida";
  }
  if (reason == 1) {
    invalidReason = "Email incorrecto";
  }
  showDialog(
    context: context,
    builder: (BuildContext context) => _buildPopupDialog(context, invalidReason),
  );
}

Widget _buildPopupDialog(BuildContext context, String invalidReason) {
  return new AlertDialog(
    title: Text(invalidReason),
    actions: <Widget>[
      new TextButton(
        style: buttonStyleWhite,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancelar'),
      ),
    ],
  );
}
