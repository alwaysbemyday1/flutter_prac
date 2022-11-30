import 'package:flutter/material.dart';

var theme = ThemeData(
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.3,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        actionsIconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.grey)));
