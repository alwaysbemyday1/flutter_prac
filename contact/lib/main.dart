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
  var contactList = ['김점득', '배임숙'];
  var person;

  addList(person) {
    setState(() {
      contactList.add(person);
    });
  }

  @override
  build(context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Text(
            '+',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: ((context) {
                  return VarCalcDialog(addList: addList);
                }));
          },
        ),
        appBar: topBar,
        bottomNavigationBar: navBar,
        body: ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(contactList[index]),
            );
          },
        ));
  }
}

class VarCalcDialog extends StatelessWidget {
  VarCalcDialog({super.key, this.addList});
  final addList;
  var inputData = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('연락처 추가'),
              TextField(
                onChanged: (value) {
                  print(value);
                  inputData = value;
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    addList(inputData);
                    Navigator.pop(context);
                  },
                  child: Text('Add'))
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
