import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

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
  var bodyHome = {};

  getData() async {
    var response = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (response.statusCode == 200) {
      print('HTTP get success ✅');
      setState(() {
        bodyHome = jsonDecode(response.body);
      });
    } else {
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
      body: Home(bodyHome: bodyHome),
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

class Home extends StatefulWidget {
  const Home({super.key, this.bodyHome, this.statusCode});
  final bodyHome;
  final statusCode;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(() async {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        var response = await http
            .get(Uri.parse('https://codingapple1.github.io/app/more2.json'));
        if (response.statusCode == 200) {
          setState(() {
            widget.bodyHome.addAll([jsonDecode(response.body)]);
            print(widget.bodyHome);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bodyHome.isNotEmpty) {
      return ListView.builder(
          controller: scroll,
          itemCount: widget.bodyHome.length,
          itemBuilder: ((context, index) {
            var post = widget.bodyHome[index];
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
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
    }
  }
}
