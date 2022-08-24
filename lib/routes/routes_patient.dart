import 'package:appkinson/views/calendar/calendar_screen_view2.dart';
import 'package:appkinson/views/emotional_form/emotional_form_q.dart';
import 'package:appkinson/views/game/count_down_game.dart';
import 'package:appkinson/views/Medicines/medicines.dart';
import 'package:appkinson/views/no_motor_symptoms_form_patient//no_motor_symptoms_form_q.dart';
import 'package:appkinson/views/relation_request/relations_requets.dart';
import 'package:appkinson/views/symptoms_form_patient/symptoms_form_patient.dart';

import 'package:appkinson/views/home_different_users/patient/patient_home_page.dart';

import 'package:appkinson/views/notifications/patient_notifications.dart';
import 'package:appkinson/views/symptoms_form_doctor/symptoms_form_q.dart';
import 'package:appkinson/views/toolbox/about_parkinson/buttons/Information.dart';
import 'package:appkinson/views/toolbox/toolbox_initial.dart';
import 'package:appkinson/views/profiles/patient/patient_profile.dart';
import 'package:appkinson/views/profiles/patient/profile_edition/profile_edition_patient.dart';
import 'package:flutter/material.dart';

class RoutesPatient {
  //ruta para ir al home de un paciente
  toPatientHome(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientHomePage()));
  }
//ruta para entrar a calendario de síntomas
  toCalendar(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => CalendarScreenView2()));
  }
//ruta para entrar al formulario de sintomas no motores
  toNoMotorSymptoms(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => NoMotorSymptomsFormQ(
                  idPatient: idPatient,
                )));
  }
//ruta para entrar al formulario emocional
  toFeelsForm(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => EmotionalFormQ(
                  idPatient: idPatient,
                )));
  }
//ruta pare entrar a la página de listado de medicinas
  toScheduleMedicines(BuildContext context, int idPatient) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Medicines(
                  idPatient: idPatient,
                )));
  }
//ruta para entrar a la pantalla de notificaciones
  toNotifications(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PatientNotifications()));
  }
//ruta para entrar a la pantalla de notificaciones remotas
  toRelationsRequest(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => RelationsRequest()));
  }
//ruta para entrar a ver el perfil de un paciente
  toPatientProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage1()));
  }
//ruta para ver información sobre el parkinson
  toAboutParkinson(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Information()));
  }
//ruta para la edición del perfil
  toPatientEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionPatient()));
  }

  toSymptomsForm(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => symptomsFormQ()));
  }
//ruta para el formulario de sintomas no motores
  toSymptomsFormPatient(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => SymptomsFormPatient()));
  }
//ruta para entrar a activiades y juegos
  toToolbox(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => toolbox()));
  }
//ruta para entrar al juego
  toGame(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CountDownTimer()));
  }
}
