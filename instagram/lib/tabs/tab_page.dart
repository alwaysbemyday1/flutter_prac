import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:instagram/tabs/account/account_page.dart';
import 'package:instagram/tabs/feed/feed_page.dart';
import 'package:instagram/tabs/searching/searching_page.dart';
import 'package:instagram/tabs/shopping/shopping_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  final _pages = const [
    FeedPage(),
    SearchingPage(),
    ShoppingPage(),
    AccountPage(),
    ProfileScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
      ],
      avatarSize: 24,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'shopping_bag'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
