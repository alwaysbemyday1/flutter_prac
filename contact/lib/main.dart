import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
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
          ),
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: ((context, index) {
              return ContactStructure;
            }),
          ),
          bottomNavigationBar: NavBar),
    );
  }
}

var ContactStructure = Container(
  padding: EdgeInsets.all(8),
  child: Row(
    children: [
      Container(
          height: 50,
          width: 50,
          child: Icon(
            Icons.account_circle,
            size: 40,
          )),
      Expanded(
          child: Text(
        '홍길동',
        textAlign: TextAlign.left,
      ))
    ],
  ),
);

var NavBar = BottomAppBar(
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
