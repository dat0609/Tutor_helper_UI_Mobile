// ignore_for_file: camel_case_types

import 'dart:convert';
// ignore: unused_import
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tutor_helper/constants/strings.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/courses.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/model/students.dart';
import 'package:tutor_helper/model/subjects.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/model/tutorcourses.dart';

class API_Management {
  //API for Tutor Only!!
  Future<TutorRequests> getAllTutorRequests(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + token.toString()
    };
    var response =
        await http.get(Uri.parse(Strings.tutorrequests_url), headers: headers);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return TutorRequests.fromJson(jsonMap);
    } else {
      throw Exception('Error while get TutorRequests');
    }
  }

  Future<TutorRequests> getTutorRequestsBySubjectId(
      String token, int subjectId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + token.toString()
    };
    var response = await http.get(
        Uri.parse(Strings.get_tutorrequests_by_subject_id_url(subjectId)),
        headers: headers);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return TutorRequests.fromJson(jsonMap);
    } else {
      throw Exception('Error while get TutorRequests');
    }
  }

  void createCourseByRequest(var token, String title, String description,
      int tutorId, int tutorrequestId, int studentId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "title": title,
      "description": description,
      "linkUrl": "",
      "status": true,
      "tutorId": tutorId,
      "tutorRequestId": tutorrequestId,
      "studentId": studentId
    });
    await http.post(
      Uri.parse(Strings.create_course),
      headers: headers,
      body: body,
    );
  }

  void acceptTutorRequest(
      var token,
      int tutorId,
      int tutorrequestId,
      int studentId,
      int gradeid,
      String title,
      String description,
      int subjectId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "tutorRequestId": tutorrequestId,
      "title": title,
      "description": description,
      "status": "Accepted",
      "studentId": studentId,
      "gradeId": gradeid,
      "subjectId": subjectId,
    });
    var response = await http.put(Uri.parse(Strings.tutorrequests_url),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      API_Management().createCourseByRequest(
          token, title, description, tutorId, tutorrequestId, studentId);
    } else {}
  }

  Future<TutorCourses> getTutorByTutorID(var token, int tutorId) async {
    var response = await http.get(
      Uri.parse(Strings.tutors_get_url(tutorId)),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return TutorCourses.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Course');
    }
  }

  void deleteCourse(var token, int courseId, String title, String description,
      int tutorId, int tutorRequestId, int studentId, String linkUrl) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "courseId": courseId,
      "title": title,
      "description": description,
      "linkUrl": linkUrl,
      "status": false,
      "tutorId": tutorId,
      "tutorRequestId": tutorRequestId,
      "studentId": studentId,
    });
    await http.put(Uri.parse(Strings.courses_url),
        headers: headers, body: body);
  }

  void createClass(var token, int courseId, String title, String description,
      String startTime, String endTime, int tutorId, int studentId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "title": title,
      "description": description,
      "status": true,
      "courseId": courseId,
      "startTime": startTime,
      "endTime": endTime,
      "tutorID": tutorId,
      "studentId": studentId,
    });
    await http.post(Uri.parse(Strings.class_url), headers: headers, body: body);
  }

  Future<Classes> getAllClasses(var token) async {
    var response = await http.get(
      Uri.parse(Strings.class_for_calendar_url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return Classes.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Classes');
    }
  }

  void updateClass(var token, int classId, int courseId, String title,
      String description, String startTime, String endTime, bool status) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "id": classId,
      "title": title,
      "description": description,
      "startTime": startTime,
      "endTime": endTime,
      "status": status,
      "courseId": courseId
    });
    await http.put(Uri.parse(Strings.class_url), headers: headers, body: body);
  }

  Future<Subjects> getSubjects(var token) async {
    var response = await http.get(
      Uri.parse(Strings.subject_url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return Subjects.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Subjects');
    }
  }

  Future<StudentCourses> getStudentBystudentId(var token, int studentId) async {
    var response = await http.get(
      Uri.parse(Strings.student_get_url(studentId)),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return StudentCourses.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Students');
    }
  }

  void deleteRequest(var token, int tutorRequestId, String title,
      String description, int studentId, int gradeId, int subjectId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "tutorRequestId": tutorRequestId,
      "title": title,
      "description": description,
      "status": "Deleted",
      "studentId": studentId,
      "gradeId": gradeId,
      "subjectId": subjectId,
    });
    await http.put(Uri.parse(Strings.create_request_url),
        headers: headers, body: body);
  }

  void updateTutorProfile(var token, int tutorId, String email, String fullName,
      String phoneNumber, String imagePath) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "tutorId": tutorId,
      "email": email,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "imagePath": imagePath
    });
    await http.put(Uri.parse(Strings.tutor_put_url),
        headers: headers, body: body);
  }

//API for Student Only!!
  void createRequest(var token, String title, String description, int studentId,
      int gradeId, int subjectId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "title": title,
      "description": description,
      "status": "Pending",
      "studentId": studentId,
      "gradeId": gradeId,
      "subjectId": subjectId,
    });
    await http.post(Uri.parse(Strings.create_request_url),
        headers: headers, body: body);
  }

  Future<Coursess> getCourseBystudentId(var token, int studentId) async {
    var response = await http.get(
      Uri.parse(Strings.get_courses_by_studentId_url(studentId)),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return Coursess.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Students');
    }
  }

  void updateStudentProfile(
      var token,
      int studentId,
      String email,
      String fullName,
      String phoneNumber,
      int schoolId,
      int gradeId,
      String imagePath) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "studentId": studentId,
      "email": email,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "schoolId": schoolId,
      "gradeId": gradeId,
      "imagePath": imagePath,
    });
    await http.put(Uri.parse(Strings.student_put_url),
        headers: headers, body: body);
  }
//API for both

  Future<Subjects> getSubjectByGrade(var token, int gradeId) async {
    var response = await http.get(
      Uri.parse(Strings.get_subject_by_grade_id(gradeId)),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return Subjects.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Subjects');
    }
  }
}
