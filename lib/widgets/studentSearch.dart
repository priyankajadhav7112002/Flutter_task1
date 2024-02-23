import 'package:flutter/material.dart';
import 'package:task1/models/student.dart';
import 'package:task1/widgets/student_item.dart';

class StudentSearch extends SearchDelegate<Student> {
  final List<dynamic> students;

  StudentSearch({required this.students});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
            context,
            Student(
              registrationMainId: students.first.registrationMainId,
              userCode: students.first.userCode,
              firstName: students.first.firstName,
              middleName: students.first.middleName,
              lastName: students.first.lastName,
              phoneNumber: students.first.phoneNumber,
              phoneCountryCode: students.first.phoneCountryCode,
              email: students.first.email,
              createdTime: students.first.createdTime,
            )); // Use the defaultStudent method
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = students
        .where((element) =>
            element.firstName.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(child: Text('No results found for "$query"'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var student = results[index];
        return ListTile(
          title: Text(student.firstName),
          onTap: () {
            close(context, student);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Student Details'),
                  ),
                  body: StudentItem(student),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? students
        : students
            .where((element) =>
                element.firstName.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        var student = suggestionList[index];
        return ListTile(
          title: Text(student.firstName),
          onTap: () {
            close(context, student);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Student Details'),
                  ),
                  body: StudentItem(student),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
