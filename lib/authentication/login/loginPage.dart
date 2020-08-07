import 'package:flutter/material.dart';
import 'package:bd_class/authentication/login/login_form.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:package_info/package_info.dart';

class LoginPage extends StatefulWidget {
  final bool isSessionExpired;

  LoginPage({this.isSessionExpired});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String version;

  @override
  void initState() {
    this.setVersion();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('avatars/featureBackground.png'),
            fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0, top: 100),
                  child: Center(
                    child: Image.asset("avatars/loginLogo.png", width: 140,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 5),
                  child: Center(
                    child: Text("V${this.version}")
                  ),
                ),
                LoginForm(isSessionExpired: this.widget.isSessionExpired),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        this.version = packageInfo.version;
      });
    });
  }
}
