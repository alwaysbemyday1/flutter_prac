import 'package:flutter/material.dart';
import 'package:instagram/tabs/account/profile_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.userName});
  final userName;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: () {
              model.logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ProfileBody(),
    );
  }
}

class ProfileProviderStore extends ChangeNotifier {
  bool followingState = false;
  int followingNum = 0;

  startFollowing() {
    followingState = true;
    followingNum++;
    notifyListeners();
  }

  stopFollowing() {
    followingState = false;
    followingNum--;
    notifyListeners();
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.getProfileImageUrl()),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.bottomRight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: FloatingActionButton(
                            onPressed: null,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: FloatingActionButton(
                            onPressed: null,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                model.getNickName(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Column(
            children: const [
              Text(
                '3',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '게시물',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Column(
            children: const [
              Text(
                '0',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '팔로워',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Column(
            children: const [
              Text(
                '0',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '팔로잉',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
