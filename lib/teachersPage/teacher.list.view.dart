import 'package:flutter/material.dart';
import 'package:bd_class/models/teacher_model.dart';
import 'package:bd_class/theme/appBar.dart';
import 'package:bd_class/theme/colors.dart';

class TeacherListView extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  final List<TeacherModel> teachers;

  TeacherListView(this.teachers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: foreground,
      appBar: appBarThemed("Instructors"),
      body: this.fullView(context, teachers),
    );
  }

  Widget fullView(BuildContext context, List<TeacherModel> teachers) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Flexible(
                child: this.view(context, teachers),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget view(BuildContext context, List<TeacherModel> teachers) {
    print(teachers);
    int items = teachers.length - 1;
    List<Widget> cards = [];
    while (items >= 0) {
      TeacherModel teacher = teachers[items];
      cards.add(Card(
        elevation: 0.1,
        color: bulkListCardBackgroundDefault,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/teacher-detail',
                arguments: {
                  'data': teacher,
                },
              );
            },
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 9.0),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue[700],
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                backgroundImage: teacher.gender == 'f'
                    ? AssetImage('avatars/teacherFemalAvatar2.png')
                    : AssetImage('avatars/teacherMaleAvatar2.png'),
              ),
            ),
            title: Text(
              teacher.firstName + ' ' + teacher.lastName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  teacher.subject,
                  style: TextStyle(fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(5.0, 5.0)),
                      color: Colors.black38),
                  child: Text(
                    '@' + teacher.instructorAccount,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                        fontSize: 12.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
      items--;
    }
    return ListView(
      children: cards,
    );
  }
}
