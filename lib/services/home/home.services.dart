import 'dart:convert';
import 'dart:io';

import 'package:bd_class/models/home/home.api.model.dart';
import 'package:bd_class/models/home/home.model.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:http/http.dart' as http;


class HomeService {

  LoginService _loginService = LoginService();
  String _token;

  Future<HomeContentModel> getHomePageContents() async {
    await this._loginService.jwtOrEmpty.then((String token) {
      this._token = token;
    });

    bool hasError = false;
    http.Response response;
    response = await http.get(
      API_URL + '/app-home/',
      headers: {
        HttpHeaders.authorizationHeader: "JWT ${this._token}"
      }
    );
    if (response.statusCode == 401) {
      _loginService.logout();
      return HomeContentModel();
    }
    HomeContentApiModel homeContentApiModel = HomeContentApiModel.fromJson(jsonDecode(response.body));
    return hasError ? null : HomeContentModel(
      homeSchoolModel: HomeSchoolModel(
        name: homeContentApiModel.institute.name,
        type: homeContentApiModel.institute.type,
        year: homeContentApiModel.institute.year,
        eiinCode: homeContentApiModel.institute.eiinCode,
      ),
      homeTSModel: HomeTSModel(
        studentsNumber: homeContentApiModel.tsNumber.studentsNumber,
        teachersNumber: homeContentApiModel.tsNumber.teachersNumber,
      ),
      homePrincipalModel: HomePrincipalModel(
        name: homeContentApiModel.principal.name
        )
    );
  } 
}
