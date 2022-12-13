import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    var readProvider = context.read<ProfileProviderStore>();
    var watchProvider = context.watch<ProfileProviderStore>();
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            watchProvider.followingState == false
                ? Icon(Icons.person_add)
                : Icon(Icons.person_remove),
            Text('팔로워 ${watchProvider.followingNum} 명'),
            TextButton(
              child: watchProvider.followingState == false
                  ? Text('Follow')
                  : Text('Following'),
              onPressed: () {
                if (watchProvider.followingState == false) {
                  readProvider.startFollowing();
                } else {
                  readProvider.stopFollowing();
                }
              },
            )
          ],
        )
      ],
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://pbs.twimg.com/profile_images/1374979417915547648/vKspl9Et_400x400.jpg'),
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
              const Text(
                '아이유',
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
