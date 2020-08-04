import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:bd_class/messages/messages.dart';
import 'package:bd_class/models/class.room.model.dart';
import 'package:bd_class/repository/class.repository.dart';
import 'package:bd_class/services/authentication/login.service.dart';
import 'package:smart_select/smart_select.dart';
import 'package:string_validator/string_validator.dart';

class ClassEditForm extends StatefulWidget {
  final int classRoomId;

  final String lessonName;
  final String classDescription;
  final String classLink;
  final String taken;

  final int classID;

  ClassEditForm({
    @required this.classRoomId,
    @required this.classDescription,
    @required this.lessonName,
    @required this.classLink,
    @required this.taken, 
    this.classID,
  });

  @override
  _ClassEditFormState createState() => _ClassEditFormState();
}

class _ClassEditFormState extends State<ClassEditForm> {

  List<SmartSelectOption<String>> options = [
    SmartSelectOption<String>(value: 'Facebook Live', title: 'Facebook Live'),
    SmartSelectOption<String>(value: 'Google Meet', title: 'Google Meet'),
    SmartSelectOption<String>(value: 'Skype Meeting', title: 'Skype Meeting'),
    SmartSelectOption<String>(value: 'Youtube Live', title: 'Youtube Live'),
    SmartSelectOption<String>(value: 'Facebook Video', title: 'Facebook Video'),
    SmartSelectOption<String>(value: 'Youtube Video', title: 'Youtube Video'),
    SmartSelectOption<String>(value: 'Zoom Meetings', title: 'Zoom Meetings'),
    SmartSelectOption<String>(value: 'Others', title: 'Others'),
  ];

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate;
  DateTime selectedTime;
  String dateTime;
  bool isLoading = false;
  LoginService _loginService;

  ClassRepository _classRepository;

  ClassAddModel _class;
  String lessonName = "";
  String classDescription = "";
  String classLink = "";
  String taken = "";

  @override
  void initState() {
    DateTime time = DateTime.parse(this.widget.taken).add(Duration(hours: 6));
    this.selectedDate = time;
    this.selectedTime = time;
    this._loginService = LoginService();
    this._class = ClassAddModel();
    super.initState();
    this._classRepository = ClassRepository();

    this.dateTime = ""
        "${this.selectedDate.year}-"
        "${this.selectedDate.month}-"
        "${this.selectedDate.day}T"
        "${this.selectedTime.hour}:"
        "${this.selectedTime.minute}"
        "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Container(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  initialValue: this.widget.lessonName,
                  decoration: InputDecoration(
                      labelText: 'Lesson Name', border: OutlineInputBorder()),
                  onSaved: (value) {
                    this.lessonName = value;
                  },
                  validator: (value) {
                    if (value.length < 2) {
                      return "Name length is minimum 2";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(DateTime.now().year + 1, DateTime.december, 31),
                            onChanged: (DateTime date) {}, onConfirm: (date) {
                            setState(() {
                              this.selectedDate = date;
                              this.dateTime = ""
                                  "${this.selectedDate.year}-"
                                  "${this.selectedDate.month}-"
                                  "${this.selectedDate.day}T"
                                  "${this.selectedTime.hour}:"
                                  "${this.selectedTime.minute}"
                                  "";
                              this.taken = dateTime;
                            });
                          }, currentTime: this.selectedDate, locale: LocaleType.en);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Scheduled Class',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                    ),
                    RaisedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          DatePicker.showTime12hPicker(context,
                            showTitleActions: true,
                            onChanged: (DateTime date) {}, onConfirm: (date) {
                            setState(() {
                              this.selectedTime = date;
                              this.dateTime = ""
                                  "${this.selectedDate.year}-"
                                  "${this.selectedDate.month}-"
                                  "${this.selectedDate.day}T"
                                  "${this.selectedTime.hour}:"
                                  "${this.selectedTime.minute}"
                                  "";
                              this.taken = dateTime;
                              });
                            }, currentTime: this.selectedTime, locale: LocaleType.en);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Pick a time',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: dateTime,
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: this.widget.classDescription,
                  maxLines: 10,
                  decoration: InputDecoration(
                      labelText: 'Class description for extra resource type as text', border: OutlineInputBorder()),
                  onSaved: (value) {
                    this.classDescription = value;
                  },
                  validator: (value) {
                    if (value.length < 2) {
                      return "Name length is minimum 2";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: this.widget.classLink,
                  decoration: InputDecoration(
                      hintText: "Youtube link",
                      labelText: 'Class Link (Youtube) [Optional]', border: OutlineInputBorder()),
                  onSaved: (value) {
                    this.classLink = value;
                  },
                  validator: (value) {
                    if (value.length == 0) return null;
                    else if (value.length > 0 && isURL(value) != true) {
                      return "Must be a valid link";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
                  child: RaisedButton(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      if (this._formKey.currentState.validate()) {
                        this.isLoading = true;
                        this._formKey.currentState.save();
                        this._class.lessonName = this.lessonName;
                        this._class.taken = this.dateTime;
                        this._class.classDescription = this.classDescription;
                        this._class.classLink = this.classLink;
                        this.onEditClass(_class, context, this._formKey);
                      }
                    },
                    child: Text(
                      'Upadate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEditClass(ClassAddModel _class, BuildContext context, GlobalKey<FormState> formKey) async {
    this.isLoading = true;
    Scaffold.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: InfoMsgText(msg: "Updating"),
      )
    );
    await this._classRepository.editClass(_class, this.widget.classRoomId, this.widget.classID)
    .then((value) {
      setState(() {
        this._class.taken = this.selectedDate
        .subtract(Duration(hours: this.selectedDate.hour, minutes: this.selectedDate.minute))
        .add(Duration(hours: this.selectedTime.hour, minutes: this.selectedTime.minute))
        .add(Duration(hours: 6))
        .toString();
      });
      Navigator.pop(context, this._class);
    })
    .catchError(
      (error) {
        Scaffold.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: DangerMsgText(msg: "Something went wrong!"),
            )
        );
      }
    );
  }

  void logout(context) {
    this._loginService.logout().then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/login", (Route<dynamic> route) => false);
      return null;
    });
  }

}
