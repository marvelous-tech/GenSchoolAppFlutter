import 'dart:convert';

import 'package:bd_class/models/attendance.model.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/utils/apiHelper.dart';
import 'package:http/http.dart' as http;

class AttendanceRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> issueAttendance(
      int classID, AttendanceAddModel attendanceAddModel
  ) async {
    http.Response response;
    final String url = APP_MOBILE_API + 'attendance/create/?class_id=$classID';
    response = await this._apiBaseHelper.post(url, jsonEncode(attendanceAddModel));
    return response;
  }

  Future<http.Response> fetchAllAttendance(int classID) async {
    return await this._apiBaseHelper.get(
      APP_MOBILE_API + 'attendance/?class_id=$classID'
    );
  }
}
