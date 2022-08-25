// ignore_for_file: unused_local_variable

import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/model/user.dart';
import 'package:appkinson/routes/routes_carer.dart';
import 'package:appkinson/routes/routes_general.dart';
import 'package:appkinson/services/end_points.dart';
import 'package:appkinson/utils/utils.dart';
import 'package:appkinson/views/home_initial/home_page.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const bla = Colors.white;
const kSpacingUnit = 10;
File imageFileCarer;
var nameCarer = "";
var emailCarer = "";

final kTitleTextStyle = TextStyle(
  fontFamily: "Raleway",
  fontSize: ScreenUtil().setSp(20),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(20),
  fontWeight: FontWeight.w100,
  //fontFamily: "Raleway"
);

class CarerProfileScreen extends StatefulWidget {
  DoctorProfileScreenP createState() => DoctorProfileScreenP();
}

class DoctorProfileScreenP extends State<CarerProfileScreen> {
  openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFileCarer = File(picture.path);
    });
    var newUser = new User(photo: imageFileCarer);
    String id = await Utils().getFromToken('id');
    String token = await Utils().getToken();
    String save = await EndPoints().modifyUsersPhoto(newUser, id, token);
    RoutesGeneral().toPop(context);
  }

  openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFileCarer = File(picture.path);
    });
    var newUser = new User(photo: imageFileCarer);
    String id = await Utils().getFromToken('id');
    String token = await Utils().getToken();
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
                  child: Text("Galería"),
                  onTap: () {
                    openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(6.0)),
                GestureDetector(
                  child: Text("Cámara"),
                  onTap: () {
                    openCamera(context);
                  },
                )
              ],
            )),
          );
        });
  }

  Widget decideImageView() {
    if (imageFileCarer == null) {
      return Icon(LineAwesomeIcons.question);
    } else {
      return Image.file(
        imageFileCarer,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = Container(
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
          nameCarer,
          style: kTitleTextStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(emailCarer, style: kCaptionTextStyle),
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
        onPressed: () {
          RoutesGeneral().toPop(context);
        },
        // padding: EdgeInsets.all(1),
      ),
      profileInfo,
      SizedBox(
        width: 20,
      ),
      /*Icon(
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
                    text: 'Cerrar Sesión',
                  ),
                ],
              )),
            ])));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({Key key, this.icon, this.text, this.hasNavigation = true}) : super(key: key);

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
              RoutesCarer().toCarerEditProfile(context);
            }
            if (text == 'Ayuda & Soporte') {
              RoutesGeneral().toAboutUs(context);
            }

            if (text == 'Cerrar Sesión') {
              debugPrint("Tapped Log Out....");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.clear();
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
