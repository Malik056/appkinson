import 'package:appkinson/views/calendar/calendar_screen_view2_carer.dart';
import 'package:appkinson/views/home_different_users/carer/carer_home_page.dart';
import 'package:appkinson/views/relations/carer_patients.dart';
import 'package:appkinson/views/relations/interaction_carer_patient.dart';
import 'package:appkinson/views/toolbox/toolbox_initial.dart';
import 'package:appkinson/views/profiles/carer/carer_profle.dart';
import 'package:appkinson/views/profiles/carer/profile_edition/profile_edition_carer.dart';
import 'package:flutter/material.dart';
import '../views/relations/doctor_patient_add.dart';

class RoutesCarer {
  //ruta hacia el home del cuidador
  Future<T?> toCarerHome<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => CarerHomePage()));
  }

  //ruta hacia el perfil del cuidador
  Future<T?> toCarerProfile<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => MyHomePage3()));
  }

  //ruta para la edición y visulización del calendario correspondiente a un paciente
  Future<T?> toCalendarCarer<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => CalendarScreenView2Carer()));
  }

  //ruta para listar los pacientes
  Future<T?> toPatientList<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => CarerPatients()));
  }

  //ruta para agregar un paciente
  Future<T?> toAddUser<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => DoctorPatientsAdd()));
  }

  //ruta para la edición de un perfil de cuidador
  Future<T?> toCarerEditProfile<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => ProfileEditionCarer()));
  }

  //ruta hacia la pantalla intermedia de interacción con un paciente
  Future<T?> toInteractionCarerPatient<T>(BuildContext context, int idPatient) {
    print('patient pantalla intermedia ${idPatient.toString()}');
    return Navigator.push<T>(
        context,
        new MaterialPageRoute<T>(
            builder: (context) => InteractionCarerPatient(
                  idPatient: idPatient,
                )));
  }

  //ruta hacia e toolbox desde un cuidador
  Future<T?> toToolbox<T>(BuildContext context) {
    return Navigator.push<T>(
      context,
      new MaterialPageRoute<T>(
        builder: (context) => Toolbox(),
      ),
    );
  }
}
