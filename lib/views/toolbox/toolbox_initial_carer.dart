
import 'package:appkinson/views/toolbox/about_excercises/buttons/button_go_about_excercises.dart';
import 'package:appkinson/views/toolbox/about_food/buttons/button_go_about_food.dart';
import 'package:appkinson/views/toolbox/about_news/buttons/button_go_about_news.dart';
import 'package:appkinson/views/toolbox/about_parkinson/buttons/button_go_about_parkinson.dart';
//import 'package:appkinson/views/Toolbox/about_excercises/buttons/button_go_about_excercises.dart';
//import 'package:appkinson/views/Toolbox/about_food/buttons/button_go_about_food.dart';
//import 'package:appkinson/views/Toolbox/about_news/buttons/button_go_about_news.dart';
//import 'package:appkinson/views/Toolbox/about_parkinson/buttons/button_go_about_parkinson.dart';
//import 'package:appkinson/views/Toolbox/pedometer/buttons/button_go_pedometer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:pedometer/pedometer.dart';


class ToolboxCuidador extends StatefulWidget {
  @override
  _ToolboxCuidador0 createState() => _ToolboxCuidador0();
}

String? tipe;

class _ToolboxCuidador0 extends State<ToolboxCuidador> {
  // double percent=0.1;

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
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
                    Expanded(
                      child: ButtonGoAboutParkinson(),
                    ),
                    Expanded(
                      child: ButtonGoAboutNews(),
                    ),
                  ],
                ),
              ],
            ),
            //  ),
          ),
        ],
      ),
    );
  }
}
