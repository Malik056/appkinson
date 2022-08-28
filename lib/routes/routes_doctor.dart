import 'package:appkinson/views/calendar/calendar_screen_view2_doctor.dart';
import 'package:appkinson/views/alarms_and_medicine/alarm_and_medicine_page.dart';
import 'package:appkinson/views/home_different_users/doctor/doctor_home_page.dart';
import 'package:appkinson/views/relations/doctor_patient_add.dart';
import 'package:appkinson/views/relations/doctor_patients.dart';
import 'package:appkinson/views/relations/interaction_doctor_patient.dart';
import 'package:appkinson/views/report/Widget_Chart_Line.dart';
import 'package:appkinson/views/report/Widget_Chart_Pie.dart';
import 'package:appkinson/views/report/list_reports.dart';
import 'package:appkinson/views/report/report_config.dart';
import 'package:appkinson/views/report/Widget_Chart_Serie.dart';
import 'package:appkinson/views/profiles/doctor/doctor_profile.dart';
import 'package:appkinson/views/profiles/doctor/profile_edition/profile_edition_doctor.dart';
import 'package:flutter/material.dart';

class RoutesDoctor {
  //ruta hacia el home de un doctor
  Future<T?> toDoctorHome<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => DoctorHomePage()));
  }

  //ruta para la visualización de un calendario desde el perfil de un doctor
  Future<T?> toCalendarDoctor<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => CalendarScreenView2Doctor()));
  }

//ruta hacia la configuración para el intervalo de creación de las gráficas
  Future<T?> toReportConfigPage<T>(BuildContext context, int? idPatient) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => ReportConfigPage(
                  idPatient: idPatient,
                )));
  }

//ruta para agregar un nuevo paciente
  Future<T?> toAddUser<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => DoctorPatientsAdd()));
  }

  Future<T?> voidtoReportPage<T>(BuildContext context) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => WidgetChartPie(
                  descripcion: '',
                  tituloGrafica: '',
                  id: '',
                  dataPie: [],
                )));
  }

//ruta para ir a la lista de los reportes posibles a generar
  Future<T?> toListReportPage<T>(BuildContext context, int? idPatient, List<DateTime> picked) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute(
            builder: (context) => ListReportPage(
                  idPatient: idPatient,
                  picked: picked,
                )));
  }

//ruta intermedia desde un doctor hacia un paciente
  Future<T?> toInteractionDoctorPatient<T>(BuildContext context, int idPatient) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => InteractionDoctorPatient(
                  idPatient: idPatient,
                )));
  }

//ruta para la edición de un perfil de doctor
  Future<T?> toDoctorProfile<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => MyHomePage2()));
  }

//ruta hacía la pantalla de listar pacientes
  Future<T?> toPatientList<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => DoctorPatients()));
  }

  Future<T?> toDoctorEditProfile<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => ProfileEditionDoctor()));
  }

//ruta para la configuración de una alarma de medicina
  Future<T?> toPatientAlarmAndMedicine<T>(BuildContext context, int idPatient) {
    print('otro idpat ${idPatient.toString()}');
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => AlarmAndMedicinePage(
                  idPatient: idPatient,
                )));
  }

//ruta para visualizar gráficas de tipo torta
  Future<T?> toReportChartPie<T>(BuildContext context, String id, var dataPie, String titulo, String descripcion) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => WidgetChartPie(id: id, dataPie: dataPie, tituloGrafica: titulo, descripcion: descripcion)));
  }

//ruta para visualizar las gráfias de tipo linea
  Future<T?> toReportChartLine<T>(BuildContext context, var id, var dataLine, String titulo, String ejex, String ejey, String description, String dataDescription) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => WidgetChartLine(
                  id: id,
                  dataLine: dataLine,
                  titulo: titulo,
                  ejex: ejex,
                  ejey: ejey,
                  description: description,
                  dataDescription: dataDescription,
                )));
  }

//ruta para visualizar las gráficas de tipo barras
  Future<T?> toReportChartSerie<T>(BuildContext context, var id, var dataLine, String titulo, var colors, String ejex, String ejey, String description, String dataDescription) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => WidgetChartSerie(
                  id: id,
                  dataSerie: dataLine,
                  titulo: titulo,
                  colors: colors,
                  ejex: ejex,
                  ejeY: ejey,
                  description: description,
                  dataDescription: dataDescription,
                )));
  }
}
