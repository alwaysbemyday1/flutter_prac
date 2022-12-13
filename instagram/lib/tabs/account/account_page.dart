import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/tabs/account/login_page.dart';
import 'package:instagram/tabs/account/profile_page.dart';

final auth = FirebaseAuth.instance;

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: ((context) {
      if (auth.currentUser?.uid == null) {
        return LoginPage();
      } else {
        return ProfilePage();
      }
    })));
  }
}
