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
  toRegister(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => RegisterPage()));
  }
 //ruta hacia la pantalla de "acerca de nosotros"
  toAboutUs(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => HelpSupport()));
  }
//ruta para el logueo de un usuario nuevo
  toLogin(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginPage()));
  }
//ruta para regresar al contexto anterior
  toPop(BuildContext context) {
    Navigator.pop(context);
  }
//ruta para los items de comida
  toListFood(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListFood()));
  }
//rutas para listar los ejercicios
  toListExcercises(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListExcercises()));
  }
//ruta para listar las noticias
  toListNews(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListNews()));
  }
//ruta hacia cambiar la contraseña
  toChangePassword(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => PasswordChange()));
  }
// ruta para la generación de la otm
  toChangePasswordOtm(BuildContext context) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => PasswordChangeOtm()));
  }
}
