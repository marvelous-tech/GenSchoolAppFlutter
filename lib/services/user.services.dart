import 'dart:convert';

import 'package:bd_class/models/user.model.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:http/http.dart' as http;


class UserService {
  LoginService _loginService = LoginService();
  String _token;

  Future<User> getUser() async {
    await this._loginService.jwtOrEmpty.then((String value) => this._token = value);

    http.Response response;

    response = await http.get(
      API_URL + '/app/user/',
      headers: {
        "Authorization": "JWT ${this._token}",
      }
    ).catchError((e) {
      print(e);
    });
    print(response.statusCode);
    return User.fromJson(jsonDecode(response.body));
  }
}
