import 'package:flutter/material.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key, this.userImage});
  final userImage;

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  var inputImage;
  var inputContent = '';
  var inputUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostingAppBar(),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 150,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(widget.userImage),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: TextField(
                      autofocus: true,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: '내용을 입력해주세요.',
                        labelText: '내용 입력',
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: '당신의 이름을 입력해주세요.',
                  labelText: '이름',
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                ),
              ),
            ),
          )
        ],
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
