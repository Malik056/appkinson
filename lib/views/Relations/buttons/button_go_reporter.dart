import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_doctor.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:flutter/material.dart';

class ButtonGoReporter extends StatelessWidget {
  final int idPatient;

  ButtonGoReporter({@required this.idPatient});

  @override
  Widget build(BuildContext context) {
    int idPatient = this.idPatient;
    print("id ppp" + idPatient.toString());
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
          String type = await Utils().getFromToken("type");
          if (type == "Paciente") {
            print("object");
            var aux = await Utils().getFromToken("id");
            idPatient = int.parse(aux);
            print("entra pat" + idPatient.toString());
            //RoutesDoctor().toReportConfigPage(context, idPatient);
          }
          RoutesDoctor().toReportConfigPage(context, idPatient);
        },
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/14-LISTA.png",
          height: size.height * 0.08,
        ),
        // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
      ),
    );
  }
}
