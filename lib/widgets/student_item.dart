import 'package:flutter/material.dart';
import 'package:task1/models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  StudentItem(this.student);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: ExpansionTile(
          title: Text('${student.firstName} ${student.lastName}'),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First Name: ${student.firstName}'),
                  Text('Middle Name: ${student.middleName}'),
                  Text('Last Name: ${student.lastName}'),
                  Text('UserCode: ${student.userCode}'),
                  Text('Email: ${student.email}'),
                  Text('Phone Number: ${student.phoneNumber}'),
                  Text('Phone Country Code: ${student.phoneCountryCode}'),
                  Text('Registration Main Id: ${student.registrationMainId}'),
                  Text('Created Time: ${student.createdTime}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
