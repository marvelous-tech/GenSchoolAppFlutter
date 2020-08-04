import 'package:flutter/material.dart';
import 'package:bd_class/bloc/teacher.bloc.dart';
import 'package:bd_class/models/teacher_model.dart';
import 'package:bd_class/teachersPage/teacher.list.view.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/utils/apiResponse.dart';

class TeachersPage extends StatefulWidget {
  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  bool isLoading = true;
  TeacherBloc _bloc;

  @override
  void initState() {
    this._bloc = TeacherBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<TeacherModel>>>(
      stream: _bloc.teacherListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case Status.COMPLETED:
              return TeacherListView(snapshot.data.data);
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
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
