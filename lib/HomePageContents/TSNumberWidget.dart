import 'package:flutter/material.dart';
import 'package:bd_class/theme/colors.dart';


class TSNumberWidget extends StatelessWidget {
  final int teachersNumber;
  final int studentsNumber;

  TSNumberWidget({this.studentsNumber, this.teachersNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      elevation: 8,
      color: blue,
      child: IntrinsicHeight(
        child: Row(
          children: [
            infoCards('Teachers', this.teachersNumber, 1),
            VerticalDivider(
              color: Colors.black54,
            ),
            infoCards('Students', this.studentsNumber, 1),
          ],
        ),
      ),
    );
  }

  Widget infoCards(String name, int number, int flex) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30, 15.0, 30.0),
          child: Column(
            children: [
              Text(
                number.toString().replaceAllMapped(
                    new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'
                ),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    letterSpacing: 1.0,
                    color: Colors.blueGrey[100],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
