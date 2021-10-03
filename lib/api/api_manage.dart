import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_helper/constants/strings.dart';
import 'package:tutor_helper/model/areas.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/grades.dart';
import 'package:tutor_helper/model/students.dart';
import 'package:tutor_helper/model/tutors.dart';

class API_Manager {
  Future<Areas> getAreas() async {
    var client = http.Client();

    var areaInfo;
    try {
      var response = await client.get(Uri.parse(Strings.area_url));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        areaInfo = Areas.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return areaInfo;
  }

  Future<Grades> getGrades() async {
    var client = http.Client();

    var gradeInfo;
    try {
      var response = await client.get(Uri.parse(Strings.grade_url));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        gradeInfo = Grades.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return gradeInfo;
  }

  Future<Students> getStudents() async {
    var client = http.Client();

    var studentInfo;
    try {
      var response = await client.get(Uri.parse(Strings.student_url));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        studentInfo = Students.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return studentInfo;
  }

  Future<Tutors> getTutors() async {
    var client = http.Client();

    var tutorInfo;
    try {
      var response = await client.get(Uri.parse(Strings.tutor_url));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        tutorInfo = Tutors.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return tutorInfo;
  }
}
