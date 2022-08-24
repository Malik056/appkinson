import 'package:appkinson/views/calendar/calendar_screen_view2_carer.dart';
import 'package:appkinson/views/home_different_users/carer/carer_home_page.dart';
import 'package:appkinson/views/relations/carer_patients.dart';
import 'package:appkinson/views/relations/interaction_carer_patient.dart';
import 'package:appkinson/views/toolbox/toolbox_initial.dart';
import 'package:appkinson/views/toolbox/toolbox_initial_carer.dart';
import 'package:appkinson/views/profiles/carer/carer_profle.dart';
import 'package:appkinson/views/profiles/carer/profile_edition/profile_edition_carer.dart';
import 'package:flutter/material.dart';
import '../views/relations/doctor_patient_add.dart';

class RoutesCarer {
  //ruta hacia el home del cuidador
  toCarerHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerHomePage()));
  }
 //ruta hacia el perfil del cuidador 
  toCarerProfile(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyHomePage3()));
  }
 //ruta para la edición y visulización del calendario correspondiente a un paciente
  toCalendarCarer(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => CalendarScreenView2Carer()));
  }
 //ruta para listar los pacientes
  toPatientList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CarerPatients()));
  }
 //ruta para agregar un paciente
  toAddUser(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => DoctorPatientsAdd()));
  }
 //ruta para la edición de un perfil de cuidador
  toCarerEditProfile(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => ProfileEditionCarer()));
  }
 //ruta hacia la pantalla intermedia de interacción con un paciente
  toInteractionCarerPatient(BuildContext context, int idPatient) {
    print('patient pantalla intermedia ${idPatient.toString()}');
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => InteractionCarerPatient(
                  idPatient: idPatient,
                )));
  }
 //ruta hacia e toolbox desde un cuidador
  toToolbox(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => toolbox()));
  }
}
