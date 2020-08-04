import 'package:bd_class/services/authentication/login.service.dart';
import 'package:flutter/material.dart';

class NavigationService {
  LoginService _loginService = LoginService();

  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();
  Future<dynamic> pushNamedAndRemoveUntil(String routeName) async {
    await this._loginService.logout().then((value) {
      navigatorKey.currentState.pushNamedAndRemoveUntil(
          "$routeName", (Route<dynamic> route) => false);
      return null;
    });
  }
}