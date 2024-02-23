import 'package:flutter/material.dart';
// import 'package:task1/api/photoApiService.dart';
import 'package:task1/api/postApiService.dart';
// import 'package:task1/models/post.dart';

class PostListProvider extends ChangeNotifier {
  List<dynamic>? _posts = [];
  bool _isLoading = false;

  List<dynamic> get posts {
    return _posts ?? [];
  }

  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    try {
      _isLoading = true;

      _posts = await PostApiService.getPosts();
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
    }
    notifyListeners();
  }
}
