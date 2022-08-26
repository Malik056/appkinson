import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_admin.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/views/administrator/item_widget_administrator.dart';
import 'package:appkinson/views/alarms_and_medicine/alarm_and_medicine_page.dart';
import 'package:flutter/material.dart';

class ListItemsAdministrator extends StatefulWidget {
  @override
  _ListItemsAdministratorState createState() => _ListItemsAdministratorState();
}

var items;
var id = 0;

class _ListItemsAdministratorState extends State<ListItemsAdministrator> {
  @override
  void initState() {
    super.initState();
  }

  final key = GlobalKey<AnimatedListState>();
  // ignore: unused_field
  DateTime? _alarmTime;
  // ignore: unused_field
  String? _alarmTimeString;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: Text(
        "Ítems"
      ),
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
      ],
    ),
  );

  Widget buildItem(item, int index, Animation<double> animation) => ItemToolboxWidgetAdministrator(
    item: item,
    animation: animation,
    onClicked: () => removeItem(index),
  );

  Widget buildInsertButton() => ElevatedButton(
    style: buttonStyleWhite,
    child: Icon(
      Icons.add,
      size: 50,
      color: Colors.lightGreen,
    ),
    onPressed: () {
      RoutesAdmin().toFormAddItem(context);
    },
  );

  void insertItem(int index, AlarmAndMedicine item) {
    items.insert(index, item);
    key.currentState?.insertItem(index);
    Navigator.pop(context);
  }

  void removeItem(int index) {
    EndPoints().deleteItemToolbox(items[index].idItem.toString());
    final item = items.removeAt(index);
    key.currentState?.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}
