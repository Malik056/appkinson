import 'package:appkinson/routes/routes_general.dart';
import 'package:flutter/material.dart';
import 'input_field_login.dart';
import 'buttons/button_login.dart';
import 'buttons/button_go_register_login.dart';

class InputWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: InputFieldLogin(),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {
                  print('hey');
                  RoutesGeneral().toChangePassword(context);
                },
                child: Text('¿Olvidó la Contraseña?')),
            SizedBox(
              height: 40,
            ),
            ButtonLogin(),
            SizedBox(
              height: 40,
            ),
            ButtonGoRegisterLogin()
          ],
        ),
      ),
    );
  }
}
