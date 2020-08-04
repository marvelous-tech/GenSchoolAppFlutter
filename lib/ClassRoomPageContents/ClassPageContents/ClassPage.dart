import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassAddPage/ClassAddPage.dart';
import 'package:bd_class/bloc/class.bloc.dart';
import 'package:bd_class/messages/messages.dart';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:bd_class/utils/apiResponse.dart';

import 'class.list.view.dart';

class ClassPage extends StatefulWidget {
  final String instructorName;
  final String courseName;
  final String created;
  final double total;
  final int classRoomId;
  final String classRoomName;
  final String instructorSubject;
  final String instructorDesignation;
  final String classRoomUniqueName;

  ClassPage({
    @required this.instructorName,
    @required this.courseName,
    @required this.created,
    @required this.total,
    @required this.classRoomId, 
    @required this.classRoomName, 
    @required this.instructorSubject, 
    @required this.instructorDesignation, 
    @required this.classRoomUniqueName,
  });

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  LoginService _loginService = LoginService();
  bool isStudent = true;

  ClassBloc _bloc;
  Class newClass;
  List<Class> classes;

  @override
  void initState() {
    this.setIsStudent();
    this._bloc = ClassBloc(classRoomId: this.widget.classRoomId);
    classes = [];
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //this.view(classes, instructor, course, created, total)
    return Scaffold(
      key: this._scaffoldKey,
      floatingActionButton: this.isStudent == false ? SpeedDial(
            tooltip: 'Actions',
            overlayOpacity: 0.5,
            shape: CircleBorder(),
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            children: <SpeedDialChild>[
              SpeedDialChild(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                label: "Add new class",
                labelStyle: TextStyle(
                  color: Colors.grey[800]
                ),
                onTap: () => this._navigateToAddScreen(context),
                child: Icon(Icons.note_add)
              ),
            ],
          ) : null,
      appBar: appBarThemed("Classes"),
      backgroundColor: foreground,
      body: RefreshIndicator(
        onRefresh: () async {this._bloc.fetchClassList();},
              child: StreamBuilder(
          stream: _bloc.classStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case Status.COMPLETED:
                  this.classes = snapshot.data.data;
                  return this.view(
                    classes: this.classes,
                    instructorName: this.widget.instructorName,
                    instructorSubject: this.widget.instructorSubject,
                    instructorDesignation: this.widget.instructorDesignation,
                    classRoomName: this.widget.classRoomName,
                    courseName: this.widget.courseName,
                    created: this.widget.created,
                    total: this.widget.total,
                    classRoomID: this.widget.classRoomId,
                    classRoomUniqueName: this.widget.classRoomUniqueName
                  );
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

  Widget view({
    List<Class> classes, 
    String instructorName, 
    String instructorSubject,
    String instructorDesignation,
    String classRoomName,
    String courseName, 
    String created, 
    double total,
    int classRoomID,
    String classRoomUniqueName,
  }) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Classes on $classRoomName',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    Text(
                      'by $instructorName',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Created $created',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClassListView(
            classes: classes,
            total: total == null ? 0.0 : total,
            classRoomName: classRoomName,
            instructorName: instructorName,
            instructorSubject: instructorSubject,
            instructorDesignation: instructorDesignation,
            courseName: courseName,
            classRoomID: classRoomID,
            classRoomUniqueName: classRoomUniqueName,
          )
        ],
      ),
    );
  }

  void _navigateToAddScreen(BuildContext context) async {
    Class result = await Navigator.push(context,
        MaterialPageRoute<Class>(builder: (BuildContext context) => new ClassAddPage(
          classRoomName: this.widget.classRoomName,
          classRoomID: this.widget.classRoomId,
        ), fullscreenDialog: true)
    );
    if (result != null) {
      this.setState(() {
        this.classes.insert(0, result);
      });
      _scaffoldKey.currentState
          .showSnackBar(
        SnackBar(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SuccessMsgText(
                msg: "Successfully Added"
            ),
          ),
        ),
      );
    }
  }

  void setIsStudent() async {
    await this._loginService.isStudent.then((isStudent) => this.setState(() {
      if (isStudent == true) this.isStudent = true;
      else this.isStudent = false;
    }));
  }

  @override
  void dispose() {
    this._bloc.dispose();
    super.dispose();
  }
}
