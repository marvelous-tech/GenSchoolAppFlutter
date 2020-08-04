import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassPage.dart';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:intl/intl.dart';

class ClassRoomListView extends StatelessWidget {
  final List<ClassRoomModel> classRoomList;

  ClassRoomListView({this.classRoomList});

  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: ListView.builder(
        itemCount: this.classRoomList.length,
        itemBuilder: (context, n) {
          ClassRoomModel classRoom = this.classRoomList[n];
          return Card(
            elevation: 0.1,
            color: bulkListCardBackgroundDefault,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                height: double.infinity,
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.white24))),
                child: this.getIcon(Icons.blur_linear),
              ),
              title: Text(
                classRoom.className,
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
                        DateFormat.yMMMd()
                            .format(DateTime.parse(classRoom.created)),
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' by ${classRoom.instructorName}',
                        style: TextStyle(
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                  Text('${classRoom.courseName}'),
                ],
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClassPage(
                      instructorName: classRoom.instructorName,
                      courseName: classRoom.courseName,
                      created: DateFormat.yMMMEd().add_jm().format(DateTime.parse(classRoom.created).add(Duration(hours: 6))),
                      total: classRoom.total.roundToDouble(),
                      classRoomId: classRoom.id,
                      classRoomName: classRoom.className,
                      instructorSubject: classRoom.instructorSubject,
                      instructorDesignation: classRoom.instructorDesignation,
                      classRoomUniqueName: classRoom.classRoomName,
                    )));
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
}
