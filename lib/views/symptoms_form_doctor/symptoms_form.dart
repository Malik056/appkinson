import 'dart:io';
import 'package:appkinson/constants/globals.dart';

import '../symptoms_form_doctor/video_plugin.dart';
import 'package:flutter/material.dart';

class SymptomsForm extends StatefulWidget {
  @override
  _SymptomsForm createState() => _SymptomsForm();
}

class _SymptomsForm extends State<SymptomsForm> {
  File? fileMedia;
  MediaSource? source;
  int selectedStateRadio = 0;
  int selectedDyskinesiaRadio = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Registro de síntomas'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("¿Cuál es tu estado actual?"),
                RadioListTile(
                  value: 1,
                  groupValue: selectedStateRadio,
                  title: Text("ON"),
                  onChanged: onChangedStateValue,
                ),
                RadioListTile(
                  value: 2,
                  groupValue: selectedStateRadio,
                  title: Text("OFF"),
                  onChanged: onChangedStateValue,
                ),
                Divider(
                  height: 20,
                ),
                Text("¿Presentó alguna disquinesia?"),
                RadioListTile(
                  value: 3,
                  groupValue: selectedDyskinesiaRadio,
                  title: Text("Sí"),
                  onChanged: onChangedDyskinesiaValue,
                ),
                RadioListTile(
                  value: 4,
                  groupValue: selectedDyskinesiaRadio,
                  title: Text("No"),
                  onChanged: onChangedDyskinesiaValue,
                ),
                Expanded(
                  child: fileMedia == null ? Icon(Icons.play_circle_outline, size: 120) : (source == MediaSource.image ? Image.file(fileMedia!) : VideoWidget(fileMedia!)),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  child: Text('Capturar video'),
                  style: buildButtonStyle(
                    border: StadiumBorder(),
                    background: Theme.of(context).primaryColor,
                    forground: Colors.white,
                  ),
                  onPressed: () => capture(MediaSource.video),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Eliminar video'),
                  style: buildButtonStyle(
                    border: StadiumBorder(),
                    background: Theme.of(context).primaryColor,
                    forground: Colors.white,
                  ),
                  onPressed: () => delete(),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Guardar registro'),
                  style: buildButtonStyle(
                    border: StadiumBorder(),
                    background: Theme.of(context).primaryColor,
                    forground: Colors.white,
                  ),
                  //onPressed: () => save(),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }

  Future delete() async {
    setState(() {
      this.fileMedia = null;
    });
  }

  Future save() async {}

  void onChangedStateValue(int? value) {
    setState(() {
      selectedStateRadio = value ?? selectedStateRadio;
    });
  }

  void onChangedDyskinesiaValue(int? value) {
    setState(() {
      selectedDyskinesiaRadio = value ?? selectedDyskinesiaRadio;
    });
  }
}
