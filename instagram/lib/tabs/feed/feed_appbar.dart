import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
              if (userId != null) {
                final navigator = Navigator.of(context);
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  var userImage = File(image.path);
                  navigator.push(CupertinoPageRoute(
                      builder: ((context) => posting.PostingPage(
                            userImage: userImage,
                            insertData: context
                                .read<feed.MainProviderStore>()
                                .insertData,
                          ))));
                }
              }
            },
            icon: Icon(
              Icons.add_box_outlined,
            ))
      ],
    );
  }
}
