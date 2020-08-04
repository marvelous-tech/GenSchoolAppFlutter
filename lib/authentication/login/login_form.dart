import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bd_class/models/user.model.dart';

import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/theme/colors.dart';

class LoginForm extends StatefulWidget {
  final isSessionExpired;

  LoginForm({this.isSessionExpired});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  LoginService _loginService;

  @override
  void initState() {
    super.initState();
    _loginService = LoginService();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: this._emailController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please give your email';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: BorderSide(color: cardColorSecondary)
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: this._passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please give your password';
              }
              else if (value.length < 8) {
                return 'Password must be 8 character long or more';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Give your password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide(color: cardColorSecondary)
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RaisedButton(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4, vertical: 10),
              onPressed: () {
                onSubmit(_emailController.text, _passwordController.text);
              },
              color: blue,
              child: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit(username, password) async {
    if (this._formKey.currentState.validate()){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Logging in...',
          style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold
          ),
        ),
        duration: Duration(milliseconds: 600),
      ));

      await _loginService.attemptLogIn(username, password)
      .then((response) {
        if(response.body != null) {
          if(response.statusCode == 200) {
            Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(milliseconds: 800),
              content: Text(
                'Please wait...',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ));
            UserModel user = UserModel.fromJson(jsonDecode(response.body));
            String token = user.token;
            if (user.user.userType == 'client-instructor' || user.user.userType == 'client-student'){
              this.storage.write(key: "user", value: jsonEncode(user.user));
              print(user.user.toString());
              this.storage.write(key: "token", value: token);
              this.storage.write(key: "user_type", value: user.user.userType);
              Navigator.popAndPushNamed(context, '/main');
            }
            Scaffold.of(context).showSnackBar(SnackBar(
              content: warnText(
                'Awwww!!! You are neither a student nor a teacher...'
            )));
          } else if (response.statusCode == 400) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: errorText('Account not found.'),
            ));
          } else if (response.statusCode == 502 || response.statusCode == 500) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: errorText('Internal server error.'),
            ));
          } else if (response.statusCode == 401) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: errorText('Please input valid information.'),
            ));
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: errorText('Unexpected error occurred'),
          ));
        }
        return response;
      }).catchError((error) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: errorText('Error occurred while connecting.'),
        ));
      });
    }
    else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: errorText('Please fix those errors.'),
      ));
    }
  }

  Widget errorText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );
  }

  Widget warnText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

