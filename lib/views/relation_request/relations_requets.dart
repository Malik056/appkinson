// ignore_for_file: unused_field

import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/relation_request/request.dart';
import 'package:appkinson/views/relation_request/request_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:appkinson/services/end_points.dart';


/*
class RelationsRequest extends StatefulWidget {
  @override
  _RelationsRequest createState() => _RelationsRequest();
}

class _RelationsRequest extends State<RelationsRequest> {
  
  FSBStatus status;
  
  @override
  Widget build(BuildContext context) {
  return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(status: status , drawer: CustomDrawerMenu(), screenContents: RelationsRequest0()),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                status = status == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }
        ),
      ),
    ); 
  }
}*/

class RelationsRequest extends StatefulWidget {
  @override
  _RelationsRequestState createState() => _RelationsRequestState();
}

var items;

class _RelationsRequestState extends State<RelationsRequest> {
  final key = GlobalKey<AnimatedListState>();
  //final items = List.from(Data.relations);

  //List<AlarmInfo> items;
  DateTime? _alarmTime;
  String? _alarmTimeString;
  //AlarmInfo alarm;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Solicitudes de Relación"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.contact_support_rounded),
              color: Colors.white,
              onPressed: () {
                information(context);
              }),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) =>
                    buildItem(items[index], index, animation),
              ),
            ),
          ],
        ),
      );

  Widget buildItem(item, int index, Animation<double> animation) =>
      RequestItemWidget(
        item: item,
        animation: animation,
        onClicked: () => removeItem(index),
        onClicked2: () => removeItem2(index),
      );

  /*void insertItem(int index, RelationRequest item, String _alarmTimeString) {
    RelationRequest alarm;
    //alarm.title = "Hola";
   // alarm.title = _alarmTimeString;
    item.message = _alarmTimeString;
    items.insert(index, item);
    key.currentState.insertItem(index);
    Navigator.pop(context);
  }*/

  void removeItem(int index) {
    RelationRequest rq = items[index];

    debugPrint("bandera");
    debugPrint(rq.id.toString());
    debugPrint(rq.sender);
    EndPoints().sendResponseRelation('ACCEPT', rq.sender??'', rq.id.toString());
    final item = items.removeAt(index);

    key.currentState?.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }

  void removeItem2(int index) {
    debugPrint("Entra");
    RelationRequest rq = items[index];
    EndPoints().sendResponseRelation('DENIED', rq.sender??'', rq.id.toString());
    final item = items.removeAt(index);

    key.currentState?.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }
}

Future<String?> getToken() async {
  String? token = await Utils().getToken();
  return token;
}

information(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        _buildPopupDialog(context),
    barrierDismissible: true
  );
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      "En esta pantalla se le mostrará las solicitudes enviadas por los doctores y cuidadores que desean relacionar sus cuentas para poder interactuar con usted"
      ),
  );
}