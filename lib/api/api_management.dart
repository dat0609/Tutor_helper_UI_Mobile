import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tutor_helper/constants/strings.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:tutor_helper/model/tutors.dart';

class API_Management {
  void createCourses(var token, int courseid, String title, String description,
      int tutorid, int tutorrequestid, int studentid) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "title": title,
      "description": description,
      "status": true,
      "studentId": studentid,
      "tutorId": tutorid,
      "tutorRequestId": tutorrequestid
    });
    var response = await http.get(
      Uri.parse(Strings.courses_url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
  }

  Future<TutorRequests> getAllTutorRequests(String token) async {
    var tutorrequestInfo;
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer " + token.toString()
      };
      var response = await http.get(Uri.parse(Strings.tutorrequests_url),
          headers: headers);
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

  void acceptTutorRequest(
      var token,
      int tutorid,
      int tutorrequestid,
      int studentid,
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
      "tutorRequestId": tutorrequestid,
      "title": title,
      "description": description,
      "status": false,
      "studentId": studentid,
      "gradeId": gradeid,
      "subjectId": subjectId,
    });
    var response = await http.put(Uri.parse(Strings.tutorrequests_url),
        headers: headers, body: body);
    if (response.statusCode == 200) {
      API_Management().createCourseByRequest(
          token, title, description, tutorid, tutorrequestid);
    } else {
      log("Error while accept TutorRequest");
    }
  }

  Future<TutorCourses> getCoursesByTutorID(var token, int tutorId) async {
    var response = await http.get(
      Uri.parse(Strings.tutors_get_url(tutorId)),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return TutorCourses.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Course');
    }
  }

  Future<Tutors> getTutorByTutorID(var token, int tutorId) async {
    var response = await http.get(
      Uri.parse(Strings.tutors_get_url(tutorId)),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token.toString()
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);
      return Tutors.fromJson(jsonMap);
    } else {
      throw Exception('Error while get Course');
    }
  }

  void deleteCourse(var token, int courseid, String title, String description,
      int tutorId, int tutorRequestId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Charset': 'utf-8',
      "Authorization": "Bearer " + token.toString()
    };
    final body = jsonEncode({
      "courseId": courseid,
      "title": title,
      "description": description,
      "status": false,
      "tutorId": tutorId,
      "tutorRequestId": tutorRequestId
    });
    await http.put(Uri.parse(Strings.courses_url),
        headers: headers, body: body);
  }
}
