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
          children: [
            Icon(Icons.person_add),
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
