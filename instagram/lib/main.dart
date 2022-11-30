import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.blue),
        appBarTheme: AppBarTheme(color: Colors.grey),
      ),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.black,
              ))
        ],
        elevation: 0.3,
        backgroundColor: Colors.white,
      ),
      body: null,
    );
  }
}
