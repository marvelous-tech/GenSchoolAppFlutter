import 'package:flutter/material.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassDetailPage/AttendanceAddPage/AttendanceConfirmPage.dart';
import 'package:bd_class/models/student.models.dart';
import 'package:bd_class/repository/attendance.repository.dart';
import 'package:bd_class/theme/colors.dart';

class AttendanceAction extends StatefulWidget {
  final List<StudentModel> studentIDs;
  final int classID;

  AttendanceAction({@required this.studentIDs, this.classID,});

  @override
  _AttendanceActionState createState() => _AttendanceActionState();
}

class _AttendanceActionState extends State<AttendanceAction> {
  Color buttonColor = Colors.red;
  List<bool> isSelected;
  List<int> selectedIDs;
  List<int> issuedIDs;
  List<StudentModel> presents;
  List<StudentModel> absents;
  List<StudentModel> finalList;

  AttendanceRepository _attendanceRepository;

  @override
  initState(){
    this.presents = [];
    this.absents = [];
    this.finalList = [];
    this.issuedIDs = [];
    this._attendanceRepository = AttendanceRepository();
    this.selectedIDs = List.filled(this.widget.studentIDs.length, 0);
    this.isSelected = List.filled(this.widget.studentIDs.length
    , false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          color: blue,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Center(child: Text("Status")),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("First name")),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("Class roll")),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: Text("Student ID")),
                )
              ],
            ),
          )
        ),
        Expanded(
          child: ListView.builder(
            itemCount: this.widget.studentIDs.length,
            itemBuilder: (context, n) {
              int iStudentID = this.widget.studentIDs[n].id;
              StudentModel student = this.widget.studentIDs[n];
              return Card(
                color: background,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Switch(
                          value: this.isSelected[n],
                          onChanged: (value) {
                            setState(() {
                              this.isSelected[n] = !this.isSelected[n];
                              if (this.selectedIDs[n] == iStudentID) {
                                this.selectedIDs[n] = 0;
                              } else {
                                this.selectedIDs[n] = iStudentID;
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(child: Text(student.firstName)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(child: Text(student.studentRoll)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(child: Text(student.studentId)),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                Spacer(),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  color: Colors.indigo,
                  child: Text("Confirm"),
                  onPressed: () {
                    List<int> presentIDs = [];
                    List<StudentModel> absents = [];
                    List<StudentModel> presents = [];
                    for(int i = 0; i < this.selectedIDs.length; i++) {
                      if(this.selectedIDs[i] != 0) {
                        presentIDs.add(this.selectedIDs[i]);
                        presents.add(this.widget.studentIDs[i]);
                      } else {
                        absents.add(this.widget.studentIDs[i]);
                      }
                    }
                    setState(() {
                      this.absents = [];
                      this.presents = [];
                      this.finalList = [];
                      this.issuedIDs.addAll(presentIDs);
                      this.presents.addAll(presents);
                      this.absents.addAll(absents);
                      this.finalList.addAll(this.presents);
                      this.finalList.addAll(this.absents);
                    });
                    onIssueAttendance(context);
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void onIssueAttendance(BuildContext context) async {
    int result = await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return AttendanceConfirmPage(
            this.issuedIDs,
            this.selectedIDs,
            this.finalList,
            this.presents.length,
            this.absents.length,
            this.widget.classID
          );
        }
    ));
    if (result != null)
      Navigator.pop(context, result);
  }
}
