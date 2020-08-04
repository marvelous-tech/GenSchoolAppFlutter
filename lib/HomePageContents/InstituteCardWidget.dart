import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:bd_class/theme/colors.dart';


class InstituteCardWidget extends StatelessWidget {
  final String schoolName;
  final int year;
  final String type;
  final String eiinCode;

  InstituteCardWidget({this.schoolName, this.type, this.year, this.eiinCode});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      elevation: 8,
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.school,
                  color: Colors.blue,
                ),
                flex: 2,
              ),
              VerticalDivider(),
              Expanded(
                flex: 11,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schoolName,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.5),
                        child: Text(
                          'Since ' + year.toString(),
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.5),
                        child: Text(
                          'EIIN: ' + this.eiinCode,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
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
