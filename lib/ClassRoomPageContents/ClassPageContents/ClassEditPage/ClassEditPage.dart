import 'package:flutter/material.dart';
import 'package:bd_class/theme/appBar.dart';

import 'ClassForm.dart';


class ClassEditPage extends StatelessWidget {
  final String classRoomName;
  final int classRoomID;
  final int classID;
  final String lessoneName;
  final String description;
  final String link;
  final String taken;

  ClassEditPage({
    @required this.classRoomName, 
    @required this.classRoomID, 
    this.classID, 
    this.lessoneName, 
    this.description, 
    this.link, 
    this.taken
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThemed("Edit Class"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Class Room: ${this.classRoomName}",
                style: TextStyle(
                    fontSize: 21
                ),
              ),
              SizedBox(height: 30,),
              ClassEditForm(
                lessonName: this.lessoneName,
                classDescription: this.description,
                classLink: this.link,
                taken: this.taken,
                classRoomId: this.classRoomID, 
                classID: this.classID
              ),
            ],
          ),
        ),
      ),
    );
  }
}
