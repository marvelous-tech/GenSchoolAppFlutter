import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassDetailPage/attendancePieChart.dart';
import 'package:bd_class/ClassRoomPageContents/ClassPageContents/ClassEditPage/ClassEditPage.dart';
import 'package:bd_class/messages/messages.dart';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/models/user.model.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:bd_class/theme/colors.dart';
import 'package:bd_class/ui/views/attendance/attendance_view.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'AttendanceAddPage/AttendanceAddPage.dart';
import 'package:string_validator/string_validator.dart';

class ClassDetailPage extends StatefulWidget {
  final String classRoomName;
  final String courseName;
  final String instructorName;
  final String instructorSubject;
  final String instructorDesignation;
  final double total;
  final String classLink;
  final String lessonName;
  final String taken;
  final String classRoomUniqueName;
  final String classPlatform;
  final double presents;
  final int classRoomID;
  final String classDescription;

  final int classID;

  final int index;

  ClassDetailPage(
      {@required this.classRoomName,
      @required this.courseName,
      @required this.instructorName,
      @required this.instructorSubject,
      @required this.instructorDesignation,
      @required this.total,
      @required this.lessonName,
      @required this.taken,
      @required this.classRoomUniqueName,
      @required this.classPlatform,
      @required this.presents,
      @required this.classRoomID,
      @required this.classID,
      @required this.index,
      @required this.classDescription,
      @required this.classLink});

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double presents;

  YoutubePlayerController _controller;

  LoginService _loginService = LoginService();
  User _user;
  bool isStudent = true;

  ClassAddModel _class;
  String youtubeID;

  @override
  void initState() {
    this.getUser();
    this._class = ClassAddModel(
        classDescription: this.widget.classDescription,
        lessonName: this.widget.lessonName,
        classLink: this.widget.classLink,
        taken: this.widget.taken);
    this.presents = this.widget.presents;
    this.setIsStudent();
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    if (isURL(this.widget.classLink)) {
      print(this._class.classLink);
      this.youtubeID = YoutubePlayer.convertUrlToId(this._class.classLink);
      print(this.youtubeID);
    }
    this.youtubeID = this.youtubeID;
    if (this.youtubeID != null) {
      this._controller = YoutubePlayerController(
        initialVideoId: this.youtubeID,
        flags: YoutubePlayerFlags(
            autoPlay: false, mute: false, controlsVisibleAtStart: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("student is ${this.isStudent.toString()}");
    return Scaffold(
      floatingActionButton: this.isStudent == false
          ? SpeedDial(
              tooltip: 'Actions',
              overlayOpacity: 0.5,
              shape: CircleBorder(),
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              children: <SpeedDialChild>[
                SpeedDialChild(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    label: "Add attendance",
                    labelStyle: TextStyle(color: Colors.grey[800]),
                    onTap: () => navigateToAddAttendance(context),
                    child: Icon(Icons.group_add)),
                SpeedDialChild(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    labelStyle: TextStyle(color: Colors.grey[800]),
                    label: "Edit this class",
                    onTap: () => navigateToEditClass(context),
                    child: Icon(Icons.edit)),
              ],
            )
          : null,
      key: this._scaffoldKey,
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              navigateBack(context);
            }),
        backgroundColor: foreground,
        title: Text(
          "Class",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 1,
            fontFamily: 'PatrickHand',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var device = MediaQuery.of(context);
        var maxHeight = constraints.maxHeight;
        var maxWidth = constraints.maxWidth;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: foreground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )),
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            this.widget.courseName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 75, bottom: 10, left: 50, right: 50),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      color: Color(0xff0c907d),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    this._class.lessonName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    this.widget.classRoomName,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Center(
                                  child: Text(
                                    DateFormat.yMMMd().add_jm().format(
                                        DateTime.parse(this._class.taken)
                                            .add(Duration(hours: 6))),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.5),
                      child: Text(
                        this.widget.instructorName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "${this.widget.instructorDesignation}, ${this.widget.instructorSubject}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: foreground,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.5),
                          child: Text(
                            "Class Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.5),
                          child: Text(
                            "Marvelous Meet",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: RaisedButton(
                              elevation: 8.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4,
                                  vertical: 10),
                              onPressed: () {
                                _joinMeeting();
                              },
                              color: blue,
                              child: Text(
                                'Go to class',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.5),
                      child: Text(
                        "Class description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SelectableText(
                      "${this._class.classDescription}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              this.youtubeID != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Class Video (Youtube)",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SelectableText(
                                "${this._class.classLink}",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        YoutubePlayer(
                          liveUIColor: Colors.red[900],
                          progressColors: ProgressBarColors(
                              backgroundColor: Colors.blueGrey,
                              bufferedColor: Colors.grey[500],
                              playedColor: Colors.blueGrey[800],
                              handleColor: Colors.blue[800]),
                          controller: this._controller,
                          progressIndicatorColor: blue,
                          showVideoProgressIndicator: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : SizedBox(),
              Center(
                child: Text(
                  this.presents != 0 ? "Attendance" : "No Attendance is issued",
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              this.presents != 0
                  ? Container(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendanceView(
                                    classId: this.widget.classID))),
                        child: AttendancePieChart(
                          presents: this.presents,
                          absents: this.widget.total - (this.presents),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      })),
    );
  }

  void _joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags =
      {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid)
      {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      else if (Platform.isIOS)
      {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = this.widget.classRoomUniqueName // Required, spaces will be trimmed
        ..serverURL = "https://meet.marvelous-tech.com"
        ..subject = this.widget.lessonName
        ..userDisplayName = this._user.firstName + " " + this._user.lastName
        ..userEmail = this._user.email
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void navigateToAddAttendance(BuildContext context) async {
    int result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return AttendanceAddPage(
                classRoomID: this.widget.classRoomID,
                classID: this.widget.classID,
              );
            },
            fullscreenDialog: true));

    if (result != null)
      this.setState(() {
        this.presents = result.toDouble();
      });
  }

  void navigateToEditClass(BuildContext context) async {
    ClassAddModel result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return ClassEditPage(
                classID: this.widget.classID,
                lessoneName: this._class.lessonName,
                description: this._class.classDescription,
                link: this._class.classLink,
                taken: this._class.taken,
                classRoomID: this.widget.classRoomID,
                classRoomName: this.widget.classRoomName,
              );
            },
            fullscreenDialog: true));

    if (result != null) {
      this.setState(() {
        print(result.toJson().toString());
        this._class = result;
        if (isURL(this.widget.classLink)) {
          print(this._class.classLink);
          this.youtubeID = YoutubePlayer.convertUrlToId(this._class.classLink);
          print(this.youtubeID);
        }
        this.youtubeID = this.youtubeID == null ? "empty" : this.youtubeID;
        if (this.youtubeID != null) {
          this._controller = YoutubePlayerController(
            initialVideoId: this.youtubeID,
            flags: YoutubePlayerFlags(
                autoPlay: false, mute: false, controlsVisibleAtStart: true),
          );
        }
      });
      this._scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SuccessMsgText(msg: "Class has been updated"),
            ),
          ));
    }
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  void setIsStudent() async {
    await this._loginService.isStudent.then((isStudent) => this.setState(() {
          if (isStudent == true)
            this.isStudent = true;
          else
            this.isStudent = false;
        }));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  void getUser() async {
    await this._loginService.thisUser.then((value) => this.setState(() {
          this._user = value;
        }));
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
