import 'package:bd_class/models/user.model.dart';
import 'package:bd_class/services/authentication/login.service.dart';


class DrawerService {
  LoginService _loginService = LoginService();

  User _user;

  Future<User> getFullName() async {
    await _loginService.thisUser.then((value) {
      this._user = value;
    });

    return this._user;
  }

}
