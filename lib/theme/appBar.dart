import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBarThemed(label) {
  return AppBar(
    title: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        letterSpacing: 1,
        fontFamily: 'PatrickHand',
      ),
    ),
    elevation: 0.0,
    centerTitle: true,
  );
}
