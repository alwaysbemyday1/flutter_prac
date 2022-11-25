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
  var numlist = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: topBar,
      bottomNavigationBar: navBar,
      body: ListView.builder(
        itemCount: userlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(numlist[index].toString()),
            title: Text(userlist[index]),
            trailing: TextButton(
                onPressed: () {
                  setState(() {
                    numlist[index]++;
                  });
                },
                child: Text('좋아요')),
          );
        },
      ),
    ));
  }
}

var contactStructure = ListTile(
  leading: Icon(Icons.account_circle),
  title: Text('홍길동'),
);

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
