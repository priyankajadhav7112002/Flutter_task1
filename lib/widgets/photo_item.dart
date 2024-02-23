import 'package:flutter/material.dart';
import 'package:task1/models/photo.dart';
import 'package:task1/screens/imageScreen.dart';

class PhotoItem extends StatelessWidget {
  final Photo photo;
  const PhotoItem(this.photo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: ListTile(
          leading: Image.network(
            photo.thumbnailUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(photo.title),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ImageScreen(imageUrl: photo.url),
              ),
            );
          },
        ),
      ),
    );
  }
}
