// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qualuga/screens/main_screen.dart';
import 'package:qualuga/themes/MainTheme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: getThemeData(),
    title: "qualuga",
    home: MainScreen(),
  ));
}
