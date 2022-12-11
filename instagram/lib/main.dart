import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './style.dart' as style;
import './posting.dart' as posting;
import './profile.dart' as profile;
import './notification.dart' as notification;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:io';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MainProviderStore(),
      ),
      ChangeNotifierProvider(
          create: ((context) => profile.ProfileProviderStore())),
    ],
    child: MaterialApp(
      theme: style.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/posting': (context) => posting.PostingPage(),
        '/profile': (context) => profile.ProfilePage()
      },
    ),
  ));
}

class MainProviderStore extends ChangeNotifier {
  var bodyHome = [];

  addData(a) {
    bodyHome.add(a);
    notifyListeners();
  }

  insertData(a) {
    bodyHome.insert(0, a);
    notifyListeners();
  }

  getData() async {
    var response = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (response.statusCode == 200) {
      print('HTTP get success ✅');
      bodyHome = jsonDecode(response.body);
    } else {
      print('HTTP got error ❌');
    }
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  saveData(data) async {
    var storage = await SharedPreferences.getInstance();

    var map = data;
    storage.setString('map', jsonEncode(map));
    // var result = storage.get('map');
    // print(jsonDecode(result));
    // jsonDecode() 는 string을 인자로 받음. but! storage.get()의 return 값은 object
    // => get자료형의 형태로 사용
    var result1 = storage.getString('map') ?? 'no data';
    print(jsonDecode(result1));
    storage.remove('map');
  }

  @override
  void initState() {
    super.initState();
    print(context);
    notification.initNotifications(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MainProviderStore>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: HomeFeed(),
      floatingActionButton: FloatingActionButton(
          child: Text('+'),
          onPressed: () {
            notification.showNotification2();
          }),
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

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Instagram'),
      actions: [
        IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                var userImage = File(image.path);
                print('image name : $userImage');
                navigator.push(CupertinoPageRoute(
                    builder: ((context) => posting.PostingPage(
                          userImage: userImage,
                          insertData:
                              context.read<MainProviderStore>().insertData,
                        ))));
              }
            },
            icon: Icon(
              Icons.add_box_outlined,
            ))
      ],
    );
  }
}

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

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
      print(result2);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<MainProviderStore>(context, listen: false).addData(result2);
      });
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
    var bodyHome = context.watch<MainProviderStore>().bodyHome;
    if (bodyHome.isNotEmpty) {
      return ListView.builder(
          controller: scroll,
          itemCount: bodyHome.length,
          itemBuilder: ((context, index) {
            var post = bodyHome[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text(
                      post['user'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    onTap: () {
                      var navigator = Navigator.of(context);
                      navigator.push(PageRouteBuilder(
                        pageBuilder:
                            ((context, animation, secondaryAnimation) =>
                                profile.ProfilePage(userName: post['user'])),
                        transitionDuration: Duration(milliseconds: 250),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                SlideTransition(
                          position: Tween(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset(0.0, 0.0))
                              .animate(animation),
                          child: child,
                        ),
                      ));
                    },
                  ),
                  SizedBox(
                      child: post['image'].toString().startsWith('https')
                          ? Image.network(post['image'])
                          : Image.file(post['image'])),
                  Text('${post['likes'].toString()} likes'),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: post['user'],
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                var navigator = Navigator.of(context);
                                navigator.push(CupertinoPageRoute(
                                    builder: ((context) => profile.ProfilePage(
                                          userName: post['user'],
                                        ))));
                              },
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
