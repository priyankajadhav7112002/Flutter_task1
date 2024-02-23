import 'package:flutter/material.dart';
import 'package:task1/api/photoApiService.dart';

class PhotoListProvider with ChangeNotifier {
  List<dynamic>? _photos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<dynamic> get photos {
    return _photos ?? [];
  }

  Future<void> fetchPhotos() async {
    try {
      _isLoading = true;
      notifyListeners();
      _photos = await PhotoApiService.getPhotos();
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
