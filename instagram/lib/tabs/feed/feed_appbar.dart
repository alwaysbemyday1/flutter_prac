import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/tabs/posting/creating_page.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import './feed_page.dart' as feed;
import './posting_page.dart' as posting;

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeedAppBar({super.key, this.userId});
  final userId;

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Instagram'),
      actions: [
        IconButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const CreatingPage())));
            },
            icon: Icon(
              Icons.add_box_outlined,
            ))
      ],
    );
  }
}
