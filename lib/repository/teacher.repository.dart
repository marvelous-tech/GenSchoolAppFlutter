import 'dart:convert';

import 'package:bd_class/models/teacher_model.dart';
import 'package:bd_class/utils/apiHelper.dart';

class TeacherRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<TeacherModel>> fetchTeacherList() async {
    List<TeacherModel> results = [];
    Iterable list;

    await _helper.get('/app/mobile/teachers/').then((value) {
      list = jsonDecode(value.body);
      results = list.map((model) {
        return TeacherModel.fromJson(model);
      }).toList();
    });
    
    return results;
  }
}
