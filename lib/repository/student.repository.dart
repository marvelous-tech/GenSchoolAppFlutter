import 'dart:convert';
import 'package:bd_class/models/student.models.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/utils/apiHelper.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<StudentGroupModel> fetchGroup(int classRoomID) async {
    final String url = APP_MOBILE_API + 'students/group/?class_room_id=$classRoomID';
    StudentGroupModel result;
    await this._apiBaseHelper.get(url)
    .then(
      (http.Response response) {
        result = StudentGroupModel.fromJson(jsonDecode(response.body));
      }
    );
    return result;
  }
}
