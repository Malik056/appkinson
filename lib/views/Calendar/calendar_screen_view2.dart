// ignore_for_file: unused_element, unused_local_variable

import 'dart:convert';

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/model/symptoms_form_patient_m.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient_q5_on.dart';
import 'package:appkinson/views/video_screen/video_screen_carer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

DateTime? dateChoosed;
int count = 0;

class CalendarScreenView2 extends StatefulWidget {
  @override
  _CalendarScreenView2 createState() => _CalendarScreenView2();
}

/*class _CalendarScreenView2 extends State<CalendarScreenView2> {
  FSBStatus status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(
            status: status,
            drawer: CustomDrawerMenu(),
            screenContents: CalendarScreenView2aux()),
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
            }),
      ),
    );
  }
}*/

/*class _CalendarScreenView2 extends State<CalendarScreenView2> {
  @override
  _Calendar createState() => _Calendar();
}*/

TextEditingController _disqui = TextEditingController();
String state = 'on';
var color = Colors.green;
//File fileMedia;

List<Meeting> meetingPatient = <Meeting>[];
String? listPacientes;
var conta = 0;
int hora = 0;
var cont = 0;

String? q2;
String? q1;
String? datePatient;
int? desface;
String? idCurrent;
bool isLoading = false;

DateTime? deleteTime;

List<Color> _colors = <Color>[Colors.green, Colors.green[700]!, Colors.red, Colors.red[800]!];
var contCalendar = 0;

List<String> _onOff = <String>['ON Bueno', 'ON Muy Bueno', 'OFF Malo', 'OFF Muy Malo'];
List<dynamic> _icon = <dynamic>[Icons.calendar_view_day, Icons.calendar_today_rounded];
var currentMeeting;

class _CalendarScreenView2 extends State<CalendarScreenView2> {
  var valueHour = '0';
  void _incrementColorIndex() {
    setState(() {
      print(cont);
      if (cont < _colors.length - 1) {
        cont++;
      } else {
        cont = 0;
      }
    });
  }

  void _incrementCalendar() {
    setState(() {
      print(cont);
      if (cont < _icon.length - 1) {
        cont++;
      } else {
        cont = 0;
      }
    });
  }

  Widget buildLoading() {
    return AlertDialog(
      title: Text("Subiendo Registro "),
      content: Form(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        new CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[200]!),
        ),
      ])),
    );
  }

  CalendarController? _controller;
  var iconCalendar;
  @override
  void initState() {
    super.initState();
    currentMeeting = null;
    valueHour = '0';
    _controller = CalendarController();
    _controller?.view = CalendarView.week;
    iconCalendar = Icons.calendar_today_rounded;
    contCalendar = 0;
    //todos.add("Regular Colors");
    //todos.add("Power Coating");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            new IconButton(
                icon: Icon(_icon[contCalendar]),
                color: Colors.black45,
                onPressed: () {
                  setState(() {
                    print('ey');
                    if (contCalendar == 0) {
                      _controller?.view = CalendarView.day;
                      contCalendar = 1;
                    } else {
                      _controller?.view = CalendarView.week;
                      contCalendar = 0;
                    }
                  });
                }),
          ],
          iconTheme: IconThemeData(color: Colors.grey),
          title: Text('Calendario', style: TextStyle(color: Colors.grey[900], fontSize: 20, fontFamily: "Raleway2")),
          backgroundColor: Colors.white,
        ),
        body: SfCalendar(
          controller: _controller,
          //view: _controller.view,
          showNavigationArrow: true,
          headerHeight: 50,
          onTap: (calendarTapDetails) {
            _disqui = TextEditingController();
            fileMedia = null;
            var sizeAppo = calendarTapDetails.appointments;
            print(sizeAppo.toString() + 'hola6');
            Meeting calen;
            String? r;
            String? dateNoZ;
            String? pathVideo;
            if (sizeAppo.toString() != 'null') {
              calen = calendarTapDetails.appointments![0];
              r = calen.from.toString() + 'Z';
              dateNoZ = calen.from.toString();
            }

            //print(calen.from);
            dateChoosed = calendarTapDetails.date;
            if (dateChoosed == null) {
              //TODO: Properly handle null (TAHA)
              return;
            }
            //var calen = calendarTapDetails.targetElement;
            //print(calen.index);
            //int horaPrueba = calen.index;
            //print(horaPrueba.toString());

            final DateTime probTime = DateTime(dateChoosed!.year, dateChoosed!.month, dateChoosed!.day, 0, 0, 0);
            var convertedList = json.decode(listPacientes!);
            for (var a = 0; a < convertedList.length; a++) {
              DateTime dateBd = DateTime.parse(convertedList[a]['formdate']);
              print(dateBd.toString() + 'hola');
              print(probTime.toString() + 'hola2');
              idCurrent = convertedList[a]['ID_PATIENT'].toString();
              //print();

              print(r);
              if (dateBd.toString() == r) {
                currentMeeting = convertedList[a];
                print(currentMeeting.toString());
                q2 = currentMeeting['Q2'];
                q1 = currentMeeting['Q1'];
                desface = currentMeeting['discrepancy'];
                datePatient = dateNoZ;
                deleteTime = dateBd;
                pathVideo = currentMeeting['pathvideo'].toString() + '.mp4';
                idCurrent = currentMeeting['ID_PATIENT'].toString();
              }
            }

            if (currentMeeting != null) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      currentMeeting = null;
                      return AlertDialog(
                        title: Text(
                          "Detalles",
                          textAlign: TextAlign.center,
                        ),
                        content: Form(
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Row(
                            children: [
                              Text('Disquinesias:', style: TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.help_outlined, color: Colors.grey[500]),
                                tooltip: 'Son trastornos del movimiento que se caracterizan por un exceso de movimientos o por movimientos anormales e involuntarios',
                              )
                            ],
                          ),
                          Text(q2!),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Text('Desfase:', style: TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.help_outlined, color: Colors.grey[500]),
                                tooltip: 'Esta opci??n es para escoger cu??nto tiempo despu??s de la hora indicada se tom?? el medicamento. Si fue a la hora establecida, puede continuar sin escoger nada.',
                              ),
                            ],
                          ),
                          Text(desface.toString() + ' minutos de desfase en la toma de medicamento'),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            style: buildButtonStyle(
                              border: roundedRadius18,
                              background: Colors.blue[500],
                              horiztonalPadding: 30,
                              forground: Colors.white,
                            ),
                            //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                            //onPressed: _incrementColorIndex,
                            onPressed: () async {
                              String? token = await Utils().getToken();
                              var video = await EndPoints().getVideoUser(token, pathVideo);
                              this.setState(() {
                                fileMediaCarer = video;
                              });
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => VideoScreenCarer()));
                            },
                            child: Text('Ver Video'),
                            /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                            // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                          ),
                        ])),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () async {
                                int disMinutes = int.parse(this.valueHour);
                                SymptomsFormPatientM patientForm = new SymptomsFormPatientM();

                                patientForm.q1 = _onOff[cont];
                                patientForm.q2 = _disqui.text;
                                //patientForm.q3 = BringAnswer2Off().send();
                                //patientForm.q4 = BringAnswerPatientQ3().send();
                                //patientForm.q5 = BringAnswerPatientQ4().send();
                                patientForm.video = fileMedia;
                                patientForm.discrepancy = disMinutes;
                                patientForm.formDate = dateChoosed;

                                debugPrint('envia');
                                String? token = await Utils().getToken();
                                String? id = await Utils().getFromToken('id');
                                debugPrint('id');
                                print('token');
                                if (token == null || id == null) {
                                  //TODO: Check for null (TAHA)
                                  return;
                                }
                                var savedDone = await EndPoints().deleteSymtomsPatientForm(datePatient, token, id);

                                // debugPrint(savedDone.toString());

                                int hora = deleteTime!.hour;

                                final DateTime startTime = DateTime(deleteTime!.year, deleteTime!.month, deleteTime!.day, hora, 0, 0);
                                print(startTime.toString() + 'startime');
                                final DateTime endTime = startTime.add(const Duration(hours: 1));
                                Meeting m = new Meeting(_onOff[cont], startTime, endTime, _colors[cont], false);
                                debugPrint(m.eventName);
                                // print(meetingPatient.);
                                //setState(() {
                                this.setState(() {
                                  meetingPatient.removeWhere((item) => item.from == startTime);
                                  //isLoading = false;
                                });

                                Navigator.pop(context);
                              },
                              child: Icon(Icons.delete)),
                        ],
                      );
                    });
                  });
              currentMeeting = null;
            } else {
              //poner el servicio de leyder
              //var obtainHour;
              //
              int hora = dateChoosed!.hour;
              final DateTime startTimeBefore = DateTime(dateChoosed!.year, dateChoosed!.month, dateChoosed!.day, hora, 0, 0);

              // ignore: dead_code
              if (false) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        currentMeeting = null;
                        return AlertDialog(
                          title: Text(""),
                          content: Form(
                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                            TextButton(
                              style: buildButtonStyle(
                                border: roundedRadius18,
                                background: _colors[cont],
                                horiztonalPadding: 30,
                                forground: Colors.white,
                              ),
                              //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                              //onPressed: _incrementColorIndex,
                              onPressed: () {
                                setState(() {
                                  _incrementColorIndex();
                                });
                              },
                              //textColor: Colors.white,
                              child: Text(_onOff[cont]),
                              /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                              // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                            ),
                            Divider(thickness: 1),
                            Row(
                              children: [
                                Text('Disquinesias:', style: TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.help_outlined, color: Colors.grey[500]),
                                  tooltip: 'Son trastornos del movimiento que se caracterizan por un exceso de movimientos o por movimientos anormales e involuntarios',
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: _disqui,
                              validator: (value) {
                                return value!.isNotEmpty ? null : "Invalido";
                              },
                              decoration: InputDecoration(hintText: "Ej:'Movimento anormal en la mano'"),
                            ),
                            Divider(thickness: 1),
                            TextButton(
                              style: buildButtonStyle(
                                border: roundedRadius18,
                                background: Colors.teal[200],
                                horiztonalPadding: 30,
                              ),
                              //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                              //onPressed: _incrementColorIndex,
                              onPressed: () {
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => SymptomsFormPatientQ5ON()));
                              },
                              //textColor: Colors.white,
                              child: Text('Hacer Video(Opcional)'),
                              /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                              // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                            ),
                          ])),
                          actions: <Widget>[
                            !isLoading
                                ? TextButton(
                                    onPressed: () async {
                                      int disMinutes = int.parse(this.valueHour);
                                      SymptomsFormPatientM patientForm = new SymptomsFormPatientM();

                                      patientForm.q1 = _onOff[cont];
                                      patientForm.q2 = _disqui.text;
                                      //patientForm.q3 = BringAnswer2Off().send();
                                      //patientForm.q4 = BringAnswerPatientQ3().send();
                                      //patientForm.q5 = BringAnswerPatientQ4().send();
                                      patientForm.video = fileMedia;
                                      patientForm.formDate = dateChoosed;
                                      patientForm.discrepancy = disMinutes;

                                      debugPrint('envia');

                                      setState(() {
                                        isLoading = true;
                                      });

                                      String? token = await Utils().getToken();
                                      String? id = await Utils().getFromToken('id');
                                      /* var savedDone = await EndPoints()
                                      .registerSymptomsFormPatient(
                                          patientForm, id, token);*/

                                      int hora = dateChoosed!.hour;

                                      final DateTime startTime = DateTime(dateChoosed!.year, dateChoosed!.month, dateChoosed!.day, hora, 0, 0);
                                      print(startTime.toString() + 'startime');
                                      final DateTime endTime = startTime.add(const Duration(hours: 1));
                                      Meeting m = new Meeting(_onOff[cont], startTime, endTime, _colors[cont], false);
                                      debugPrint(m.eventName);
                                      //setState(() {

                                      // debugPrint(savedDone.toString());

                                      this.setState(() {
                                        meetingPatient.add(m);
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("a??adir"))
                                : Center(child: buildLoading())
                          ],
                        );
                      });
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        currentMeeting = null;
                        return AlertDialog(
                          title: Text(""),
                          content: Form(
                              child: SingleChildScrollView(
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                              Row(
                                children: [
                                  Text('Estado:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.live_help_outlined, color: Colors.grey[500]),
                                    tooltip: 'Son cambios del estado del paciente a lo largo del d??a. En fase o periodo ON hay un control satisfactorio de los s??ntomas y es posible una actividad motora normal. En cambio, en las fases OFF reaparecen los s??ntomas con una funci??n motora alterada.',
                                  ),
                                ],
                              ),
                              TextButton(
                                style: buildButtonStyle(
                                  border: roundedRadius18,
                                  background: _colors[cont],
                                  forground: Colors.white,
                                  height: 35,
                                  minWidth: 220,
                                ),
                                //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                                //padding: EdgeInsets.symmetric(horizontal: 70),
                                //onPressed: _incrementColorIndex,
                                onPressed: () {
                                  setState(() {
                                    _incrementColorIndex();
                                  });
                                },
                                child: Text(_onOff[cont]),
                                /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                                // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                              ),
                              Divider(thickness: 1),
                              Row(
                                children: [
                                  Text('Disquinesias:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.live_help_outlined, color: Colors.grey[500]),
                                    tooltip: 'son trastornos del movimiento que se caracterizan por un exceso de movimientos o por movimientos anormales e involuntarios',
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _disqui,
                                validator: (value) {
                                  return value!.isNotEmpty ? null : "Invalido";
                                },
                                decoration: InputDecoration(hintText: "Ej:'movimento anormal en la mano'"),
                              ),
                              Divider(thickness: 1),
                              TextButton(
                                style: buildButtonStyle(
                                  border: roundedRadius18,
                                  background: Colors.blue[500],
                                  forground: Colors.white,
                                  minWidth: 220,
                                ),
                                //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                                //padding: EdgeInsets.symmetric(horizontal: 30),
                                //onPressed: _incrementColorIndex,
                                onPressed: () {
                                  Navigator.push(context, new MaterialPageRoute(builder: (context) => SymptomsFormPatientQ5ON()));
                                },
                                child: Text('Hacer Video (Opcional)'),
                              ),
                              Divider(thickness: 1),
                              Row(children: [
                                SizedBox(
                                  width: 11,
                                ),
                                TextButton(
                                  style: buildButtonStyle(
                                    border: roundedRadius18,
                                    background: Colors.blue[500],
                                    forground: Colors.white,
                                    minWidth: 225,
                                  ),
                                  //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),

                                  //padding: EdgeInsets.symmetric(horizontal: 30),
                                  //onPressed: _incrementColorIndex,
                                  onPressed: () {
                                    valueHour = '0';
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(builder: (context, setState) {
                                            currentMeeting = null;
                                            return AlertDialog(
                                                title: Text("??Hace cu??nto tiempo se tom?? la ??ltima dosis del medicamento (levodopa)?"),
                                                content: Container(
                                                    height: 350.0,
                                                    width: 350.0,
                                                    child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                                                      Expanded(
                                                        child: CupertinoTimerPicker(
                                                          // initialTimerDuration: ,
                                                          mode: CupertinoTimerPickerMode.hm,
                                                          onTimerDurationChanged: (value) {
                                                            setState(() {
                                                              this.valueHour = value.inMinutes.toString();
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      TextButton(
                                                        style: buildButtonStyle(
                                                          border: roundedRadius18,
                                                          background: Colors.blue[500],
                                                          horiztonalPadding: 30,
                                                          forground: Colors.white,
                                                        ),
                                                        //   side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                                                        //onPressed: _incrementColorIndex,
                                                        onPressed: () {
                                                          print(this.valueHour);
                                                          RoutesGeneral().toPop(context);
                                                        },
                                                        child: Text('Listo'),
                                                      ),
                                                    ])));
                                          });
                                        });
                                  },
                                  child: Text('        Toma de Levodopa       '),
                                  /*() => {
                        //print(cont);
                        _incrementColorIndex()
                      },*/
                                  // Text("Registrarse ", style:  TextStyle(fontSize: 15)),
                                ),
                              ]),
                              /*IconButton(
                                      icon: Icon(Icons.help_outlined,
                                          color: Colors.grey[500]),
                                      tooltip:
                                          'Esta opci??n es para escoger cu??nto tiempo depu??s de la hora indicada se tom?? el medicamento. Si fue a la hora establecida, puede continuar sin escoger nada.')*/
                            ]),
                          )),
                          actions: <Widget>[
                            !isLoading
                                ? TextButton(
                                    onPressed: () async {
                                      int disMinutes = int.parse(this.valueHour);
                                      SymptomsFormPatientM patientForm = new SymptomsFormPatientM();

                                      patientForm.q1 = _onOff[cont];
                                      patientForm.q2 = _disqui.text;
                                      //patientForm.q3 = BringAnswer2Off().send();
                                      //patientForm.q4 = BringAnswerPatientQ3().send();
                                      //patientForm.q5 = BringAnswerPatientQ4().send();
                                      patientForm.video = fileMedia;
                                      patientForm.formDate = dateChoosed;
                                      patientForm.discrepancy = disMinutes;

                                      debugPrint('envia');

                                      setState(() {
                                        isLoading = true;
                                      });

                                      String? token = await Utils().getToken();
                                      String? id = await Utils().getFromToken('id');
                                      if (token == null || id == null) {
                                        //TODO: Check for null (TAHA)
                                        return;
                                      }
                                      var savedDone = await EndPoints().registerSymptomsFormPatient(patientForm, id, token);

                                      int hora = dateChoosed!.hour;

                                      final DateTime startTime = DateTime(dateChoosed!.year, dateChoosed!.month, dateChoosed!.day, hora, 0, 0);
                                      print(startTime.toString() + 'startime');
                                      final DateTime endTime = startTime.add(const Duration(hours: 1));
                                      Meeting m = new Meeting(_onOff[cont], startTime, endTime, _colors[cont], false);
                                      debugPrint(m.eventName);
                                      //setState(() {

                                      debugPrint(savedDone.toString());

                                      this.setState(() {
                                        meetingPatient.add(m);
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("A??adir"))
                                : Center(child: buildLoading())
                          ],
                        );
                      });
                    });
              }
            }
            //dateChoosed = calendarTapDetails.date;

            //meetings = _getDataSource();
            setState(() {
              if (conta == 8) {
                conta = 0;
              }
              conta++;
            });
          },
          dataSource: MeetingDataSource(meetingPatient),
          monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }

  List<Meeting> _getDataSource() {
    meetingPatient = <Meeting>[];

    if (dateChoosed?.hour != null) {
      hora = dateChoosed!.hour;
    } else {
      //TODO: Properly handle null (TAHA)
      return [];
    }

    print(conta);
    final DateTime startTime = DateTime(dateChoosed!.year, dateChoosed!.month, dateChoosed!.day, hora, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 1));

    if (conta == 1) {
      meetingPatient.add(Meeting('on', startTime, endTime, const Color(0xFF0F8644), false));
    }
    if (conta == 3) {
      meetingPatient.add(Meeting('on Bueno', startTime, endTime, Colors.green[900]!, false));
    }
    if (conta == 5) {
      meetingPatient.add(Meeting('off', startTime, endTime, Colors.red[400]!, false));
    }
    if (conta == 7) {
      meetingPatient.add(Meeting('off Malo', startTime, endTime, Colors.red[900]!, false));
    }

    return meetingPatient;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
