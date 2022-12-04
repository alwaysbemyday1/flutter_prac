import 'package:flutter/material.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key, this.userImage});
  final userImage;

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostingAppBar(),
      body: Column(
        children: [Image.file(widget.userImage)],
      ),
    );
  }
}

class PostingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostingAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('Posting'),
      actions: [
        TextButton(
            onPressed: (() {}),
            child: Text(
              'Complete',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
