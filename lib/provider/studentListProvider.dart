import 'package:flutter/material.dart';
import 'package:task1/models/student.dart';
import 'package:task1/api/studentApiService.dart';

class StudentListProvider with ChangeNotifier {
  List<dynamic>? _students;

  List<dynamic> get students {
    return _students ?? [];
  }

  Future<void> fetchStudents({List<String> selectedFilters = const []}) async {
    try {
      if (selectedFilters.isEmpty) {
        _students = await StudentApiService.getStudents();
      } else {
        _students = await StudentApiService.getStudents(
            selectedFilters: selectedFilters);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> updateStudent(Student updatedStudent) async {
    try {
      await StudentApiService.updateStudent(updatedStudent);
      final index = _students?.indexWhere((student) =>
          student.registrationMainId == updatedStudent.registrationMainId);
      if (index != null && index != -1) {
        _students![index] = updatedStudent;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteStudent(int registrationMainId) async {
    try {
      await StudentApiService.deleteStudent(registrationMainId);
      final index = _students?.indexWhere(
          (student) => student.registrationMainId == registrationMainId);
      if (index != null && index != -1) {
        _students?.removeAt(index);
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> addStudent(Student newStudent) async {
    try {
      await StudentApiService.insertStudent(newStudent);

      final latestStudents = await StudentApiService.getStudents();

      final maxRegistrationMainId = latestStudents
          .map((student) => student.registrationMainId)
          .fold(0,
              (previousValue, id) => id > previousValue ? id : previousValue);

      newStudent.registrationMainId = maxRegistrationMainId + 1;

      newStudent.createdTime = DateTime.now().toString();

      _students?.insert(0, newStudent);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
