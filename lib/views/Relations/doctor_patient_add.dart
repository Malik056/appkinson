// ignore_for_file: unused_field, unused_local_variable

import 'dart:convert';

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
//import 'package:appkinson/views/calendar/calendar_screen_view2.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';

class DoctorPatientsAdd extends StatefulWidget {
  @override
  DoctorPatientsCustomAdd createState() => DoctorPatientsCustomAdd();
}

var codeListPatients;

class DoctorPatientsCustomAdd extends State<DoctorPatientsAdd> {
  final TextEditingController addPatientController = new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  TextEditingController editingController2 = TextEditingController();
  List<User> patientsAdd = [];
  List<User> patientsAddAux = [];
  List<User> _patientsAdd = [];
  List<User> items = [];
  bool isSearching = false;
  @override
  void initState() {
    getPatientsAdd();
    super.initState();
  }

  getPatientsAdd() async {
    User patientAdd;
    //Pedir lista de pacientes relacionados
    debugPrint("pidiendo pacientes");
    String? tipe = await Utils().getFromToken('type');
    String? id = await Utils().getFromToken('id');
    String? token = await Utils().getToken();
    if (tipe == null || token == null) {
      //TODO: Handle null (TAHA)
      return;
    }
    var patientsAux = await EndPoints().getUnrelatedPatients(token, tipe);
    debugPrint("pacientes pedidos");
    codeListPatients = json.decode(patientsAux);
    //List<User> patients = [];
    debugPrint(codeListPatients.toString());
    debugPrint("--------");
    debugPrint(codeListPatients[0]['Email']);
    for (var a = 0; a < codeListPatients.length; a++) {
      //patients.add(codeList[a]['EMAIL']);
      patientAdd = new User();
      patientAdd.email = codeListPatients[a]['Email'];
      patientAdd.id = codeListPatients[a]['IdUser'];
      _patientsAdd.add(patientAdd);
    }
    debugPrint("llenando");
    setState(() {
      items = _patientsAdd;
    });
    setState(() {
      patientsAdd = _patientsAdd;
    });
  }

  void filterSearchResults(String query) {
    List<User> dummySearchList = [];
    dummySearchList.addAll(patientsAdd);
    if (query.isNotEmpty) {
      List<User> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.email?.contains(query) ?? false) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items = dummyListData;
      });
      return;
    } else {
      setState(() {
        items = patientsAdd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: !isSearching
              ? Text('Pacientes No Agregados')
              : TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController2,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Buscar",
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!, width: 2.0),
                    ),
                  ),
                ),
          actions: <Widget>[
            !isSearching
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                  )
          ],
        ),
        body: SingleChildScrollView(
            //physics: ScrollPhysics(),
            child: Container(
                child: Column(
          key: UniqueKey(),
          children: <Widget>[
            ListView.separated(
              //scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (items.length),
              itemBuilder: (context, index) {
                User patient = items[index];
                return ListTile(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog(context, patient.email ?? ''),
                    );
                    //getPatients();
                  },
                  title: Text(patient.email ?? '', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.4)),
                  //subtitle: Text(user.email),
                  leading: CircleAvatar(
                    child: Icon(Icons.account_circle_outlined),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  dense: true,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 2, color: Colors.grey[200], indent: 15, endIndent: 20);
              },
            ),
          ],
        ))),
      ),
    );
  }
}

class PatientsList extends StatelessWidget {
  final List<User> _patients;

  PatientsList(this._patients);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: _buildPatiensList(),
    );
  }

  List<PatientsListItem> _buildPatiensList() {
    return _patients.map((user) => PatientsListItem(user)).toList();
  }
}

class PatientsListItem extends ListTile {
  PatientsListItem(User user)
      : super(
            //title: Text(user.email),
            title: Text("quemado@hotmail.com"),
            //subtitle: Text(user.email),
            leading: CircleAvatar(
              //child: Icon(Icons.account_circle_outlined),
              child: TextButton(
                onPressed: () {},
                child: const Text('Ver reporte'),
              ),
            ));
}

Widget _buildPopupDialog(BuildContext context, String email) {
  return new AlertDialog(
    title: Text("Enviar solicitud a " + email),
    content: Text('\nDebe esperar a que el paciente \nacepte la solicitud en el icono\nde la campana'),

    // '\nDebe esperar a que el paciente \nacepte la solicitud en el icono\n de la campana'
    actions: <Widget>[
      new TextButton(
        style: buildButtonStyle(forground: Theme.of(context).primaryColor),
        onPressed: () async {
          String? tipe = await Utils().getFromToken('type');
          String? token = await Utils().getToken();
          if (tipe == null || token == null) {
            //TODO: Handle null (TAHA)
            return;
          }
          var response = await EndPoints().linkUser(email, tipe, token);
          Navigator.of(context).pop();
        },
        child: const Text('Enviar'),
      ),
      new TextButton(
        style: buildButtonStyle(forground: Theme.of(context).primaryColor),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancelar'),
      )
    ],
  );
}
