import 'package:flutter/material.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassAddPage/ClassForm.dart';
import 'package:bd_class/theme/appBar.dart';


class ClassAddPage extends StatelessWidget {
  final String classRoomName;
  final int classRoomID;

  ClassAddPage({@required this.classRoomName, @required this.classRoomID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarThemed("Future Class"),
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
              ClassAddForm(classRoomId: this.classRoomID,),
            ],
          ),
        ),
      ),
    );
  }
}
