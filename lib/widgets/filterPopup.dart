import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Students'),
      content: DropdownButtonFormField<String>(
        items: const [
          DropdownMenuItem(
            value: 'Staff1',
            child: Text('Staff1'),
          ),
          DropdownMenuItem(
            value: 'ManagerR',
            child: Text('ManagerR'),
          ),
          DropdownMenuItem(
            value: 'Counsellor1',
            child: Text('Counsellor1'),
          ),
          DropdownMenuItem(
            value: 'admin1',
            child: Text('admin1'),
          ),
          DropdownMenuItem(
            value: 'Student202',
            child: Text('Student202'),
          ),
        ],
        onChanged: (value) => Navigator.pop(context, value),
        decoration: InputDecoration(
          labelText: 'Select User Code',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
