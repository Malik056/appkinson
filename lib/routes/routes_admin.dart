import 'package:appkinson/views/administrator/form_add_item.dart';
import 'package:appkinson/views/administrator/list_items_administrator.dart';
import 'package:appkinson/views/home_different_users/admin/admin_home_page.dart';

import 'package:flutter/material.dart';

class RoutesAdmin {
  //ruta hacia el home del administrador
  Future<T?> toAdminHome<T>(BuildContext context) {
    return Navigator.push<T>(context, new MaterialPageRoute(builder: (context) => AdminHomePage()));
  }

  //ruta hacia la pantalla agregar item
  Future<T?> toFormAddItem<T>(BuildContext context) {
    return Navigator.push<T>(
      context,
      new MaterialPageRoute(builder: (context) => FormItemToolboxPage()),
    );
  }

  //ruta hacia la pantallaa listar items
  Future<T?> toListItems<T>(BuildContext context) {
    return Navigator.push<T>(
      context,
      new MaterialPageRoute<T>(builder: (context) => ListItemsAdministrator()),
    );
  }
}
