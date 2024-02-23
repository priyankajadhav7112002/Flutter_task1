import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onTap;

  const PostItem({
    Key? key,
    required this.title,
    required this.body,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: ListTile(
          title: Text(title),
          // subtitle: Text(body),
          onTap: onTap,
        ),
      ),
    );
  }
}
