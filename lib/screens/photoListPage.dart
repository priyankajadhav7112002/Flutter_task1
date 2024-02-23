import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/provider/photoListProvider.dart';
import 'package:task1/widgets/photo_item.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({Key? key}) : super(key: key);

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PhotoListProvider>(context, listen: false).fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: Consumer<PhotoListProvider>(
        builder: (context, photoListProvider, child) {
          if (photoListProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (photoListProvider.photos.isEmpty) {
            return const Center(
              child: Text('No photos found.'),
            );
          } else {
            return ListView.builder(
              itemCount: photoListProvider.photos.length,
              itemBuilder: (context, index) {
                final photo = photoListProvider.photos[index];
                return PhotoItem(photo);
              },
            );
          }
        },
      ),
    );
  }
}
