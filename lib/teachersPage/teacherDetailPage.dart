import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:bd_class/models/teacher_model.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherDetailPage extends StatefulWidget {
  @override
  _TeacherDetailPageState createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  Map<String, TeacherModel> data = {};
  TeacherModel teacher;
  bool hasSocial = false;

  _launchURL(String url) async {
    if (await canLaunch(teacher.facebook)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchFacebook() async {
    await _launchURL(teacher.facebook);
  }

  _launchTweeter() async {
    await _launchURL(teacher.tweeter);
  }

  _launchInstagram() async {
    await _launchURL(teacher.instagram);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    MediaQueryData deviceData = MediaQuery.of(context);

    teacher = this.data['data'];
    double avatarRadius = deviceData.size.width / 4;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              backgroundColor: backgroundColor,
              expandedHeight: deviceData.size.height / 2.3,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '${teacher.firstName} ${teacher.lastName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                background: Container(
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.blue[700],
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: avatarRadius - 3,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: avatarRadius - 3 - 3,
                            backgroundImage: teacher.gender == 'f'
                                ? AssetImage('avatars/teacherFemalAvatar2.png')
                                : AssetImage('avatars/teacherMaleAvatar2.png'),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            SliverSafeArea(
              sliver: SliverFillRemaining(
                hasScrollBody: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 2,
                        color: cardColorSecondary.withOpacity(.1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${teacher.designation}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                '${teacher.subject}',
                                style: TextStyle(
                                    color: Colors.amberAccent, fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        color: cardColorPrimary.withOpacity(.15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.mapMarkedAlt,
                                    size: 15.0,
                                    color: Colors.green,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                  ),
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.0),
                              ),
                              Text(
                                teacher.address,
                                style: TextStyle(color: Colors.blue[100]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        color: cardColorPrimary.withOpacity(.15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                        child: Padding(
                          padding: EdgeInsets.all(
                            15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.envelope,
                                size: 16.0,
                                color: Colors.red[300],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                              ),
                              Text(
                                teacher.email,
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Card(
                        elevation: 2,
                        color: cardColorSecondary.withOpacity(.1),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: this._getSocials(teacher),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getSocials(TeacherModel teacher) {
    List<Widget> socialWidgets = [];
    if (teacher.facebook != null)
      socialWidgets.add(IconButton(
        onPressed: _launchFacebook,
        icon: FaIcon(FontAwesomeIcons.facebook),
        color: Colors.blue[500],
      ));
    if (teacher.instagram != null)
      socialWidgets.add(IconButton(
        onPressed: _launchInstagram,
        icon: FaIcon(FontAwesomeIcons.instagram),
        color: Colors.deepOrange[700],
      ));
    if (teacher.tweeter != null)
      socialWidgets.add(IconButton(
        onPressed: _launchTweeter,
        icon: FaIcon(FontAwesomeIcons.twitter),
        color: Colors.lightBlueAccent,
      ));
    if (socialWidgets.length > 0) this.hasSocial = true;
    return socialWidgets;
  }
}
