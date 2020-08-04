import 'dart:async';
import 'dart:convert';

import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/services/api_data.service.dart';
import 'package:bd_class/utils/apiHelper.dart';
import 'package:http/http.dart' as http;

class ClassRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Class>> fetchClassList(int classRoomId) async {
    List<Class> results;
    Iterable list;
    await this
        ._helper
        .get('/app/mobile/class-room/student-classes/?class_room_id=$classRoomId')
        .then((value) {
      list = jsonDecode(value.body);
      results = list.map((model) {
        return Class.fromJson(model);
      }).toList();
    });
    return results;
  }

  Future<http.Response> addClass(ClassAddModel payloads, int classRoomID) async {
    String url = APP_MOBILE_API
        + 'class-room/student-class/add/?class_room_id='
        + classRoomID.toString();
    return this._helper.post(url, jsonEncode(payloads));
  }
  
  Future<http.Response> editClass(ClassAddModel payloads, int classRoomID, int classID) async {
    String url = APP_MOBILE_API
        + 'class-room/student-class/edit/$classID/?class_room_id='
        + classRoomID.toString();
    return this._helper.put(url, jsonEncode(payloads));
  }
  
  Future<http.Response> deleteClass(int classId, int classRoomID) {
    String url = APP_MOBILE_API 
        + 'class-room/student-class/delete/$classId/?class_room_id=$classRoomID';
    return this._helper.delete(url);
  }
}
