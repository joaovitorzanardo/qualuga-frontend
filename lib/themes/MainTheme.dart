// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData getThemeData() {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(0, 127, 255, 1),
          primary: Color.fromRGBO(0, 127, 255, 1),
          secondary: Color.fromRGBO(31, 31, 31, 1),
          tertiary: Colors.white),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 128,
              fontFamily: 'Gliker',
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal),
          titleMedium: TextStyle(
              fontSize: 100,
              fontFamily: 'Gliker',
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              fontSize: 30,
              fontFamily: 'Gliker',
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal),
          bodySmall: TextStyle(
              fontSize: 18,
              fontFamily: 'Gliker',
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal)),
      textButtonTheme: TextButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // <-- Radius
        )),
      ),
      inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(0, 127, 255, 1), width: 2.0))));
}
