import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_admin.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/administrator/list_items_administrator.dart';
import 'package:flutter/material.dart';

class ButtonGoCheckItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: ElevatedButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          horiztonalPadding: 10,
          background: Colors.grey[50],
        ),
        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
        onPressed: () async {
          String id = await Utils().getFromToken('id');
          String token = await Utils().getToken();
          items = await EndPoints().getItemsToolbox(id, token);
          RoutesAdmin().toListItems(context);
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
