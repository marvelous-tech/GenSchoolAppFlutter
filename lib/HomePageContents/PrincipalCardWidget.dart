import 'package:flutter/material.dart';
import 'package:bd_class/theme/colors.dart';


class PrincipalCardWidget extends StatelessWidget {
  final String name;

  PrincipalCardWidget({this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      elevation: 8,
      color: red,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style:  TextStyle(
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.perm_identity,
                      color: Colors.white,
                      size: 13.0,
                    ),
                  ),
                  Text(
                    'Principal',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
