import 'dart:convert';

import 'package:task1/models/photo.dart';
import 'package:http/http.dart' as http;

class PhotoApiService {
  static Future<List<Photo>> getPhotos() async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/photos"),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        // Create a List<Photo> from the JSON data
        final result = data.map((json) => Photo.fromJson(json)).toList();
        print(result);
        return result;
      } else {
        throw Exception("Failed to fetch photos: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching photos: $error");
    }
  }
}
