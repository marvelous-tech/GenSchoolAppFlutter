import 'package:flutter/material.dart';
import 'package:bd_class/HomePageContents/PrincipalCardWidget.dart';


class PrincipalWidget extends StatelessWidget {
  final String name;

  PrincipalWidget({this.name});

  @override
  Widget build(BuildContext context) {
    return PrincipalCardWidget(
      name: this.name,
    );
  }
}
