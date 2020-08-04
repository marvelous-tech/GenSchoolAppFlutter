import 'package:flutter/material.dart';
import 'package:bd_class/HomePageContents/InstituteCardWidget.dart';


class InstituteWidget extends StatelessWidget {
  final String schoolName;
  final int year;
  final String type;
  final String eiinCode;

  InstituteWidget({this.schoolName, this.type, this.year, this.eiinCode});

  @override
  Widget build(BuildContext context) {
    return InstituteCardWidget(
      schoolName: this.schoolName,
      type: this.type,
      year: this.year,
      eiinCode: this.eiinCode,
    );
  }
}
