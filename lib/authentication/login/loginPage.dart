import 'package:flutter/material.dart';
import 'package:bd_class/authentication/login/login_form.dart';
import 'package:bd_class/theme/colors.dart';

class LoginPage extends StatelessWidget {
  final bool isSessionExpired;

  LoginPage({this.isSessionExpired});

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
                    child: Text("V1.4.201")
                  ),
                ),
                LoginForm(isSessionExpired: this.isSessionExpired),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
