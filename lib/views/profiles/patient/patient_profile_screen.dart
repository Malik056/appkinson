// ignore_for_file: unused_local_variable

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/model/user.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/routes/routes_patient.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/home_initial/home_page.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const bla = Colors.white;
const kSpacingUnit = 10;
File? imageFilePatient;
String namePatient = " ";
String emailPatient = " ";
Map? currentUser;
var token = Utils().getToken();
var tokenId = Utils().getFromToken('id');

final kTitleTextStyle = TextStyle(
  fontFamily: "Raleway",
  fontSize: ScreenUtil().setSp(kSpacingUnit * 2),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit * 2),
  fontWeight: FontWeight.w100,
  //fontFamily: "Raleway"
);

class PatientProfileScreen extends StatefulWidget {
  PatientProfileScreenP createState() => PatientProfileScreenP();
}

class PatientProfileScreenP extends State<PatientProfileScreen> {
  @override
  void initState() {
    super.initState();

    //todos.add("Regular Colors");
    //todos.add("Power Coating");
  }

  openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picture == null) {
      //TODO: Handle null (TAHA)
      return;
    }
    this.setState(() {
      imageFilePatient = File(picture.path);
    });
    var newUser = new User(photo: imageFilePatient);
    String? id = await Utils().getFromToken('id');
    String? token = await Utils().getToken();
    if (id == null || token == null) {
      //TODO: Handle null (TAHA)
      return;
    }
    String save = await EndPoints().modifyUsersPhoto(newUser, id, token);
    RoutesGeneral().toPop(context);
  }

  openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picture == null) {
      //TODO: Handle null (TAHA)
      return;
    }
    this.setState(() {
      imageFilePatient = File(picture.path);
    });

    var newUser = new User(photo: imageFilePatient);
    String? id = await Utils().getFromToken('id');
    String? token = await Utils().getToken();
    if (id == null || token == null) {
      //TODO: Handle null (TAHA)
      return;
    }
    String save = await EndPoints().modifyUsersPhoto(newUser, id, token);
    RoutesGeneral().toPop(context);
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Escoge:'),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Galer??a"),
                  onTap: () {
                    openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(6.0)),
                GestureDetector(
                  child: Text("C??mara"),
                  onTap: () async {
                    openCamera(context);
                    var m = new Method3();
                    //var user =  m.send();
                    var newUser = new User(photo: imageFilePatient);
                    /*
                    debugPrint(user.name);
                    var lista = token.split(".");
                    var payload = lista[1];

                    switch (payload.length % 4) {
                      case 1:
                        break; // this case can't be handled well, because 3 padding chars is illeagal.
                      case 2:
                        payload = payload + "==";
                        break;
                      case 3:
                        payload = payload + "=";
                        break;
                    }

                    var decoded = utf8.decode(base64.decode(payload));
                    currentUser = json.decode(decoded);
                    debugPrint(currentUser['id'].toString());
                    */

                    debugPrint('aqui');
                    String? _tokenId = await tokenId; //TODO: Check Logic (TAHA)
                    String? _token = await tokenId; //TODO: Check Logic (TAHA)
                    if (_tokenId == null || _token == null) {
                      //TODO: Handle null (TAHA)
                      return;
                    }
                    currentUser = Utils().tokenDecoder(_token);
                    print(currentUser.toString());
                    String save = await EndPoints().modifyUsersPhoto(newUser, _tokenId, _token);

                    //debugPrint('aqui' + save);
                  },
                )
              ],
            )),
          );
        });
  }

  Widget decideImageView() {
    if (imageFilePatient == null) {
      return Icon(LineAwesomeIcons.question);
    } else {
      return Image.file(
        imageFilePatient!,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(414, 896), minTextAdapt: true);
    var profileInfo = Expanded(
        child: Column(
      children: [
        Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.only(top: 50),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: decideImageView(),
                ),

                backgroundImage: AssetImage("assets/images/user.png"),
                // backgroundImage: AssetImage(imageFile),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: 30,
                    width: 30,
                    child: TextButton(
                      style: buildButtonStyle(
                        background: Colors.blue,
                        horiztonalPadding: 1,
                        verticalPadding: 1,
                        border: CircleBorder(),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              LineAwesomeIcons.camera,
                              //color: Colors.white,
                              size: ScreenUtil().setSp(25),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        showChoiceDialog(context);
                      },
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          // currentUser['EMAIL'],
          //"nombre",
          namePatient,
          style: kTitleTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
            //currentUser['EMAIL'],
            //"h@gamil.com",
            //"email",
            //emailPatient
            emailPatient,
            //emailPatient,
            style: kCaptionTextStyle),
        SizedBox(),
      ],
    ));
    var header = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      SizedBox(
        width: 10,
      ),
      TextButton(
        style: buildButtonStyle(
          border: CircleBorder(),
          background: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Icon(
                LineAwesomeIcons.arrow_left,
                size: ScreenUtil().setSp(40),
              ),
            )
          ],
        ),
        onPressed: () async {
          RoutesGeneral().toPop(context);
        },
        // padding: EdgeInsets.all(1),
      ),
      profileInfo,
      SizedBox(
        width: 20,
      ),
      /* Icon(
            LineAwesomeIcons.sun,
            size: ScreenUtil().setSp(40),
          ),*/
      SizedBox(
        width: 80,
      ),
    ]);

    return Scaffold(
        body: Container(
            color: bla,
            child: Column(children: <Widget>[
              SizedBox(
                height: 20,
              ),
              header,
              SizedBox(
                height: 30,
              ),
              Expanded(
                  child: ListView(
                children: <Widget>[
                  ProfileListItem(
                    icon: LineAwesomeIcons.pen,
                    text: 'Editar',
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.helping_hands,
                    text: 'Ayuda & Soporte',
                  ),
                  ProfileListItem(
                    icon: Icons.exit_to_app,
                    text: 'Cerrar Sesi??n',
                  ),
                ],
              )),
            ])));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({Key? key, this.icon, this.text, this.hasNavigation = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: TextButton(
          style: buildButtonStyle(
            border: roundedRadius30,
            background: Colors.grey[100],
          ),
          onPressed: () async {
            if (text == 'Editar') {
              RoutesPatient().toPatientEditProfile(context);
            }
            if (text == 'Ayuda & Soporte') {
              RoutesGeneral().toAboutUs(context);
            }
            if (text == 'Cerrar Sesi??n') {
              debugPrint("Tapped Log Out....");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              await Utils().removeBackgroundTask();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
            }
          },
          child: Row(
            children: <Widget>[
              Icon(this.icon, size: 25),
              SizedBox(
                width: 25,
              ),
              Text(
                this.text,
                style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              if (this.hasNavigation)
                Icon(
                  LineAwesomeIcons.angle_right,
                  size: 25,
                ),
            ],
          ),
        ));
  }
}

class Method3 {
  Future<User> send() async {
    var newUser = new User(photo: imageFilePatient);
    debugPrint(newUser.name);
    return newUser;
  }
}
