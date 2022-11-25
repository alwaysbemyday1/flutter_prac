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
  var a = 0;

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
                  print(a);
                  return VarCalcDialog(calcNum: a);
                }));
          },
        ),
        appBar: topBar,
        bottomNavigationBar: navBar,
        body: Center(
            child: Text(
          a.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80),
        )));
  }
}

class VarCalcDialog extends StatefulWidget {
  VarCalcDialog({super.key, this.calcNum});
  var calcNum;

  @override
  State<VarCalcDialog> createState() => _VarCalcDialogState();
}

class _VarCalcDialogState extends State<VarCalcDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.calcNum.toString()),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    setState((() {
                      widget.calcNum++;
                    }));
                    print(widget.calcNum);
                  },
                  child: Text('+ 1'))
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
