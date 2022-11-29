import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  var contactList = [];
  var person;

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      setState(() {
        contactList = contacts;
      });
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
      openAppSettings();
    }
  }

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
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Friends',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                child: Text(
                  '(${contactList.length})',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    contactList.sort((a, b) => a.compareTo(b));
                  });
                },
                icon: Icon(
                  Icons.sort_by_alpha,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: (() {
                  getPermission();
                }),
                icon: Icon(
                  Icons.contact_mail,
                  color: Colors.black,
                ))
          ],
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: navBar,
        body: ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            return ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(contactList[index].givenName),
                minLeadingWidth: 10,
                trailing: PopupMenuButton(
                  child: Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(child: Text('Block')),
                      PopupMenuItem(
                          onTap: () {
                            setState(() {
                              contactList.remove(contactList[index]);
                            });
                          },
                          child: Text('Delete')),
                    ];
                  },
                ));
          },
        ));
  }
}

class VarCalcDialog extends StatefulWidget {
  VarCalcDialog({super.key, this.addList});
  final addList;

  @override
  State<VarCalcDialog> createState() => _VarCalcDialogState();
}

class _VarCalcDialogState extends State<VarCalcDialog> {
  var inputData = '';
  var heightVar = 200.0;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          width: 300,
          height: heightVar,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('연락처 추가'),
              TextField(
                onChanged: (value) {
                  inputData = value;
                },
              ),
              Visibility(
                visible: _isVisible,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Please type a name',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    if (inputData != '') {
                      var newContact = new Contact();
                      newContact.givenName = inputData;
                      await ContactsService.addContact(newContact);
                      // widget.addList(inputData);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        heightVar = 225;
                        _isVisible = true;
                      });
                    }
                  },
                  child: Text('Add'))
            ],
          )),
    );
  }
}

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
