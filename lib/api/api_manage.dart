import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_helper/constants/strings.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/courses.dart';
import 'package:tutor_helper/model/getcourses.dart';
import 'package:tutor_helper/model/grades.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/model/tutors.dart';

class API_Manager {
  Future<Courses> getCourses(var token) async {
    var courseInfo;
    try {
      var response = await http.get(
        Uri.parse(Strings.courses_url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token.toString()
        },
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        courseInfo = Courses.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return courseInfo;
  }

  Future<Tutors> getTutors(var token) async {
    var tutorInfo;
    try {
      var response = await http.get(
        Uri.parse(Strings.tutors_url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token.toString()
        },
      );
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

  Future<TutorRequests> getTutorRequests(var token) async {
    var tutorrequestInfo;
    try {
      var response = await http.get(
        Uri.parse(Strings.tutorrequests_url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token.toString()
        },
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        tutorrequestInfo = TutorRequests.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return tutorrequestInfo;
  }

  Future<TutorRequests> getTutorRequestByID(var token, int id) async {
    var tutorrequestInfo;
    try {
      var response = await http.get(
        Uri.parse(Strings.tutorrequests_get_url(id)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token.toString()
        },
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        log(jsonMap.toString());
        tutorrequestInfo = TutorRequests.fromJson(jsonMap);
      }
    } catch (Exception) {
      (Exception.toString());
    }

    return tutorrequestInfo;
  }

  Future<GetCourses> createCourseByRequest(var token, String title,
      String description, int tutorId, int tutorrequestId) async {
    // var courseInfo;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "title": title,
      "description": description,
      "status": true,
      "tutorId": tutorId,
      "tutorRequestId": tutorrequestId
    });
    var response = await http.post(
      Uri.parse(Strings.createCourses),
      headers: headers,
      body: body,
    );
    log(response.statusCode.toString());
    return GetCourses.fromJson(jsonDecode(response.body));
  }

  Future<TutorRequests> acceptTutorRequest(var token, int id) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "tutorRequestId": id,
      "title": "string",
      "description": "string",
      "status": false,
      "studentId": 0,
      "gradeId": 0
    });
    var response = await http.put(Uri.parse(Strings.tutorrequests_url),
        headers: headers, body: body);

    return TutorRequests.fromJson(jsonDecode(response.body));
  }
}
