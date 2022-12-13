import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchingPage extends StatelessWidget {
  const SearchingPage({super.key});

  final List<String> _urls = const [
    'https://pbs.twimg.com/profile_images/1374979417915547648/vKspl9Et_400x400.jpg',
    'http://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/01/05/0vU4v7vCfjju637769738893922804.jpg',
    'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202207/31/d399eb2b-154e-4585-bdbb-b8a86939577c.jpg',
    'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202207/31/d399eb2b-154e-4585-bdbb-b8a86939577c.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.create),
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(5.0),
            sliver: SliverToBoxAdapter(
              child: CupertinoSearchTextField(style: TextStyle(fontSize: 18)),
            ),
          ),
          SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              final url = _urls[index];
              return Image.network(
                url,
                fit: BoxFit.cover,
              );
            }, childCount: _urls.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            ),
          )
        ],
      )),
    );
  }
}
