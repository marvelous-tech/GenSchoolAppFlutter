import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/models/user.model.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/theme/colors.dart';
import 'theme/colors.dart';
import 'package:package_info/package_info.dart';

class DrawerWidget extends StatefulWidget {
  final User user;

  DrawerWidget({@required this.user});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final LoginService _loginService = LoginService();

  String version;

  @override
  void initState() {
    this.setVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.drawer(context);
  }

  Widget drawer(BuildContext context) {
    String type;
    if (this.widget.user.userType == 'client-instructor')
      type = 'Instructor';
    else if (this.widget.user.userType == 'client-student')
      type = 'Student';
    print(type);
    return Drawer(
      child: Container(
        color: background,
        child: ListView(
          children: <Widget>[
            Container(
              color: cardColorPrimary,
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 150.0,
                  ),
                  Positioned(
                    top: 28.0,
                    right: 15.0,
                    child: Image.asset("avatars/logo.png", height: 32,)
                  ),
                  Positioned(
                    top: 30.0,
                    left: 15.0,
                    child: Text(
                      "Marvelous Technologies",
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45.0,
                    left: 15.0,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "BD Class V${this.version} ",
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Icon(Icons.developer_mode, size: 8,),
                        Text(
                          " Fahim",
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30.0,
                    left: 15.0,
                    child: Text(
                      this.widget.user.firstName + " " + this.widget.user.lastName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 15.0,
                    child: Text(
                      type,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Instructors',
                style: this.defaultTextStyleForListTiles(),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/teacher');
              },
            ),
            Divider(
              height: 0.0,
              color: Colors.black38,
            ),
            ListTile(
              title: Text(
                'Courses',
                style: this.defaultTextStyleForListTiles(),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/courses');
              },
            ),
            Divider(
              height: 0.0,
              color: Colors.black38,
            ),
            ListTile(
              title: Text(
                'Payments',
                style: this.defaultTextStyleForListTiles(),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/payments');
              },
            ),
            Divider(
              height: 0.0,
              color: Colors.black38,
            ),
            ListTile(
              title: Text(
                'Logout',
                style: this.defaultTextStyleForListTiles(),
              ),
              onTap: () {
                Navigator.pop(context);
                logout(context);
              },
            ),
            Divider(
              height: 0.0,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle defaultTextStyleForListTiles() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
      letterSpacing: 0.3,
      color: Colors.blueGrey[200],
    );
  }

  void logout(context) {
    this._loginService.logout().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/login", (Route<dynamic> route) => false);
      return null;
    });
  }

  void setVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        this.version = packageInfo.version;
      });
    });
  }
}