import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final List<String> currentFilters;
  FilterScreen({required this.currentFilters});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    selectedFilters = List.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(selectedFilters);
          return true;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: selectedFilters.contains('Staff1'),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    selectedFilters.add('Staff1');
                  } else {
                    selectedFilters.remove('Staff1');
                  }
                });
              },
              title:
                  Text('Staff1', style: Theme.of(context).textTheme.titleLarge),
              contentPadding: const EdgeInsets.only(left: 18, right: 22),
            ),
            SwitchListTile(
              value: selectedFilters.contains('ManagerR'),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    selectedFilters.add('ManagerR');
                  } else {
                    selectedFilters.remove('ManagerR');
                  }
                });
              },
              title: Text('ManagerR',
                  style: Theme.of(context).textTheme.titleLarge),
              contentPadding: const EdgeInsets.only(left: 18, right: 22),
            ),
            SwitchListTile(
              value: selectedFilters.contains('Counsellor1'),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    selectedFilters.add('Counsellor1');
                  } else {
                    selectedFilters.remove('Counsellor1');
                  }
                });
              },
              title: Text('Counsellor1 ',
                  style: Theme.of(context).textTheme.titleLarge),
              contentPadding: const EdgeInsets.only(left: 18, right: 22),
            ),
            SwitchListTile(
              value: selectedFilters.contains('admin1'),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    selectedFilters.add('admin1');
                  } else {
                    selectedFilters.remove('admin1');
                  }
                });
              },
              title: Text('admin1  ',
                  style: Theme.of(context).textTheme.titleLarge),
              contentPadding: const EdgeInsets.only(left: 18, right: 22),
            ),
            SwitchListTile(
              value: selectedFilters.contains('Student202'),
              onChanged: (value) {
                setState(() {
                  if (value) {
                    selectedFilters.add('Student202');
                  } else {
                    selectedFilters.remove('Student202');
                  }
                });
              },
              title: Text('Student202',
                  style: Theme.of(context).textTheme.titleLarge),
              contentPadding: const EdgeInsets.only(left: 18, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
