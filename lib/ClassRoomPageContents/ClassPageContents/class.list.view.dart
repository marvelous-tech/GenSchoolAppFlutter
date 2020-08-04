import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassDetailPage/ClassDetailPage.dart';
import 'package:bd_class/messages/messages.dart';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/repository/class.repository.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:intl/intl.dart';

class ClassListView extends StatefulWidget {
  final List<Class> classes;
  final double total;

  final String classRoomName;
  final int classRoomID;
  final String courseName;
  final String instructorName;
  final String instructorSubject;
  final String instructorDesignation;
  final String classRoomUniqueName;

  ClassListView({
    @required this.classes,
    @required this.total,
    @required this.classRoomName,
    @required this.courseName,
    @required this.instructorName,
    @required this.instructorSubject,
    @required this.instructorDesignation,
    @required this.classRoomID,
    @required this.classRoomUniqueName,
  });

  @override
  _ClassListViewState createState() => _ClassListViewState();
}

class _ClassListViewState extends State<ClassListView> {
  LoginService _loginService = LoginService();
  bool isStudent = true;

  ClassRepository _classRepository;
  double yMax;
  int cn;

  @override
  void initState() {
    this.setIsStudent();
    this.yMax = this.widget.total;
    cn = this.widget.classes.length;
    this._classRepository = ClassRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: this.widget.classes.length == 0 ? Container() : ListView.builder(
        itemCount: this.widget.classes.length,
        itemBuilder: (context, n) {
          Class iClass = widget.classes[n];
          return Card(
                  elevation: 0.1,
                  color: bulkListCardBackgroundDefault,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: ListTile(
                    onLongPress: this.isStudent == false
                        ? () {
                            print("Class ID: ${iClass.id}");
                            print("Index: $n");
                            return _onLongPressDelete(context, iClass.id,
                              this.widget.classRoomID, n, iClass.lessonName);
                          }
                        : null,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    leading: Container(
                      height: double.infinity,
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: this.getIcon(Icons.class_),
                    ),
                    title: Text(
                      iClass.lessonName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Scheduled ${DateFormat.yMMMd().format(DateTime.parse(iClass.taken).add(Duration(hours: 6)))}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                      color: Colors.white,
                    ),
                    onTap: () {
                      naivgateToClassDetailPage(context, iClass, n);
                    },
                  ),
                );
        },
      ),
    );
  }

  Icon getIcon(IconData iconName) {
    final _random = new Random();
    List<Color> colors = [
      Colors.blueAccent,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.white,
      Colors.cyanAccent,
      Colors.teal,
      Colors.green,
    ];
    Color color = colors[_random.nextInt(colors.length)];
    Icon icon = Icon(
      iconName,
      color: color,
      size: 30,
    );
    return icon;
  }

  void _onLongPressDelete(BuildContext context, int classId, int classRoomID,
      int index, String lessonName) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.white,
            title: Text(
              "Delete Action",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            content: Text(
              "Do you want to delete this class $lessonName ?",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              OutlineButton(
                borderSide: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  this.performDeleteClass(
                      classId, classRoomID, index, lessonName);
                  Navigator.pop(context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
            elevation: 8.0,
          );
        });
  }

  void performDeleteClass(
      int classId, int classRoomID, int index, String lessonName) async {
    await this._classRepository.deleteClass(classId, classRoomID);
    setState(() {
      this.widget.classes.removeAt(index);
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WarnMsgText(msg: "$lessonName was deleted"),
      ),
      duration: Duration(milliseconds: 1000),
    ));
  }

  void naivgateToClassDetailPage(
      BuildContext context, Class iClass, int index) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailPage(
              classLink: iClass.classLink,
              classRoomName: this.widget.classRoomName,
              lessonName: iClass.lessonName,
              courseName: this.widget.courseName,
              taken: iClass.taken,
              instructorName: this.widget.instructorName,
              instructorSubject: this.widget.instructorSubject,
              instructorDesignation: this.widget.instructorDesignation,
              classRoomUniqueName: this.widget.classRoomUniqueName,
              classPlatform: "Marvelous Meet",
              presents: iClass.attendance != null
                  ? iClass.attendance.total.roundToDouble()
                  : 0.0,
              total: this.widget.total,
              classRoomID: this.widget.classRoomID,
              classID: iClass.id,
              index: index,
              classDescription: iClass.classDescription
            )
          )
        );
      }

  void setIsStudent() async {
    await this._loginService.isStudent.then((isStudent) => this.setState(() {
          if (isStudent == true)
            this.isStudent = true;
          else
            this.isStudent = false;
        }));
  }
}
