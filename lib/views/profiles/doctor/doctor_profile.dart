//import 'package:appkinson/views/profiles/patient/patient_profile_screen.dart';
import 'package:appkinson/constants/globals.dart';
import 'package:appkinson/views/home_different_users/doctor/doctor_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:foldable_sidebar/foldable_sidebar.dart';
// import 'package:swipedetector/swipedetector.dart';

import 'doctor_profile_screen.dart';

const bla = Colors.white;
const kSpacingUnit = 10;
//File imageFile;

final kTitleTextStyle = TextStyle(
  fontFamily: "Raleway",
  fontSize: ScreenUtil().setSp(kSpacingUnit * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit * 1.3),
  fontWeight: FontWeight.w100,
  //fontFamily: "Raleway"
);

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  // FSBStatus drawerStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: DoctorProfileScreen(),
        // SwipeDetector(
        // onSwipeRight: () {
        //   setState(() {
        //     drawerStatus = FSBStatus.FSB_OPEN;
        //   });
        // },
        // onSwipeLeft: () {
        //   setState(() {
        //     drawerStatus = FSBStatus.FSB_CLOSE;
        //   });
        // },
        // child: FoldableSidebarBuilder(
        //   drawerBackgroundColor: Colors.blue[800],
        //   drawer: CustomDrawer(
        //     closeDrawer: () {
        //       setState(() {
        //         drawerStatus = FSBStatus.FSB_CLOSE;
        //       });
        //     },
        //   ),
        //   screenContents: DoctorProfileScreen(),
        //   status: drawerStatus,
        // ),
        // ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[800],
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              if (Scaffold.of(context).isDrawerOpen) {
                Scaffold.of(context).closeDrawer();
              } else {
                Scaffold.of(context).openDrawer();
              }
              // setState(() {
              // drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
              // });
            }),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function? closeDrawer;

  const CustomDrawer({Key? key, this.closeDrawer}) : super(key: key);

  Widget decideImage() {
    if (imageFileDoctor == null) {
      return Image.asset(
        "assets/images/user.png",
        width: 100,
        height: 100,
      );
    } else {
      return Image.file(
        imageFileDoctor!,
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.blue,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: decideImage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ///nameControllerDoctor.text,
                    nameDoctor,
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(emailDoctor, style: kCaptionTextStyle),
                ],
              )),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Profile");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => DoctorProfileScreen()));
            },
            leading: Icon(Icons.person),
            title: Text(
              "Tu Perfil",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          /*ListTile(
            onTap: () {
              debugPrint("Tapped settings");
            },
            leading: Icon(Icons.settings),
            title: Text("Ajustes"),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),*/
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext ctx) => DoctorHomePage()));
            },
            leading: Icon(Icons.home),
            title: Text("Ir al Home"),
          ),
          /*Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
            },
            leading: Icon(Icons.notifications),
            title: Text("Notificaciones"),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () async {
              debugPrint("Tapped Log Out");
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.clear();
              await Utils().removeBackgroundTask();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Cerrar Sesión"),
          ),
          ),*/
        ],
      ),
    );
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
          onPressed: () {},
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
