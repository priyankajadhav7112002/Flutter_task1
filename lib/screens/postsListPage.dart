import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:task1/models/post.dart';
// import 'package:task1/provider/photoListProvider.dart';
import 'package:task1/provider/postListProvider.dart';
// import 'package:task1/widgets/photo_item.dart';
import 'package:task1/widgets/post_item.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late List<dynamic> posts;
  @override
  void initState() {
    super.initState();
    final photoListProvider =
        Provider.of<PostListProvider>(context, listen: false);
    photoListProvider.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Consumer<PostListProvider>(
        builder: (context, photoListProvider, child) {
          posts = photoListProvider.posts;
          if (posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostItem(
                  title: post.title,
                  body: post.body,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('UserId: ${post.userId}'),
                                Text('Id: ${post.id}'),
                                Text('Title: ${post.title}'),
                                Text('body: ${post.body}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
