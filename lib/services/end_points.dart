// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';

import 'package:appkinson/constants/constant.dart';
import 'package:appkinson/model/no_motor_symptoms_form.dart';
import 'package:appkinson/model/emotional_form.dart';
import 'package:appkinson/model/symptoms_form.dart';
import 'package:appkinson/model/symptoms_form_patient_m.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/administrator/form_add_item.dart';
import 'package:appkinson/views/alarms_and_medicine/alarm_and_medicine_page.dart';
import 'package:appkinson/views/relation_request/request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

// Esta clase en general contiene todos los endpoints que
// conectan servicios del back-end solicitados por el
// front-end
class EndPoints {
  //Esta función llama a un  http post que agrega un usuario al sistema
  Future<String> addUsers(User newUser) async {
    Map data2 = {'email': newUser.email, 'password': newUser.password, 'name': newUser.name, 'type': newUser.type};
    debugPrint(data2.toString());
    debugPrint(endpointBack + addUserUrl);
    http.Response response = await http.post(Uri.parse(endpointBack + addUserUrl), body: data2);

    //debugPrint(response.body);
    String i = response.body;
    return i;
    //data = json.decode(response.body);
  }

  //Funcón que modifica la foto de un usuario
  Future<String> modifyUsersPhoto(User newUser, String tokenId, String token) async {
    debugPrint('hola2');
    if (newUser.photo == null) {
      return '';
    }
    String? fileName = newUser.photo!.path.split('/').last;
    debugPrint("File base name: $fileName");

    FormData formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(newUser.photo!.path, filename: fileName),
    });

    Dio dio = new Dio();
    dio.options.headers["authorization"] = jwtkey + (token);
    Response response = await dio.post(endpointBack + '/api/users/$tokenId', data: formData);
    /*http.Response response = await http.put(
        this.endpointBack + '/api/users/' + (token ?? '')Id,
        body: data2,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + decodedToken['token']
        });*/

    debugPrint(response.toString());
    String i = response.toString();
    return i;
    //data = json.decode(response.body);
  }

  //Funcion que modifica
  Future<String> modifyUsers(User newUser, String tokenId, String token) async {
    Map data2 = {
      //'email': newUser.email,
      //'password': newUser.password,
      'name': newUser.name,
      //'photo': newUser.photo
      //'type': newUser.type,
      //'image': newUser.photo
    };
    debugPrint('hola');
    http.Response response = await http.post(Uri.parse(endpointBack + modifyNameOfUserURL + tokenId), body: data2, headers: {HttpHeaders.authorizationHeader: jwtkey + (token)});

    //debugPrint(response.body);
    String i = response.body;
    return i;
    //data = json.decode(response.body);
  }

  //Esta función autentica un usuario para que pueda
  //acceder a la aplicación
  Future<String> authUser(User authUser) async {
    debugPrint("entro");
    Map data2 = {'email': authUser.email, 'password': authUser.password};
    http.Response response = await http.post(Uri.parse(endpointBack + authURL), body: data2);
    //debugPrint(data2.toString());
    debugPrint("-----");
    debugPrint(response.body);
    String body = response.body;
    return body;
  }

  //Esta función acepta una solicitud de relación que se
  //le manda a un paciente
  Future<String> sendResponseRelation(String answer, String type, String requesterId) async {
    Map data2 = {'Answer': answer, 'RequesterType': type, 'RequesterId': requesterId};
    debugPrint("entro");
    String? token = await Utils().getToken();
    debugPrint(token);
    http.Response response = await http.post(Uri.parse(endpointBack + '/api/patient/answerRequest'), body: data2, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    debugPrint("salio");
    String i = response.body;
    return i;
  }

  //Envíar ítems desde el administrador
  Future<String> sendItemToolbox(String titulo, String descripcion, String enlace, String tipo, var token) async {
    Map data2 = {'Title': titulo, 'Description': descripcion, 'URL': enlace, 'Type': tipo};
    debugPrint("agregando");
    debugPrint(jwtkey + (token ?? ''));
    http.Response response = await http.post(Uri.parse(endpointBack + '/api/admin/toolbox/item'), body: data2, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    debugPrint(data2.toString());
    String i = response.body;
    return i;
  }

  //Recibir items para el toolbox
  Future<List<ItemToolbox>> getItemsToolbox(var tokenID, var token) async {
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/users/toolbox/items'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    debugPrint(i.toString());
    var codeList = json.decode(i);
    List<ItemToolbox> items = [];
    for (var a = 0; a < codeList.length; a++) {
      ItemToolbox item = new ItemToolbox();
      debugPrint(".");
      item.idItem = codeList[a]['ID'];
      item.titulo = codeList[a]['Title'];
      item.descripcion = codeList[a]['Description'];
      item.enlace = codeList[a]['URL'];
      item.type = codeList[a]['Type'];
      items.add(item);
    }
    return items;
  }

  //Esta función elimina un item agregado como ejercicio
  //noticia o alimentación
  Future<String> deleteItemToolbox(String index) async {
    String i = " ";
    String? token = await Utils().getToken();
    debugPrint("elimino");
    debugPrint(index.toString());
    final _ = http.delete(Uri.parse(endpointBack + '/api/admin/toolbox/item/$index'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});

    return i;
  }

  //
  Future<String> linkUser(String emailUser, String tokenType, String token) async {
    Map data2 = {'Email': emailUser};
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    String type = "";
    debugPrint("relacionando usuarios");
    debugPrint(emailUser);
    if (tokenType == 'Cuidador') {
      type = "/api/carer/relate";
    } else if (tokenType == 'Doctor') {
      type = "/api/doctor/relate";
    }
    http.Response added = await http.post(Uri.parse(endpointBack + type), body: data2, headers: {HttpHeaders.authorizationHeader: "Bearer " + token});

    return added.body.toString();
  }

  Future<String?> linkUserCarer(String emailUser, var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/carer/patients/unrelated'), headers: {HttpHeaders.authorizationHeader: "Bearer " + (token ?? '')});
    //http.Response response =
    debugPrint(lista.body);
    String i = lista.body;
    String? addedUser;

    var codeList = json.decode(i);
    for (var a = 0; a < codeList.length; a++) {
      if (emailUser == codeList[a]['EMAIL'].toString()) {
        http.Response added = await http.post(Uri.parse(endpointBack + '/api/relate/' + codeList[a]['ID_USER'].toString()), headers: {HttpHeaders.authorizationHeader: "Bearer " + (token ?? '')});
        debugPrint(added.body);
        addedUser = codeList[a]['EMAIL'];
      }
    }
    return addedUser;
  }

  Future<String> getUnrelatedPatients(String token, String type) async {
    if (type == 'Cuidador') {
      type = "/api/carer/patients/unrelated";
    } else if (type == 'Doctor') {
      type = "/api/doctor/patients/unrelated";
    }
    http.Response lista = await http.get(Uri.parse(endpointBack + type), headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
    //http.Response response =
    String i = lista.body;
    var codeList = json.decode(i);
    int contador = 0;
    List<String> patients = [];
    for (var a = 0; a < codeList.length; a++) {
      patients.add(codeList[a]['Email']);
      debugPrint(codeList[a]['Email']);
      contador += 1;
    }
    debugPrint(contador.toString());
    return i;
  }

  Future<String> linkedUser(var token, var tokenType) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    //var codeToken = json.decode(token);
    String type = "";
    if (tokenType == 'Cuidador') {
      type = "/api/carer/patients/related";
    } else if (tokenType == 'Doctor') {
      type = "/api/doctor/patients/related";
    }
    debugPrint(token);
    debugPrint(tokenType);
    http.Response lista = await http.get(Uri.parse(endpointBack + type), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    debugPrint("get related");
    //http.Response response =
    //debugPrint(lista.body);
    debugPrint("returning related");
    String i = lista.body;
    var codeList = json.decode(i);
    List<String> patients = [];
    int contador = 0;
    for (var a = 0; a < codeList.length; a++) {
      patients.add(codeList[a]['Email']);
      debugPrint(codeList[a]['Email']);
      contador += 1;
    }
    debugPrint("returning related");
    debugPrint(contador.toString());
    return i;
  }

  Future<List<String>> linkedUserCarer(var tokenID, var token) async {
    //Map data2 = {'email': authUser.email, 'password': authUser.password};
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/carer/patients/related'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    //http.Response response =
    debugPrint(lista.body);
    String i = lista.body;
    var codeList = json.decode(i);
    List<String> patients = [];
    for (var a = 0; a < codeList.length; a++) {
      patients.add(codeList[a]['EMAIL']);
    }
    return patients;
  }

  Future<String?> unlinkedPatient(String idPatient) async {
    String? i;
    String? token = await Utils().getToken();
    String? tipe = await Utils().getFromToken('type');
    if (tipe == 'Cuidador') {
      final request = http.delete(
        Uri.parse(endpointBack + '/api/carer/patients/$idPatient'),
        headers: {
          HttpHeaders.authorizationHeader: jwtkey + (token ?? ''),
        },
      );
    } else if (tipe == 'Doctor') {
      final request = http.delete(
        Uri.parse(endpointBack + '/api/doctor/patients/$idPatient'),
        headers: {
          HttpHeaders.authorizationHeader: jwtkey + (token ?? ''),
        },
      );
    }
    return i;
  }

  Future<bool> registerSymptomsForm(SymptomsForm form, var tokenID, var token) async {
    bool success = false;

    var video;

    if (form.video != null) {
      String fileName = form.video!.path.split('/').last;
      video = await MultipartFile.fromFile(form.video!.path, filename: fileName);
    } else {
      video = null;
    }

    //http.Response response =
    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'q3': form.q3,
      'q4': form.q4,
      'q5': form.q5,
      /*
      'q6': form.q6,
      'q7': form.q7,
      'q8': form.q8,
      'q9': form.q9,
      'q10': form.q10,
      'q11': form.q11,
      'q12': form.q12,
      'q13': form.q13,
      'q14': form.q14,
      'q15': form.q15,
      'q16': form.q16,
      */
      'date': form.date,
      'video': video,
    };

    FormData formData = new FormData.fromMap(formMap);
    Dio dio = new Dio();
    dio.options.headers["authorization"] = jwtkey + (token ?? '');
    Response response = await dio.post(endpointBack + '/api/users/$tokenID/symptomsForm', data: formData);
    debugPrint("formulario enviado");
    return success;
  }

  Future<bool> registerNoMotorSymptomsForm(NoMotorSymptomsForm form, var tokenID, var token) async {
    bool success = false;

    //http.Response response =
    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'q3': form.q3,
      'q4': form.q4,
      'q5': form.q5,
      'q6': form.q6,
      'q7': form.q7,
      'q8': form.q8,
      'q9': form.q9,
      'q10': form.q10,
      'q11': form.q11,
      'q12': form.q12,
      'q13': form.q13,
      'q14': form.q14,
      'q15': form.q15,
      'q16': form.q16,
      'q17': form.q17,
      'q18': form.q18,
      'q19': form.q19,
      'q20': form.q20,
      'q21': form.q21,
      'q22': form.q22,
      'q23': form.q23,
      'q24': form.q24,
      'q25': form.q25,
      'q26': form.q26,
      'q27': form.q27,
      'q28': form.q28,
      'q29': form.q29,
      'q30': form.q30,
      'date': form.date.toString(),
    };
    var jsonBody = jsonEncode(formMap);
    debugPrint(jsonBody);
    http.Response lista = await http.post(Uri.parse(endpointBack + '/api/patient/$tokenID/noMotorSymptomsFormPatient'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? ''), 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonBody);

    debugPrint(lista.body);
    if (lista.body == "OK") {
      success = true;
    }
    return success;
  }

  Future<bool> registerEmotionalForm(EmotionalForm form, var tokenID, var token) async {
    bool success = false;

    //http.Response response =
    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'date': form.date.toString(),
    };
    var jsonBody = jsonEncode(formMap);
    debugPrint(jsonBody);
    http.Response lista = await http.post(Uri.parse(endpointBack + '/api/patient/$tokenID/emotionalFormPatient'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? ''), 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonBody);

    debugPrint(lista.body);
    if (lista.body == "OK") {
      success = true;
    }
    return success;
  }

  Future<bool> getEmotionsForm(var tokenID, var token, DateTime start, DateTime end) async {
    bool success = false;
    var queryParameters = {
      'start': start.toString(),
      'end': end.toString(),
    };
    debugPrint("bandera");
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/emotionalFormPatient', queryParameters);
    debugPrint("bandera2");
    debugPrint(uri.toString());
    debugPrint("---");
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});

    return success;
  }

//Datos de las gráficas
  Future<String> getAverageSymptoms(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {
      'start': start.toString(),
      'end': end.toString(),
    };
    debugPrint("llega1");
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/symptoms/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getAverageSymptomsAndCheerUp(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {'start': start.toString(), 'end': end.toString(), 'montly': 'true'};
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/symptoms/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getAverageGame(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {'start': start.toString(), 'end': end.toString(), 'montly': 'true'};
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/game/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});

    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getAverageDyskineciasWithoutMonths(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {'start': start.toString(), 'end': end.toString(), 'montly': 'true'};
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/dyskinecia/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getAverageEmotionalSymptoms(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {'start': start.toString(), 'end': end.toString(), 'montly': 'true'};
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/emotionalsymptoms/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getDiscrepancyData(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {'start': start.toString(), 'end': end.toString(), 'montly': 'true'};
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/discrepancy/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getAverageMotorsSymptoms(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {
      'start': start.toString(),
      'end': end.toString(),
    };
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/noMotorSymptoms/report', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  Future<String> getAverageSymptomsByDay(var tokenID, DateTime start, DateTime end) async {
    var token = await Utils().getToken();
    var queryParameters = {
      'start': start.toString(),
      'end': end.toString(),
    };
    var uri = Uri.http(pagePath, '/api/patient/$tokenID/report/daily', queryParameters);
    http.Response lista = await http.get(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    var codeList = json.decode(i);
    debugPrint(i);
    return i;
  }

  //----------------------------------------------

  //Recibir alarmas
  Future<List<AlarmAndMedicine>> getMedicinesAlarms(Object tokenID, String token) async {
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/patient/$tokenID/medicineAlarm'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token)});
    String i = lista.body;
    debugPrint("flag");
    debugPrint(i.toString());
    var codeList = json.decode(i);
    List<AlarmAndMedicine> alarms = [];
    String s;
    final format = DateFormat.jm();
    for (var a = 0; a < codeList.length; a++) {
      AlarmAndMedicine alarm = new AlarmAndMedicine();
      alarm.id = codeList[a]['IdMedicine'];
      alarm.title = codeList[a]['Title'];
      alarm.idMedicine = codeList[a]['Medicine'];
      alarm.dose = codeList[a]['Dose'];
      s = codeList[a]['AlarmTime'];
      alarm.alarmTime = TimeOfDay(hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
      alarms.add(alarm);
    }
    return alarms;
  }

  Future<List<AlarmAndMedicine>> getMedicinesAndAlarms(String idPatient) async {
    var token = await Utils().getToken();
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/patient/$idPatient/medicineAlarm'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    String i = lista.body;
    debugPrint(i.toString());
    var alarmsJSON = json.decode(i);
    List<AlarmAndMedicine> alarms = [];
    for (var medAlarm in alarmsJSON) {
      AlarmAndMedicine alarm = new AlarmAndMedicine();
      //alarm.id = codeList[a]['id'];
      String time = medAlarm['AlarmTime'];
      alarm.title = medAlarm['Title'];
      alarm.idMedicine = medAlarm['IdMedicine'].toString();
      alarm.alarmTime = TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
      alarm.medicine = medAlarm['Medicine'];
      alarm.dose = medAlarm['Dose'];
      alarm.periodicityQuantity = medAlarm['PeriodicityQuantity'];
      alarm.periodicityType = medAlarm['PeriodicityType'];
      alarm.id = medAlarm['IdPatient'];
      alarms.add(alarm);
    }
    return alarms;
  }

  //Enviar alarmas
  Future<String> sendAlarm(String id, String title, String alarmTime, String isPending, var token, var tokenID) async {
    Map data2 = {"id": id, "title": title, "alarmDateTime": alarmTime, "isPending": isPending};
    http.Response response = await http.post(Uri.parse(endpointBack + '/api/patient/$tokenID/medicineAlarm'), body: data2, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    debugPrint(data2.toString());
    String i = response.body;
    return i;
  }

  //Envíar puntaje del juego
  Future<String> sendGameRecord(int stepsQuantity) async {
    var token = await Utils().getToken();
    var tokenID = await Utils().getFromToken('id');
    DateTime recordDate = DateTime.now();
    debugPrint("AQUÍ ESTAMOS");
    debugPrint(tokenID);
    debugPrint(stepsQuantity.toString());
    Map<String, dynamic> data2 = {
      "gameDate": recordDate.toString(),
      "score": stepsQuantity.toString(),
    };

    http.Response response = await http.post(Uri.parse(endpointBack + '/api/patient/$tokenID/newGameScore'), body: data2, headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    return response.body;
  }

  Future<String> deleteAlarm(String id, int tokenID) async {
    //tokenID paciente
    //id index
    String? token = await Utils().getToken();
    print("eliminando medicina id: " + id + " paciente id:" + tokenID.toString());
    http.Response response = await http.post(Uri.parse(endpointBack + '/api/patient/$tokenID/medicineAlarm/delete/$id'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});

    String i = response.body;
    return i;
  }

  Future<List<RelationRequest>> getRelationRequest(var token) async {
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/patient/relationRequest'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    debugPrint(lista.body);
    String i = lista.body;
    var codeList = json.decode(i);
    List<RelationRequest> relations = [];
    for (var a = 0; a < codeList.length; a++) {
      RelationRequest requester = new RelationRequest();
      requester.id = codeList[a]['ID'];
      requester.message = codeList[a]['EMAIL'] + " quiere ser tu " + codeList[a]['TYPE'];
      requester.sender = codeList[a]['TYPE'];
      relations.add(requester);
    }
    return relations;
  }

  Future<String?> registerSymptomsFormPatient(SymptomsFormPatientM form, String tokenID, String token) async {
    bool success = false;
    print(tokenID + 'hol');

    var video;

    if (form.video != null) {
      String fileName = form.video!.path.split('/').last;
      video = await MultipartFile.fromFile(form.video!.path, filename: fileName);
    } else {
      video = null;
    }

    Map<String, dynamic> formMap = {
      'q1': form.q1,
      'q2': form.q2,
      'formDate': form.formDate,
      'discrepancy': form.discrepancy,
      'video': video,
    };

    FormData formData = new FormData.fromMap(formMap);

    Dio dio = new Dio();
    dio.options.headers["authorization"] = jwtkey + token;
    Response response = await dio.post(endpointBack + '/api/users/$tokenID/symptomsFormPatient', data: formData);
    debugPrint(response.statusMessage);
    return response.statusMessage;
  }

  Future<String> getSymptomsFormPatient(var token, var tokenID) async {
    http.Response lista = await http.get(Uri.parse(endpointBack + '/api/patients/$tokenID/symptomsFormPatient'), headers: {HttpHeaders.authorizationHeader: "Bearer " + (token ?? '')});
    debugPrint(lista.body);
    String relationsRequest = lista.body;
    return relationsRequest;
  }

  Future<String> getUserName(var token) async {
    debugPrint("entro");
    http.Response response = await http.get(Uri.parse(endpointBack + getNameUSer), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? '')});
    debugPrint("-----");
    debugPrint(response.body);
    String res = response.body;
    return res;
  }

  Future<File> getPhotoUser(var token, var path) async {
    debugPrint("entro");
    http.Response? response;

    if (path != null) {
      response = await http.get(Uri.parse(endpointBack + "/" + path), headers: {
        HttpHeaders.authorizationHeader: jwtkey + (token ?? ''),
      });
    }

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(p.join(documentDirectory.path, 'imagetest.png'));

    if (path != null && response != null) {
      file.writeAsBytesSync(response.bodyBytes);
    }

    return file;
  }

  Future<File> getVideoUser(var token, var path) async {
    debugPrint("entro");
    http.Response? response;

    if (path != null) {
      response = await http.get(Uri.parse(endpointBack + "/" + path), headers: {
        HttpHeaders.authorizationHeader: jwtkey + (token ?? ''),
      });
    }

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(p.join(documentDirectory.path, 'imagetest.png'));

    if (path != null && response != null) {
      file.writeAsBytesSync(response.bodyBytes);
    }

    return file;
  }

  Future<String> getMedicines(var token) async {
    print(token + 'hey');
    http.Response response = await http.get(Uri.parse(endpointBack + '/api/doctor/medicines'), headers: {HttpHeaders.authorizationHeader: "Bearer " + (token ?? '')});

    String medicines = response.body;
    debugPrint('medicines: $medicines');
    return medicines;
  }

  Future<String> saveAlarmsAndMedicines(AlarmAndMedicine alarmAndMedicine, int idPatient) async {
    print('entra');
    Map<String, dynamic> alarmAndMedicineToSave = {
      'periodicityQuantity': alarmAndMedicine.periodicityQuantity,
      'alarmTime': '${alarmAndMedicine.alarmTime?.hour}:${alarmAndMedicine.alarmTime?.minute}',
      'idMedicine': alarmAndMedicine.idMedicine,
      'dose': alarmAndMedicine.dose,
      'periodicityType': alarmAndMedicine.periodicityType,
    };
    String? token = await Utils().getToken();
    print('entra2');
    print('entra3 ${jsonEncode(alarmAndMedicineToSave).toString()}');
    String idPatientString = idPatient.toString();
    print(' id: $idPatientString');
    http.Response response = await http.post(Uri.parse('$endpointBack/api/doctor/medicine/$idPatientString'), headers: {HttpHeaders.authorizationHeader: jwtkey + (token ?? ''), 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonEncode(alarmAndMedicineToSave));
    debugPrint(alarmAndMedicineToSave.toString());
    print('response ${response.body}');
    String responseBody = response.body;
    return responseBody;
  }

  Future<String> passwordRecover(String email) async {
    Map data2 = {
      'Email': email,
    };
    //debugPrint(data2.toString());
    //debugPrint(endpointBack + addUserUrl);
    http.Response response = await http.post(Uri.parse(endpointBack + '/api/user/forgotPassword'), body: data2);

    debugPrint(response.body + 'hola');
    String i = response.body;
    return i;
  }

  Future<String?> newPasswordRecover(String email, String password, int otp) async {
    print(otp);
    Map<String, dynamic> data2 = {'Email': email, 'Password': password, 'OTP': otp};
    //debugPrint(data2.toString());
    //debugPrint(endpointBack + addUserUrl);
    //
    FormData formData = new FormData.fromMap(data2);
    Dio dio = new Dio();

    dio.options.headers['content-Type'] = 'application/json';

    Response response = await dio.post(endpointBack + '/api/user/reset_password', data: jsonEncode(data2));
    debugPrint(response.statusMessage);
    return response.statusMessage;
  }

  Future<String> deleteSymtomsPatientForm(String? date, String token, String tokenId) async {
    print(date);
    print(token);
    print(tokenId);
    var data2 = {
      'Date': date,
    };
    //debugPrint(data2.toString());
    //debugPrint(endpointBack + addUserUrl);
    //
    FormData formData = new FormData.fromMap(data2);
    Dio dio = new Dio();

    debugPrint("bandera");
    var uri = Uri.http(pagePath, '/api/users/$tokenId/symptomsFormPatient', data2);

    http.Response response = await http.delete(uri, headers: {HttpHeaders.authorizationHeader: jwtkey + (token)});

    //dio.options.headers['content-Type'] = 'application/json';

    debugPrint(response.body);
    return response.body;
  }
}
