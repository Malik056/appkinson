// ignore_for_file: unused_field

import 'dart:math';

import 'package:appkinson/views/toolbox/about_excercises/buttons/button_go_about_excercises.dart';
import 'package:appkinson/views/toolbox/about_food/buttons/button_go_about_food.dart';
import 'package:appkinson/views/toolbox/about_news/buttons/button_go_about_news.dart';
import 'package:appkinson/views/toolbox/about_parkinson/buttons/button_go_about_parkinson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
//import 'package:pedometer/pedometer.dart';

import 'buttons/ButtonGoGame.dart';

class Toolbox extends StatefulWidget {
  @override
  _Toolbox0 createState() => _Toolbox0();
}

bool show;

class _Toolbox0 extends State<Toolbox> {
  String muestrePasos = "0";
  String _km = "0";
  String _calories = "0";

  String _stepCountValue = '0';
  StreamSubscription<int> _subscription;

  double numeroPasos;
  double _convert;
  double _kmx;
  double burnedx;
  double _porciento;
  // double percent=0.1;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    // setUpPedometer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription?.cancel();
  }

  /*void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }*/

  // ignore: unused_element
  void _onData(int stepCountValue) async {
    // print(stepCountValue);
    setState(() {
      _stepCountValue = "$stepCountValue";
      // print(_stepCountValue);
    });

    var dist = stepCountValue;
    double y = (dist + .0);

    setState(() {
      numeroPasos = y;
    });

    var long3 = (numeroPasos);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(numeroPasos);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  // ignore: unused_element
  void _onDone() {}

  // ignore: unused_element
  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  void getDistanceRun(double numeroPasos) {
    var distance = ((numeroPasos * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2));
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

  @override
  Widget build(BuildContext context) {
    getBurnedRun();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades y juego'),
      ),
      body: ListView(
        padding: EdgeInsets.all(2.0),
        children: <Widget>[
          new Container(
            width: 80,
            height: 750,
            // child: Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ButtonGoAboutExcercises(),
                    ),
                    Expanded(
                      child: ButtonGoAboutFood(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /*Expanded(
                                child: ButtonGoAboutParkinson(),
                              ),*/
                    Visibility(
                      child: Expanded(
                        child: ButtonGoGame(),
                      ),
                      visible: show,
                    ),
                    Expanded(
                      child: ButtonGoAboutNews(),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /* Expanded(
                          child: ButtonGoPedometer(),
                        ),*/
                      Expanded(
                        child: ButtonGoAboutParkinson(),
                      ),
                    ]),
              ],
            ),
            // ),
          ),
        ],
      ),
    );
  }
}
