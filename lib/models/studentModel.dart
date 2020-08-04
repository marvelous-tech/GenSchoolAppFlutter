import 'package:flutter/material.dart';

class Student extends StatelessWidget {
  final String name;
  final int roll;
  final String groupName;
  final String programName;

  Student(this.name, this.roll, this.groupName, this.programName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              color: Colors.black12,
              child: Text("Name: ${this.name}"),
            ),
            Card(
              color: Colors.black12,
              child: Text("Roll: ${this.roll}"),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Program Name: ${this.programName}"),
            Text("Roll: ${this.roll}"),
          ],
        ),
      ],
    );
  }
}
