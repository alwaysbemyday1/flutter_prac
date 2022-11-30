import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0.3,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            actionsIconTheme: IconThemeData(color: Colors.black))),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar,
      body: null,
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
