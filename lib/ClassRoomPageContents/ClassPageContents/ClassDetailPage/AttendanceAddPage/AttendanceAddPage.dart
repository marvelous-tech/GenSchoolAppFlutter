import 'package:flutter/material.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassDetailPage/AttendanceAddPage/AttendanceAction.dart';
import 'package:bd_class/bloc/student.bloc.dart';
import 'package:bd_class/models/student.models.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:bd_class/utils/apiResponse.dart';

class AttendanceAddPage extends StatefulWidget {
  final int classRoomID;
  final int classID;

  AttendanceAddPage({@required this.classRoomID, this.classID});

  @override
  _AttendanceAddPageState createState() => _AttendanceAddPageState();
}

class _AttendanceAddPageState extends State<AttendanceAddPage> {

  StudentGroupBloc _bloc;

  @override
  void initState() {
    this._bloc = StudentGroupBloc(classRoomID: this.widget.classRoomID);
    super.initState();
  }

  @override
  void dispose() {
    this._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: foreground,
      appBar: appBarThemed("Add attendance"),
      body: SafeArea(
        child: StreamBuilder(
          stream: this._bloc.studentGroupStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case Status.COMPLETED:
                  StudentGroupModel _studentGroup = snapshot.data.data;
                  var result = AttendanceAction( // TODO: add attendance edit ability
                    studentIDs: _studentGroup.students, 
                    classID: this.widget.classID,
                  );
                  print(result);
                  return result;
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
          },
        ),
      ),
    );
  }
}
