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
  late List<dynamic> photos;
  @override
  void initState() {
    super.initState();
    final photoListProvider =
        Provider.of<PhotoListProvider>(context, listen: false);
    photoListProvider.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: Consumer<PhotoListProvider>(
        builder: (context, photoListProvider, child) {
          photos = photoListProvider.photos;
          if (photos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
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
