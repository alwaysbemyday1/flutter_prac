import 'package:flutter/material.dart';
import './style.dart' as style;
import './posting.dart' as posting;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    theme: style.theme,
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      posting.PostingPage.routeName: (context) => const posting.PostingPage()
    },
    onGenerateRoute: (settings) {
    // If you push the PassArguments route
    if (settings.name == posting.PostingPage.routeName) {
      // Cast the arguments to the correct
      // type: ScreenArguments.
      final args = settings.arguments as posting.PostingPageArguments;

      // Then, extract the required data from
      // the arguments and pass the data to the
      // correct screen.
      return MaterialPageRoute(
        builder: (context) {
          return posting.PostingPageArguments(
            userImage: args.userImage,
          );
        },
      );
    }
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var bodyHome = [];

  addData(a) {
    setState(() {
      bodyHome.add(a);
    });
  }

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
      appBar: mainAppBar(context),
      body: HomeFeed(bodyHome: bodyHome, addData: addData),
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

PreferredSizeWidget mainAppBar(context) {
  return AppBar(
    title: Text('Instagram'),
    actions: [
      IconButton(
          onPressed: () async {
            var picker = ImagePicker();
            var image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              var userImage = File(image.path);
              print('image name : $userImage');
              Navigator.pushNamed(context, '/posting',
                  arguments: posting.PostingPageArguments(userImage));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: ((context) =>
              //             posting.PostingPage(userImage: userImage))));
            }
          },
          icon: Icon(
            Icons.add_box_outlined,
          ))
    ],
  );
}

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key, this.bodyHome, this.addData});
  final bodyHome;
  final addData;

  @override
  State<HomeFeed> createState() => _HomeState();
}

class _HomeState extends State<HomeFeed> {
  var scroll = ScrollController();
  var scrollNum = 0;
  var bodyHomeState = 1;

  getMore(scrollNum) async {
    var result = await http.get(
        Uri.parse('https://codingapple1.github.io/app/more$scrollNum.json'));
    if (result.statusCode == 200) {
      setState(() {
        bodyHomeState = 1;
      });
      var result2 = jsonDecode(result.body);
      widget.addData(result2);
    } else {
      setState(() {
        bodyHomeState = 0;
      });
      print('더이상 데이터가 없습니다');
    }
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        if (bodyHomeState == 1) {
          setState(() {
            scrollNum += 1;
            getMore(scrollNum);
            print(scrollNum);
          });
        } else if (bodyHomeState == 0) {
          print('아직 데이터가 전송되지 않았습니다.');
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
                  Text(
                    post['user'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(child: Image.network(post['image'])),
                  Text('${post['likes'].toString()} likes'),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: post['user'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        WidgetSpan(
                            child: SizedBox(
                          width: 5,
                        )),
                        TextSpan(
                          text: post['content'],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child:
                          Text(post['date'], style: TextStyle(fontSize: 12))),
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
