import 'dart:async';

import 'package:bd_class/models/student.models.dart';
import 'package:bd_class/repository/student.repository.dart';
import 'package:bd_class/utils/apiResponse.dart';

class StudentGroupBloc {
  int classRoomID;
  StudentRepository _studentRepository;

  StreamController _studentGroupStreamController;

  StreamSink<ApiResponse<StudentGroupModel>> get studentGroupSink => 
    this._studentGroupStreamController.sink;

  Stream<ApiResponse<StudentGroupModel>> get studentGroupStream =>
      this._studentGroupStreamController.stream;

  StudentGroupBloc({this.classRoomID}) {
    this._studentGroupStreamController =
        StreamController<ApiResponse<StudentGroupModel>>();
    this._studentRepository = StudentRepository();
    this.fetchStudentGroup();
  }

  void fetchStudentGroup() async {
    this.studentGroupSink.add(ApiResponse.loading("Loading Data"));
    try {
      StudentGroupModel result = await this._studentRepository.fetchGroup(
        this.classRoomID
      );
      this.studentGroupSink.add(ApiResponse.completed(result));
    } catch (e) {
      this.studentGroupSink.add(ApiResponse.error("Error!!!"));
      print(e);
    }
  }

  void dispose() {
    this._studentGroupStreamController?.close();
  }
}
