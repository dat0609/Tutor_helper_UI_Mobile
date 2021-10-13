import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tutor_helper/constants/strings.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/courses.dart';
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
        log(jsonString);
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

  void createCourseByRequest(var token, String title, String description,
      int tutorId, int tutorrequestId) async {
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
    await http.post(
      Uri.parse(Strings.createCourses),
      headers: headers,
      body: body,
    );
  }

  void acceptTutorRequest(var token, int tutorid, int tutorrequestid,
      int studentid, int gradeid, String title, String description) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "tutorRequestId": tutorrequestid,
      "title": title,
      "description": description,
      "status": false,
      "studentId": studentid,
      "gradeId": gradeid
    });
    var response = await http.put(Uri.parse(Strings.tutorrequests_url),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      API_Manager().createCourseByRequest(
          token, title, description, tutorid, tutorrequestid);
    } else {
      log("Error while accept TutorRequest");
    }
  }
}
