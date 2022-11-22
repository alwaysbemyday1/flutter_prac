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
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('toni_erdmann.jpeg',),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            maxLines: 2,overflow : TextOverflow.ellipsis,
                            '캐논 DSLR 100D (단렌즈, 충전기 16기가 SD 포함', textAlign: TextAlign.left,),
                        )
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Container(child: Text('성동구 행당동', textAlign: TextAlign.left,)),
                            Container(child: Text('끌올 10분 전', textAlign: TextAlign.left,)),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(child: Text('210,000원', textAlign: TextAlign.left,))),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(child: Icon(Icons.heart_broken)),
                            Container(child: Text('4'))
                          ],
                        ),
                      )
                    ],
                      )
                    ],
                  ),
            ]
          )
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
