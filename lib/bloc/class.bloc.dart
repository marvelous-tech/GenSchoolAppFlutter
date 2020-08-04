import 'dart:async';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/repository/class.repository.dart';
import 'package:bd_class/utils/apiResponse.dart';

class ClassBloc {
  final int classRoomId;

  ClassRepository _classRepository;

  StreamController _classStreamController;

  StreamSink<ApiResponse<List<Class>>> get classSink =>
      this._classStreamController.sink;

  Stream<ApiResponse<List<Class>>> get classStream =>
      this._classStreamController.stream;

  ClassBloc({this.classRoomId}) {
    this._classRepository = ClassRepository();
    this._classStreamController = StreamController<ApiResponse<List<Class>>>();
    this.fetchClassList();
  }

  fetchClassList() async {
    this.classSink.add(ApiResponse.loading("Loading data from cloud"));
    try {
      List<Class> result = await this._classRepository.fetchClassList(this.classRoomId);
      this.classSink.add(ApiResponse.completed(result));
    } catch (e) {
      this.classSink.add(ApiResponse.error("Error occurred"));
      print(e);
    }
  }

  dispose() {
    this._classStreamController?.close();
  }
}