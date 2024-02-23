import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/models/post.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future:
            Provider.of<PostListProvider>(context, listen: false).fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
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
          } else {
            return Center(
              child: Text('No posts found.'),
            );
          }
        },
      ),
    );
  }
}
