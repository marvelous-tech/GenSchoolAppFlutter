import 'dart:async';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/repository/class.room.repository.dart';
import 'package:bd_class/utils/apiResponse.dart';

class ClassRoomBloc {
  ClassRoomRepository _classRoomRepository;

  StreamController _classRoomStreamController;

  StreamSink<ApiResponse<List<ClassRoomModel>>> get classRoomSink =>
      this._classRoomStreamController.sink;

  Stream<ApiResponse<List<ClassRoomModel>>> get classRoomStream =>
      this._classRoomStreamController.stream;

  ClassRoomBloc() {
    this._classRoomStreamController = StreamController<ApiResponse<List<ClassRoomModel>>>();
    this._classRoomRepository = ClassRoomRepository();
    this.fetchClassRoomList();
  }

  fetchClassRoomList() async {
    this.classRoomSink.add(ApiResponse.loading("Loading Data"));
    try {
      List<ClassRoomModel> results = await this._classRoomRepository.fetchClassRoomList();
      this.classRoomSink.add(ApiResponse.completed(results));
    } catch (e) {
      this.classRoomSink.add(ApiResponse.error("Error!!!"));
      print(e);
    }
  }

  dispose() {
    this._classRoomStreamController?.close();
  }
}
