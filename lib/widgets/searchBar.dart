import 'package:flutter/material.dart';
// import 'package:task1/models/student.dart';
import 'package:task1/widgets/studentSearch.dart';

class SearchBarWidget extends StatefulWidget {
  final List<dynamic> students;

  const SearchBarWidget({required this.students});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for students...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: StudentSearch(students: widget.students),
                );
              },
            ),
          ),
          onTap: () {
            showSearch(
              context: context,
              delegate: StudentSearch(students: widget.students),
            );
          },
        ),
      ),
    );
  }
}
