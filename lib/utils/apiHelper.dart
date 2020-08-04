import 'dart:io';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/services/navigation.service.dart';
import 'package:http/http.dart' as http;

import 'appException.dart';

class ApiBaseHelper {

  final String _baseUrl = API_URL;
  LoginService _loginService = LoginService();

  Future<http.Response> get(String url) async {
    var responseJson;
    try {
      String token;
      await this._loginService.jwtOrEmpty.then((value) {
        token = value;
      });
      print("Getting from: $API_URL$url");
      final response = await http.get(
        _baseUrl + url,
        headers: {
          HttpHeaders.authorizationHeader: 'JWT $token',
        }
      );
      responseJson = _returnResponse(response);
      print(responseJson.body);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> post(String url, dynamic body) async {
    var responseJson;
    try {
      String token;
      await this._loginService.jwtOrEmpty.then((value) {
        token = value;
      });
      print("Posting to: $API_URL$url");
      final response = await http.post(
        _baseUrl + url,
        headers: {
          HttpHeaders.authorizationHeader: 'JWT $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: body
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> put(String url, dynamic body) async {
    var responseJson;
    try {
      String token;
      await this._loginService.jwtOrEmpty.then((value) {
        token = value;
      });
      print("Putting in: $API_URL$url");
      final response = await http.put(
        _baseUrl + url,
        headers: {
          HttpHeaders.authorizationHeader: 'JWT $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: body
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> patch(String url, dynamic body) async {
    var responseJson;
    try {
      String token;
      await this._loginService.jwtOrEmpty.then((value) {
        token = value;
      });
      print("Patching to: $API_URL$url");
      final response = await http.patch(
        _baseUrl + url,
        headers: {
          HttpHeaders.authorizationHeader: 'JWT $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: body
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<http.Response> delete(String url) async {
    var responseJson;
    try {
      String token;
      await this._loginService.jwtOrEmpty.then((value) {
        token = value;
      });
      print("Deleting that: $API_URL$url");
      final response = await http.delete(
        _baseUrl + url,
        headers: {
          HttpHeaders.authorizationHeader: 'JWT $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  http.Response _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 204:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
