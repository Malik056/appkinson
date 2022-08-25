import 'package:flutter/material.dart';
import 'input_wrapper_login.dart';
import 'header_login.dart';
import '../home_initial/home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool shouldPop = true;
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => HomePage()));
          return shouldPop;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, colors: [Colors.yellow[200], Colors.blue, Colors.blue[700]])),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Header(),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      )),
                  child: InputWrapper(),
                ))
              ]),
            )));
  }
}
