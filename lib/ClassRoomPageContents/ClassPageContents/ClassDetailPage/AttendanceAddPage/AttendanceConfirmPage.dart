import 'package:flutter/material.dart';
import 'package:bd_class/models/attendance.model.dart';
import 'package:bd_class/models/student.models.dart';
import 'package:bd_class/repository/attendance.repository.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:intl/intl.dart';

class AttendanceConfirmPage extends StatefulWidget {
  final List<int> issuedAttendance;
  final List<int> selectedIDs;
  final List<StudentModel> studentIDs;
  final int p;
  final int a;
  final int classID;

  AttendanceConfirmPage(
    this.issuedAttendance, this.selectedIDs, this.studentIDs, this.p, this.a, this.classID
  );

  @override
  _AttendanceConfirmPageState createState() => _AttendanceConfirmPageState();
}

class _AttendanceConfirmPageState extends State<AttendanceConfirmPage> {

  AttendanceRepository _attendanceRepository;

  @override
  void initState() {
    this._attendanceRepository = AttendanceRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThemed("Confirm attendance"),
      body: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Summary",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Presents: ${this.widget.p}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        "Absents: ${this.widget.a}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Total: ${this.widget.studentIDs.length}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                      flex: 2,
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
                          child: getStatus(
                            n, this.widget.p
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
                    child: Text("Submit"),
                    onPressed: () {
                      onConfirm(context);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getStatus(int n, int p) {
    return CircleAvatar(
      foregroundColor: Colors.white,
      backgroundColor: n < p ? Colors.green : Colors.red,
      child: n < p ? Text("P") : Text("A"),
    );
  }

  void onConfirm(BuildContext context) async {
    DateTime now = DateTime.now();
    String date = "${now.year}-${now.month}-${now.day}";
    AttendanceAddModel attendanceAddModel = AttendanceAddModel(
      issueDate: date,
      studentsAdd: this.widget.issuedAttendance,
    );
    await this._attendanceRepository.issueAttendance(this.widget.classID, attendanceAddModel)
    .then(
      (response) {
        print("Add Attendance statusCode: " + response.statusCode.toString());
        if (response.statusCode == 201) {
          Navigator.pop(context, this.widget.p);
        }
      }
    );
  }
}

