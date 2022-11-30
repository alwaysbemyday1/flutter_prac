import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  var bodyHome = [];
  var statusCode = 200;

  getData() async {
    var response = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json/daay'));
    if (response.statusCode == 200) {
      print('HTTP get success ✅');
      setState(() {
        bodyHome = jsonDecode(response.body);
      });
    } else {
      statusCode = response.statusCode;
      print('HTTP got error ❌');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar,
      body: Home(bodyHome: bodyHome, statusCode: statusCode),
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

class Home extends StatelessWidget {
  const Home({super.key, this.bodyHome, this.statusCode});
  final bodyHome;
  final statusCode;

  @override
  Widget build(BuildContext context) {
    if (statusCode == 200) {
      return ListView.builder(
          itemCount: bodyHome.length,
          itemBuilder: ((context, index) {
            var post = bodyHome[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post['user']),
                  SizedBox(child: Image.network(post['image'])),
                  Text('${post['likes'].toString()} likes'),
                  Text(post['content']),
                  Text(post['date']),
                ],
              ),
            );
          }));
    } else {
      return Center(
          child: Text(
        '잘못된 요청',
        style: TextStyle(color: Colors.black),
      ));
    }
  }
}
