import 'package:flutter/material.dart';


class InfoMsgText extends StatelessWidget {
  final String msg;
  InfoMsgText({@required this.msg});

  Widget build(BuildContext context) {
    return Text(
        this.msg,
        style: TextStyle(
          color: Colors.blue[700],
          fontWeight: FontWeight.bold
        ),
      );
  }
}

class WarnMsgText extends StatelessWidget {
  final String msg;
  WarnMsgText({@required this.msg});
  @override
  Widget build(BuildContext context) {
    return Text(
        this.msg,
        style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold
        ),
      );
  }
}

class DangerMsgText extends StatelessWidget {
  final String msg;

  DangerMsgText({@required this.msg});

  @override
  Widget build(BuildContext context) {
    return Text(
        this.msg,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold
        ),
      );
  }
}

class SuccessMsgText extends StatelessWidget {
  final String msg;

  SuccessMsgText({@required this.msg});

  @override
  Widget build(BuildContext context) {
    return Text(
        this.msg,
        style: TextStyle(
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold
        ),
      );
  }
}


