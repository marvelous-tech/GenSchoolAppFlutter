import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/CoursePageContents/course.list.view.dart';
import 'package:bd_class/bloc/course.bloc.dart';
import 'package:bd_class/models/course.model.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/utils/apiResponse.dart';

class CoursePageWidget extends StatefulWidget {
  @override
  _CoursePageWidgetState createState() => _CoursePageWidgetState();
}

class _CoursePageWidgetState extends State<CoursePageWidget> {
  CourseBloc _bloc;

  @override
  void initState() {
    this._bloc = CourseBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThemed("Courses"),
      body: StreamBuilder<ApiResponse<List<CourseModel>>>(
          stream: this._bloc.courseStream,
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
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Something went wrong!",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ));
                  return Container();
                  break;
              }
            }
            return Container();
          }),
    );
  }

  Widget view(List<CourseModel> courseData) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CourseListView(
          courses: courseData,
        ),
      ],
    ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
