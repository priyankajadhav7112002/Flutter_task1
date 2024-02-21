import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task1/models/student.dart';

class StudentApiService {
  static Future<List<Student>> getStudents(
      {List<String>? selectedFilters}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://glexas.com/hostel_data/API/raj/new_admission_list.php"),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['response'];

        // If filters are provided, filter the list of students
        if (selectedFilters != null && selectedFilters.isNotEmpty) {
          data = data
              .where((student) => selectedFilters.contains(student['userCode']))
              .toList();
        }

        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch students: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching students: $error");
    }
  }

  static Future<void> deleteStudent(int registrationMainId) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://glexas.com/hostel_data/API/raj/new_admission_delete.php"),
        body: {"registration_main_id": registrationMainId.toString()},
      );
      if (response.statusCode == 200) {
        // Student deleted successfully
      } else {
        throw Exception("Failed to delete student: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error deleting student: $error");
    }
  }

  static Future<void> insertStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://glexas.com/hostel_data/API/raj/new_admission_insert.php"),
        body: {
          "first_name": student.firstName,
          "middle_name": student.middleName,
          "last_name": student.lastName,
          "phone_number": student.phoneNumber,
          "phone_country_code": student.phoneCountryCode,
          "email": student.email
        },
      );
      if (response.statusCode == 200) {
        // Student inserted successfully
      } else {
        throw Exception("Failed to insert student: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error inserting student: $error");
    }
  }

  static Future<void> updateStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://glexas.com/hostel_data/API/raj/new_admission_update.php"),
        body: {
          "registration_main_id": student.registrationMainId.toString(),
          "first_name": student.firstName,
          "middle_name": student.middleName,
          "last_name": student.lastName,
          "phone_number": student.phoneNumber,
          "phone_country_code": student.phoneCountryCode,
          "email": student.email
        },
      );
      if (response.statusCode == 200) {
        // Student updated successfully
      } else {
        throw Exception("Failed to update student: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error updating student: $error");
    }
  }
}
