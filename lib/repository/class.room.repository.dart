import 'dart:convert';

import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/utils/apiHelper.dart';

class ClassRoomRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<ClassRoomModel>> fetchClassRoomList() async {
    List<ClassRoomModel> results = [];
    Iterable list;
    await this._helper.get('/app/mobile/class-room/student-class-rooms/').then((value) {
      list = jsonDecode(value.body);
      results = list.map((model) {
        return ClassRoomModel.fromJson(model);
      }).toList();
    });
    return results;
  }
}