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
  var a = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                a++;
              });
            },
            backgroundColor: Colors.black,
            child: Text(
              a.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
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
