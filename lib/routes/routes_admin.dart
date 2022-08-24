import 'package:appkinson/views/administrator/form_add_item.dart';
import 'package:appkinson/views/administrator/list_items_administrator.dart';
import 'package:appkinson/views/home_different_users/admin/admin_home_page.dart';

import 'package:flutter/material.dart';

class RoutesAdmin {
  //ruta hacia el home del administrador
  toAdminHome(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => AdminHomePage()));
  }
  //ruta hacia la pantalla agregar item
  toFormAddItem(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => FormItemToolboxPage()));
  }
  //ruta hacia la pantallaa listar items
  toListItems(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListItemsAdministrator()));
  }

}
