import 'dart:convert';

import 'package:bd_class/models/course.model.dart';
import 'package:bd_class/utils/apiHelper.dart';

class CourseRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<CourseModel>> fetchCourseList() async {
    List<CourseModel> courseList = [];
    Iterable list;
    await this._helper.get(
      '/app/mobile/courses/student-courses/'
    ).then((result) {
      list = jsonDecode(result.body);
      courseList = list.map((model) {
        return CourseModel.fromJson(model);
      }).toList();
    });
    return courseList;
  }
}
