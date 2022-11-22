import 'dart:html';

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
          backgroundColor: Colors.white,
          elevation: 0, //remove shadow from appbar
          toolbarHeight: 50,
          title: SizedBox(
            height: 30,
            width: 100,
            child: TextButton(
              child: Text('금호동3가🔽', style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
              onPressed: () {},
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.search, color: Colors.black,), onPressed: () {}),
            IconButton(icon: Icon(Icons.menu, color: Colors.black,), onPressed: () {}),
            IconButton(icon: Icon(Icons.notifications, color: Colors.black,), onPressed: () {}),
          ],
        ),
        body: Container(
          height: 150,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset('toni_erdmann.jpeg', width: 100, height: 100,),
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('카메라 팝니다', style: TextStyle(),
                    ),
                    Text('금호동 3가'),
                    Text('7000원'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite),
                        Text('4')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
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
        ),
      ),
    );
  }
}
