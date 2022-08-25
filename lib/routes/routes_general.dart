import 'package:appkinson/views/about_us/help_support.dart';
import 'package:appkinson/views/login/login_page.dart';

import 'package:appkinson/views/login/reset_password/password_change.dart';
import 'package:appkinson/views/login/reset_password/passwordChangeOtm.dart';
import 'package:appkinson/views/register/register_page.dart';
import 'package:appkinson/views/toolbox/about_excercises/excercises_list.dart';
import 'package:appkinson/views/toolbox/about_food/food_list.dart';
import 'package:appkinson/views/toolbox/about_news/news_list.dart';
import 'package:flutter/material.dart';

class RoutesGeneral {
  //ruta para registrar un nuevo usuario
  Future<T> toRegister<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => RegisterPage()));
  }

  //ruta hacia la pantalla de "acerca de nosotros"
  Future<T> toAboutUs<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => HelpSupport()));
  }

//ruta para el logueo de un usuario nuevo
  Future<T> toLogin<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => LoginPage()));
  }

//ruta para regresar al contexto anterior
  void toPop<T>(BuildContext context) {
    Navigator.pop<T>(context);
  }

//ruta para los items de comida
  Future<T> toListFood<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => ListFood()));
  }

//rutas para listar los ejercicios
  Future<T> toListExcercises<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => ListExcercises()));
  }

//ruta para listar las noticias
  Future<T> toListNews<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => ListNews()));
  }

//ruta hacia cambiar la contraseña
  Future<T> toChangePassword<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => PasswordChange()));
  }

// ruta para la generación de la otm
  Future<T> toChangePasswordOtm<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute<T>(builder: (context) => PasswordChangeOtm()));
  }
}
