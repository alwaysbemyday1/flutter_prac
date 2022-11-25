import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var a = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Text(
            'D',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return VarCalcDialog();
                }));
          },
        ),
        appBar: topBar,
        bottomNavigationBar: navBar,
        body: Center(
            child: Text(
          'Hi',
          style: TextStyle(fontSize: 50),
        )));
  }
}

class VarCalcDialog extends StatelessWidget {
  const VarCalcDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(onPressed: () {}, child: Text('OK'))
            ],
          )),
    );
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
