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
  Future<T> toPatientHome<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => PatientHomePage()));
  }

//ruta para entrar a calendario de síntomas
  Future<T> toCalendar<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => CalendarScreenView2()));
  }

//ruta para entrar al formulario de sintomas no motores
  Future<T> toNoMotorSymptoms<T>(BuildContext context, int idPatient) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => NoMotorSymptomsFormQ(
                  idPatient: idPatient,
                )));
  }

//ruta para entrar al formulario emocional
  Future<T> toFeelsForm<T>(BuildContext context, int idPatient) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => EmotionalFormQ(
                  idPatient: idPatient,
                )));
  }

//ruta pare entrar a la página de listado de medicinas
  Future<T> toScheduleMedicines<T>(BuildContext context, int idPatient) {
    return Navigator.push<T>(
        context,
        new MaterialPageRoute(
            builder: (context) => Medicines(
                  idPatient: idPatient,
                )));
  }

//ruta para entrar a la pantalla de notificaciones
  Future<T> toNotifications<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => PatientNotifications()));
  }

//ruta para entrar a la pantalla de notificaciones remotas
  Future<T> toRelationsRequest<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => RelationsRequest()));
  }

//ruta para entrar a ver el perfil de un paciente
  Future<T> toPatientProfile<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => MyHomePage1()));
  }

//ruta para ver información sobre el parkinson
  Future<T> toAboutParkinson<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => Information()));
  }

//ruta para la edición del perfil
  Future<T> toPatientEditProfile<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => ProfileEditionPatient()));
  }

  Future<T> toSymptomsForm<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => symptomsFormQ()));
  }

//ruta para el formulario de sintomas no motores
  Future<T> toSymptomsFormPatient<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => SymptomsFormPatient()));
  }

//ruta para entrar a activiades y juegos
  Future<T> toToolbox<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => Toolbox()));
  }

//ruta para entrar al juego
  Future<T> toGame<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => CountDownTimer()));
  }
}
