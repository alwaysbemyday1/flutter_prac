import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/tabs/feed/feed_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/tabs/account/profile_page.dart';
import './feed_appbar.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeedAppBar(
        userId: auth.currentUser?.uid,
      ),
      body: Builder(builder: ((context) {
        if (auth.currentUser?.uid != null) {
          print('가입해요');
          return GuidingBody();
        } else {
          print('가입된 유저예요');
          return MainBody();
        }
      })),
    );
  }
}

final auth = FirebaseAuth.instance;

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

  saveData(data) async {
    var storage = await SharedPreferences.getInstance();

    var map = data;
    storage.setString('map', jsonEncode(map));

    var result1 = storage.getString('map') ?? 'no data';
    print(jsonDecode(result1));
    storage.remove('map');
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
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
                                ProfilePage(userName: post['user'])),
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
                                    builder: ((context) => ProfilePage(
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

class GuidingBody extends StatelessWidget {
  const GuidingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = HomeModel();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Instagram 에 오신 것을 환영합니다',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          const Text('사진과 동영상을 보려면 팔로우하세요'),
          const SizedBox(height: 20),
          Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.getProfileImageUrl()),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model.getEmail(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(model.getNickName()),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202207/31/d399eb2b-154e-4585-bdbb-b8a86939577c.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 4),
                      Image.network(
                        'http://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/01/05/0vU4v7vCfjju637769738893922804.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 4),
                      Image.network(
                        'https://pbs.twimg.com/profile_images/1374979417915547648/vKspl9Et_400x400.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Facebook 친구'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('팔로우'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
