import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userlist = ['김대연', '김소현', '김유민'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: topBar,
            bottomNavigationBar: navBar,
            body: Dialog(
              elevation: 0,
              backgroundColor: Colors.blue,
              child: Row(
                children: [
                  Icon(Icons.account_circle),
                  Text(
                    '김대연',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )));
  }
}

var topBar = AppBar(
  title: Text(
    '연락처',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  toolbarHeight: 50,
  elevation: 0,
  backgroundColor: Colors.white,
);

var navBar = BottomAppBar(
  child: SizedBox(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.phone),
        Icon(Icons.message),
        Icon(Icons.contact_page),
        Icon(Icons.person),
      ],
    ),
  ),
);
