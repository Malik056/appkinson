// ignore_for_file: unused_field

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_admin.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/administrator/form_add_item.dart';
import 'package:appkinson/views/toolbox/item_widget.dart';
import 'package:flutter/material.dart';

class ListExcercises extends StatefulWidget {
  @override
  _ListExcercisesState createState() => _ListExcercisesState();
}

List<ItemToolbox> items = [];
var id = 0;

class _ListExcercisesState extends State<ListExcercises> {
  final key = GlobalKey<AnimatedListState>();
  //List<AlarmInfo> items;
  DateTime _alarmTime;
  String _alarmTimeString;

  //AlarmInfo alarm;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Ejercicios"),
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) => buildItem(items[index], index, animation),
              ),
            ),

            /*Container(
              padding: EdgeInsets.all(5),
              child: buildInsertButton(),
            ),*/
          ],
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) => ItemToolboxWidgetGeneral(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
      );

  Widget buildInsertButton() => ElevatedButton(
        style: buttonStyleBackgroundWhite,
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.lightGreen,
        ),
        onPressed: () {
          RoutesAdmin().toFormAddItem(context);
        },
      );

  void insertItem(int index, ItemToolbox item) {
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    //EndPoints().deleteAlarm(index.toString(), getToken(), getId());
    final item = items.removeAt(index);

    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}

getId() async {
  String id = await Utils().getFromToken('id');
  return id;
}

getToken() async {
  String token = await Utils().getToken();
  return token;
}
