import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/screens/filterScreen.dart';
import 'package:task1/models/student.dart';
import 'package:task1/provider/studentListProvider.dart';
import 'package:task1/student_item.dart';
import 'package:task1/widgets/searchBar.dart';
// import 'package:task1/widgets/studentSearch.dart';

class AdmissionListPage extends StatefulWidget {
  @override
  _AdmissionListPageState createState() => _AdmissionListPageState();
}

class _AdmissionListPageState extends State<AdmissionListPage> {
  late Student s;
  int registrationMainId = 0;
  String userCode = '';
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String phoneNumber = '';
  String phoneCountryCode = '';
  String email = '';
  String createdTime = '';
  List<String> selectedFilters = [];
  late List<dynamic> students;
  late bool isFilterApplied;
  late String selectedSortCriteria;
  final List<String> sortCriteria = [
    'First Name',
    'Last Name',
    'Phone Number',
    'Email',
    'Created Time',
  ];

  @override
  void initState() {
    super.initState();
    selectedSortCriteria = sortCriteria.first;
    isFilterApplied = false;
    final studentListProvider =
        Provider.of<StudentListProvider>(context, listen: false);
    studentListProvider.fetchStudents();
    students = studentListProvider.students;
  }

  void sortStudents() {
    setState(() {
      switch (selectedSortCriteria) {
        case 'First Name':
          students.sort((a, b) => a.firstName.compareTo(b.firstName));
          break;
        case 'Last Name':
          students.sort((a, b) => a.lastName.compareTo(b.lastName));
          break;
        case 'Phone Number':
          students.sort((a, b) => a.phoneNumber.compareTo(b.phoneNumber));
          break;
        case 'Email':
          students.sort((a, b) => a.email.compareTo(b.email));
          break;
        case 'Created Time':
          students.sort((a, b) => a.createdTime.compareTo(b.createdTime));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admissions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterScreen(
                    currentFilters: selectedFilters,
                  ),
                ),
              );

              setState(() {
                selectedFilters = result;
                isFilterApplied = selectedFilters.isNotEmpty;
              });

              if (selectedFilters.isNotEmpty) {
                final studentListProvider =
                    Provider.of<StudentListProvider>(context, listen: false);
                studentListProvider.fetchStudents(
                  selectedFilters: selectedFilters,
                );
              }
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: (String value) {
              setState(() {
                selectedSortCriteria = value;
                sortStudents();
              });
            },
            itemBuilder: (BuildContext context) {
              return sortCriteria.map((String sortOption) {
                return PopupMenuItem<String>(
                  value: sortOption,
                  child: Text(sortOption),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(students: students),
          Expanded(
            child: Consumer<StudentListProvider>(
              builder: (context, studentListProvider, child) {
                students = studentListProvider.students;

                if (students.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final filteredStudents = selectedFilters.isNotEmpty
                      ? students
                          .where((student) =>
                              selectedFilters.contains(student.userCode))
                          .toList()
                      : students;

                  return ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.blue,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.edit, color: Colors.white),
                                Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Update Student'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'First Name'),
                                          controller: TextEditingController(
                                              text: student.firstName),
                                          onChanged: (value) {
                                            setState(() {
                                              firstName = value;
                                            });
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Middle Name'),
                                          controller: TextEditingController(
                                              text: student.middleName),
                                          onChanged: (value) {
                                            setState(() {
                                              middleName = value;
                                            });
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Last Name'),
                                          controller: TextEditingController(
                                              text: student.lastName),
                                          onChanged: (value) {
                                            setState(() {
                                              lastName = value;
                                            });
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'UserCode'),
                                          controller: TextEditingController(
                                              text: student.userCode),
                                          onChanged: (value) {
                                            setState(() {
                                              userCode = value;
                                            });
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Phone Number'),
                                          controller: TextEditingController(
                                              text: student.phoneNumber),
                                          onChanged: (value) {
                                            setState(() {
                                              phoneNumber = value;
                                            });
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Phone Country Code'),
                                          controller: TextEditingController(
                                              text: student.phoneCountryCode),
                                          onChanged: (value) {
                                            setState(() {
                                              phoneCountryCode = value;
                                            });
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Email'),
                                          controller: TextEditingController(
                                              text: student.email),
                                          onChanged: (value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        studentListProvider
                                            .updateStudent(Student(
                                          registrationMainId:
                                              student.registrationMainId,
                                          userCode: student.userCode,
                                          firstName: firstName.isEmpty
                                              ? student.firstName
                                              : firstName,
                                          middleName: middleName.isEmpty
                                              ? student.middleName
                                              : middleName,
                                          lastName: lastName,
                                          phoneNumber: phoneNumber.isEmpty
                                              ? student.phoneNumber
                                              : phoneNumber,
                                          phoneCountryCode:
                                              phoneCountryCode.isEmpty
                                                  ? student.phoneCountryCode
                                                  : phoneCountryCode,
                                          email: email.isEmpty
                                              ? student.email
                                              : email,
                                          createdTime: student.createdTime,
                                        ));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (direction == DismissDirection.endToStart) {
                            studentListProvider
                                .deleteStudent(student.registrationMainId);
                          }
                        },
                        child: Builder(
                          builder: (context) {
                            return StudentItem(student);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var studentListProvider =
              Provider.of<StudentListProvider>(context, listen: false);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AlertDialog(
                    title: const Text('Add Student'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration:
                                const InputDecoration(hintText: 'First Name'),
                            onChanged: (value) {
                              setState(() {
                                firstName = value;
                              });
                            },
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(hintText: 'Middle Name'),
                            onChanged: (value) {
                              setState(() {
                                middleName = value;
                              });
                            },
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(hintText: 'Last Name'),
                            onChanged: (value) {
                              setState(() {
                                lastName = value;
                              });
                            },
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(hintText: 'Phone Number'),
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                hintText: 'Phone Country Code'),
                            onChanged: (value) {
                              setState(() {
                                phoneCountryCode = value;
                              });
                            },
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(hintText: 'Email'),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        child: const Text("Add"),
                        onPressed: () {
                          s = Student(
                            registrationMainId: registrationMainId,
                            userCode: userCode,
                            firstName: firstName,
                            middleName: middleName,
                            lastName: lastName,
                            phoneNumber: phoneNumber,
                            phoneCountryCode: phoneCountryCode,
                            email: email,
                            createdTime: createdTime,
                          );
                          setState(() {
                            studentListProvider.addStudent(s);
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ))),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
