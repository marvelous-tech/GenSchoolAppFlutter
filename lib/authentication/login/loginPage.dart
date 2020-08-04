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
                  padding: const EdgeInsets.only(bottom: 50.0, top: 100),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          letterSpacing: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PatrickHand',
                          fontSize: 30
                        ),
                        children: [
                          TextSpan(
                            text: "Es",
                            style: TextStyle(color: Color(0xff1ebdff))
                          ),
                          TextSpan(
                              text: "tu",
                              style: TextStyle(color: Color(0xffff0000))
                          ),
                          TextSpan(
                              text: "do",
                              style: TextStyle(color: Color(0xffff00ba))
                          )
                        ]
                      ),
                    )
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
