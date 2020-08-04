import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bd_class/models/course.model.dart';
import 'package:intl/intl.dart';

class CourseListView extends StatelessWidget {

  final List<CourseModel> courses;

  CourseListView({this.courses});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: this.courses.length,
        itemBuilder: (context, index) {
          DateTime date = DateTime.parse(courses[index].created);
          CourseModel course = this.courses[index];
          return Card(
            elevation: 0.1,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                dense: true,
                onTap: () {},
                leading: this.getIcon(Icons.folder_open, 35),
                title: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    course.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'by ' + course.instructorName
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                          DateFormat.yMMMMd('en_US').add_jm().format(date).toString()
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getIcon(IconData iconName, double size) {
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
    Container icon = Container(
      height: double.infinity,
      child: Icon(iconName, color: color, size: size)
    );
    return icon;
  }
}
