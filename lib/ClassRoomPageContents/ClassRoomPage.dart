import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/ClassRoomPageContents/class.room.list.view.dart';
import 'package:bd_class/bloc/class.room.bloc.dart';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/utils/apiResponse.dart';


class ClassRoomPage extends StatefulWidget {
  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {

  ClassRoomBloc _bloc;

  @override
  void initState() {
    this._bloc = ClassRoomBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
          onRefresh: () async {this._bloc.fetchClassRoomList();},
          child: StreamBuilder<ApiResponse<List<ClassRoomModel>>>(
          stream: this._bloc.classRoomStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case Status.COMPLETED:
                  return this.view(snapshot.data.data);
                  break;
                case Status.ERROR:
                  return SnackBar(
                    content: Text(
                      "Something went wrong!",
                      style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  );
                  break;
              }
            }
            return Container();
          }
      ),
    );
  }

  Widget view(List<ClassRoomModel> classRoom) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Class Rooms",
              style: TextStyle(
                fontSize: 25.0,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
          ),
          ClassRoomListView(classRoomList: classRoom,)
        ],
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _bloc.dispose();
  }
}

