import 'dart:convert';

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/administrator/form_add_item.dart';
import 'package:flutter/material.dart';

import '../news_list.dart';

class ButtonGoAboutNews extends StatelessWidget {
  @override
  List<ItemToolbox> itemsByType = [];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        ElevatedButton(
          style: buildButtonStyle(
            border: CircleBorder(),
            horiztonalPadding: 10,
            background: Colors.grey[50],
          ),
          //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
          onPressed: () async {
            ItemToolbox itemToolbox = new ItemToolbox();
            String id = await Utils().getFromToken('id');
            String token = await Utils().getToken();
            itemsByType = await EndPoints().getItemsToolbox(id, token);
            print(itemsByType.length);
            news.clear();
            for (int i = 0; i < itemsByType.length; i++) {
              itemToolbox = itemsByType[i];
              if (itemToolbox.type.compareTo('NOTICIA') == 0) {
                print("No entra");
                news.add(itemToolbox);
              }
            }

            RoutesGeneral().toListNews(context);
          },
          //textColor: Colors.white,
          child: Image.asset(
            "assets/images/10-NOTICIAS.png",
            height: size.height * 0.11,
          ),
          // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Noticias",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue[900], fontSize: 20, fontFamily: "Raleway2"),
        )
      ]),
    );
  }
}
