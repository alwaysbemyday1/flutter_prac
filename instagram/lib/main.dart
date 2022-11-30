import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: style.theme,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar,
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: ((context, index) {
            return posting;
          })),
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

Column posting = Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Writer'),
    SizedBox(
        child: Image.asset(
      'images/Leica_m3.png',
    )),
    Text('100 likes'),
    Row(
      children: [Text('Writer'), Text('내용')],
    ),
  ],
);
