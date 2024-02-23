import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/models/post.dart';

class PostApiService {
  static Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        // Create a List<Photo> from the JSON data
        final result = data.map((json) => Post.fromJson(json)).toList();
        // print(result);
        return result;
      } else {
        throw Exception("Failed to fetch posts: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching posts: $error");
    }
  }
}
