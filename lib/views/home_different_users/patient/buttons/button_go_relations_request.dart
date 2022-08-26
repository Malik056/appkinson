import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/views/relation_request/relations_requets.dart';
import 'package:appkinson/utils/utils.dart';

import 'package:flutter/material.dart';

//import '../../register/register_page.dart';

class ButtonGoRelationsRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        style: buildButtonStyle(border: CircleBorder(), horiztonalPadding: 10),
        //RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String? token = await Utils().getToken();
          if(token == null) {//TODO: Handle NULL (TAHA)
            return;
          }
          //items =  getListRelationsRequest();
          items = await EndPoints().getRelationRequest(token);
          debugPrint(items.length.toString());
          RoutesPatient().toRelationsRequest(context);
        },
        //color: Colors.transparent,
        //textColor: Colors.white,
        child: Image.asset(
          "assets/images/7-ALERTA.png",
          height: size.height * 0.08,
        ),
      ),
    );
  }
}
