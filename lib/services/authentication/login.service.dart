import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bd_class/models/user.model.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:http/http.dart' as http;

class LoginService {
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<http.Response> attemptLogIn(String username, String password) async {
    Map<String, dynamic> data = {
      "username": username,
      "email": "",
      "password": password,
    };
    http.Response res = await http.post(
        "$API_URL/auth/login/",
        body: data
    ).catchError((onError) {
      return onError;
    });

    return res;
  }

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "token");
    if(jwt == null) return "";
    return jwt;
  }

  Future<bool> get isStudent async {
    bool isStudent = true;
    await storage.read(key: "user_type").then((value) {
      if (value == 'client-instructor') isStudent = false;
      else isStudent = true;
    });
    return isStudent;
  }

  Future<User> get thisUser async {
    String userObject = await storage.read(key: "user");
    User user = User.fromJson(jsonDecode(userObject));
    return user;
  }

  Future<void> logout() async {
    await this.storage.deleteAll();
  }

  bool isExpired(String token) {
    var str = token;
    var jwt = str.split(".");

    if(jwt.length != 3) {
      this.logout();
      return true;
    } else {
      var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
      if(!DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
        return true;
      }
    }
    return false;
  }
}
