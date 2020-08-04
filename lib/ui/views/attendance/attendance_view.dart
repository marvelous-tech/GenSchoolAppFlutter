import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bd_class/models/attendance.model.dart';
import 'package:bd_class/repository/attendance.repository.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';

class AttendanceView extends StatefulWidget {
  final int classId;

  AttendanceView({@required this.classId});

  @override
  _AttendanceViewState createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  bool isLoading = true;
  AttendanceRepository _attendanceRepository = AttendanceRepository();
  int _presents = 0;
  int _absents = 0;
  List<AttendanceModel> _attendanceListModel;

  @override
  void initState() {
    fetchAllAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThemed("Attendance"),
      body: SafeArea(
        child: this.isLoading != true ? Column(
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
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Presents: ${this._presents}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Absents: ${this._absents}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Total: ${this._attendanceListModel.length}",
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
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )),
            Expanded(
              child: ListView.builder(
                itemCount: this._attendanceListModel.length,
                itemBuilder: (context, n) {
                  AttendanceModel student = this._attendanceListModel[n];
                  return Card(
                    color: background,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: this.getStatus(n, this._presents),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(child: Text(student.name)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(child: Text(student.roll)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(child: Text(student.sId)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> fetchAllAttendance() async {
    setState(() {
      this.isLoading = true;
    });
    Iterable list;
    List<AttendanceModel> result;
    await this._attendanceRepository.fetchAllAttendance(this.widget.classId)
    .then((value) {
      if (value.statusCode == 200) {
        list = jsonDecode(value.body);
        result = list.map((e) => AttendanceModel.fromJson(e)).toList();
        this.isLoading = false;
      }
    });
    setState(() {
      this._attendanceListModel = result;
    });
    setTotalPresentAbsent();
  }

  void setTotalPresentAbsent() {
    setState(() {
      for (int i = 0; i < this._attendanceListModel.length; i++) {
        AttendanceModel attendanceModel = this._attendanceListModel[i];
        if (attendanceModel.was == true) this._presents++;
        else if (attendanceModel.was == false) this._absents++;
      }
    });
  }

  Widget getStatus(int n, int p) {
    return CircleAvatar(
      foregroundColor: Colors.white,
      backgroundColor: n < p ? Colors.green : Colors.red,
      child: n < p ? Text("P") : Text("A"),
    );
  }
}
