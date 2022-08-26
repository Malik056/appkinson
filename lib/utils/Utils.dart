// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appkinson/constants/constant.dart';

const TOKEN_KEY = 'token';
const TOKEN_TASK = 'backgroundtask';

class Utils {
  Map tokenDecoder(String token) {
    debugPrint('bruh');

    var lista = token.split(".");
    var payload = lista[1];

    switch (payload.length % 4) {
      case 1:
        break;
      case 2:
        payload = payload + "==";
        break;
      case 3:
        payload = payload + "=";
        break;
    }

    var decode = utf8.decode(base64.decode(payload));
    debugPrint(decode);

    return json.decode(decode);
  }

  Future<void> saveToken(String token) async {
    print('token to save: $token');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN_KEY, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN_KEY)) {
      return prefs.getString(TOKEN_KEY);
    }
    return null;
  }

  Future<String?> getFromToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN_KEY)) {
      String? token = prefs.getString(TOKEN_KEY);
      if (token == null) {
        //TODO: Handle null (TAHA)
        return null;
      }
      Map tokenDecoded = this.tokenDecoder(token);
      return tokenDecoded[key].toString();
    }
    return null;
  }

  Future<void> setBackgroundTask() async {
    print('save task was set');
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(TOKEN_TASK, true);

    /**------------- */
  }

  Future<void> removeBackgroundTask() async {
    print('unset task');
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN_TASK);
    prefs.remove(TOKEN_KEY);
    workmanager.cancelAll();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN_KEY);
  }

  Future<bool> isSetBackgroundTask() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(TOKEN_TASK)) {
      return prefs.getBool(TOKEN_TASK) ?? false;
    } else {
      return false;
    }
  }

  Future<void> initWorkmanager() async {
    workmanager.initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
  }

  Future<void> setTaskGetAlarms() async {
    print('setting alarms task');
    DateTime before = DateTime.now();
    DateTime after;
    print('Hour: ${before.hour}');
    if (before.hour < 18) {
      after = new DateTime(before.year, before.month, before.day, 17, 22);
    } else {
      after = new DateTime(before.year, before.month, before.day + 1, 10);
    }
    print('minutes: ${after.difference(before).inMinutes.toString()}');
    workmanager.registerPeriodicTask(
      TASK_SET_ALARMS,
      TASK_SET_ALARMS,
      initialDelay: Duration(seconds: 10), //minutes: after.difference(before).inMinutes),
      frequency: Duration(days: 1),
    );
    await setBackgroundTask();
  }
}
