// ignore_for_file: unused_field, unused_element

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/routes/routes_patient.dart';

import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime? tempDate;
TimeOfDay _time = TimeOfDay.now();

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();

  // CalendarController? _calendarController;
  Map<DateTime, List<dynamic>> _events = {};

  List<dynamic> _selectedEvents = [];

  void initState() {
    super.initState();

    // _calendarController = CalendarController();
  }

  void dispose() {
    // _calendarController?.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  Widget relojito(Size size, BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 90),
      child: TextButton(
        style: buildButtonStyle(
          border: roundedRadius25,
          background: Colors.grey[200],
          horiztonalPadding: 10,
        ),
        onPressed: () async {
          _time = await showTimePicker(context: context, initialTime: _time) ?? _time;
          debugPrint(_time.toString());
        },
        //textColor: Colors.white,
        child: Text(
          "¡Escoge la hora!",
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget calendar() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), gradient: LinearGradient(colors: [Colors.blue[800]!, Colors.blue[800]!]), boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 5, offset: new Offset(0.0, 5))]),
        child: TableCalendar(
          firstDay: DateTime(0),
          lastDay: DateTime.now().add(Duration(days: 365 * 200)),
          focusedDay: DateTime.now(),
          calendarStyle: CalendarStyle(
            canMarkersOverflow: true,
            // canEventMarkersOverflow: true,
            rangeHighlightColor: Colors.white,
            markerDecoration: BoxDecoration(color: Colors.white),
            // markersColor: Colors.white,
            defaultTextStyle: TextStyle(color: Colors.white),
            // weekdayStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(color: Colors.white54),
            // todayColor: Colors.white54,
            todayTextStyle: TextStyle(color: Colors.indigo[400], fontSize: 15, fontWeight: FontWeight.bold),
            // todayStyle: TextStyle(color: Colors.indigo[400], fontSize: 15, fontWeight: FontWeight.bold),
            selectedDecoration: BoxDecoration(color: Colors.indigo[700]),
            // selectedColor: Colors.indigo[700],
            // outsideWeekendStyle: TextStyle(color: Colors.white60),
            outsideTextStyle: TextStyle(color: Colors.white60),
            // outsideStyle: TextStyle(color: Colors.white60),
            weekendTextStyle: TextStyle(color: Colors.white),
            // weekendStyle: TextStyle(color: Colors.white),
            // renderDaysOfWeek: false,
          ),
          daysOfWeekVisible: true,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
          ),
          
          // calendarController: _calendarController,
          // events: _events,
          eventLoader: (date) {
            return _events[date] ?? [];
          },
          onDaySelected: (selected, focused) {
            _selectedDay = selected;
          },
          
          headerStyle: HeaderStyle(
            leftChevronIcon: Icon(Icons.arrow_back_ios, size: 15, color: Colors.white),
            rightChevronIcon: Icon(Icons.arrow_forward_ios, size: 15, color: Colors.white),
            titleTextStyle: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
            formatButtonDecoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(20),
            ),
            formatButtonTextStyle: GoogleFonts.montserrat(color: Colors.indigo[400], fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          LineAwesomeIcons.arrow_left,
                          color: Colors.indigo,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                  onPressed: () async {
                    RoutesGeneral().toPop(context);
                  },
                  // padding: EdgeInsets.all(1),
                  style: buildButtonStyle(
                    border: CircleBorder(),
                    background: Colors.white,
                  ),
                ),
                Text(
                  "Calendario",
                  style: TextStyle(color: Colors.indigo, fontSize: 25, fontFamily: "Raleway2"),
                ),
              ],
            ),
          ),
          calendar(),
          SizedBox(height: 60),
          relojito(size, context),
          SizedBox(height: 60)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          DateTime onlyDate = new DateFormat("yyyy-MM-dd").parse(_selectedDay.toString());

          String date = onlyDate.year.toString() + "-" + onlyDate.month.toString() + "-" + onlyDate.day.toString() + " " + _time.hour.toString() + ":" + _time.minute.toString() + ":00";
          tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
          debugPrint(_selectedDay.toString());
          debugPrint(tempDate.toString());

          RoutesPatient().toSymptomsFormPatient(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
