import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/administrator/form_add_item.dart';
// ignore: unused_import
import 'package:appkinson/views/toolbox/about_food/food_list.dart';
import 'package:flutter/material.dart';

import '../excercises_list.dart';

//import '../../register/register_page.dart';

class ButtonGoAboutExcercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ItemToolbox> itemsByType;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        ElevatedButton(
          style: buildButtonStyle(
            border: CircleBorder(),
            background: Colors.grey[50],
            horiztonalPadding: 10,
          ),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

          onPressed: () async {
            ItemToolbox itemToolbox = new ItemToolbox();
            String? id = await Utils().getFromToken('id');
            String? token = await Utils().getToken();
            itemsByType = await EndPoints().getItemsToolbox(id, token);
            print("Cantidad de items");
            print(itemsByType.length);
            print(itemsByType.toString());
            items.clear();
            for (int i = 0; i < itemsByType.length; i++) {
              itemToolbox = itemsByType[i];
              if (itemToolbox.type?.compareTo('EJERCICIO') == 0) {
                items.add(itemToolbox);
              }
            }
            print(items.length);
            RoutesGeneral().toListExcercises(context);
          },
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/12-EJERCICIOS.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Ejercicios",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
