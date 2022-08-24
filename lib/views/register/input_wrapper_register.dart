import 'package:flutter/material.dart';
import 'input_field_register.dart';
import 'buttons/button_register.dart';
import 'buttons/button_go_login.dart';

class InputWrapperRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: InputFieldRegister(),
          ),
          SizedBox(
            height: 40,
          ),
          ButtonRegister(),
          SizedBox(
            height: 20,
          ),
          ButtonGoLogin(),
        ],
      ),
    );
  }
}
