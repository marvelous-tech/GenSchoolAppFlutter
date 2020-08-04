import 'dart:async';

import 'package:bd_class/models/course.model.dart';
import 'package:bd_class/repository/course.repository.dart';
import 'package:bd_class/utils/apiResponse.dart';

class CourseBloc {
  CourseRepository _courseRepository;

  StreamController _courseStreamController;

  StreamSink<ApiResponse<List<CourseModel>>> get courseSink =>
      this._courseStreamController.sink;

  Stream<ApiResponse<List<CourseModel>>> get courseStream =>
      this._courseStreamController.stream;

  CourseBloc() {
    this._courseStreamController = StreamController<ApiResponse<List<CourseModel>>>();
    this._courseRepository = CourseRepository();
    this.fetchCourseList();
  }

  fetchCourseList() async {
    this.courseSink.add(ApiResponse.loading("Loading Data"));
    try {
      List<CourseModel> results = await this._courseRepository.fetchCourseList();
      this.courseSink.add(ApiResponse.completed(results));
    } catch (e) {
      this.courseSink.add(ApiResponse.error("Error!!!"));
      print(e);
    }
  }

  dispose() {
    this._courseStreamController?.close();
  }
}
