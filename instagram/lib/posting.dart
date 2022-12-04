import 'package:flutter/material.dart';

class PostingPageArguments {
  final userImage;
  PostingPageArguments(this.userImage);
}

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  static const routeName = '/posting';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PostingPageArguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Posting'),
      ),
      body: Column(
        children: [args.userImage],
      ),
    );
  }
}
