import 'package:flutter/material.dart';
// import 'package:task1/api/photoApiService.dart';
import 'package:task1/api/postApiService.dart';
import 'package:task1/models/post.dart';

class PostListProvider extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<List<Post>> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      _posts = await PostApiService.getPosts();
      return _posts;
    } catch (error) {
      print(error);
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
