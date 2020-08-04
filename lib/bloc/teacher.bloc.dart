import 'dart:async';

import 'package:bd_class/models/teacher_model.dart';
import 'package:bd_class/repository/teacher.repository.dart';
import 'package:bd_class/utils/apiResponse.dart';

class TeacherBloc {
  TeacherRepository _teacherRepository;

  StreamController _teacherListController;

  StreamSink<ApiResponse<List<TeacherModel>>> get teacherListSink =>
      _teacherListController.sink;

  Stream<ApiResponse<List<TeacherModel>>> get teacherListStream =>
      _teacherListController.stream;

  TeacherBloc() {
    _teacherListController = StreamController<ApiResponse<List<TeacherModel>>>();
    _teacherRepository = TeacherRepository();
    fetchTeacherList();
  }

  fetchTeacherList() async {
    teacherListSink.add(ApiResponse.loading('Fetching All Teachers'));
    try {
      List<TeacherModel> movies = await _teacherRepository.fetchTeacherList();
      teacherListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      teacherListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _teacherListController?.close();
  }
}
