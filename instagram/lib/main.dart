import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: style.theme,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar,
      body: null,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'Shopping'),
        ],
      ),
    );
  }
}

AppBar mainAppBar = AppBar(
  title: Text('Instagram'),
  actions: [
    IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.add_box_outlined,
        ))
  ],
);
