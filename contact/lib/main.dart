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
              return contactStructure;
            }),
          ),
          bottomNavigationBar: navBar),
    );
  }
}

var contactStructure = ListTile(
  leading: Icon(Icons.account_circle),
  title: Text('홍길동'),
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
