import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/model/students.dart';
import 'package:tutor_helper/model/subjects.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String imageLink = "assets/images/default_avatar.png";
  final DateTime now = DateTime.now();
  DateTimeTutor dt = DateTimeTutor();
  final storage = const FlutterSecureStorage();

  Future<String?> _getData() async {
    return await storage.read(key: "database");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(children: [
          _upper(),
          _under(),
        ]));
  }

  Container _upper() {
    initializeDateFormatting('vi', null);
    final DateTime now = DateTime.now();
    DateTimeTutor dtt = DateTimeTutor();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFFD4E7FE),
                Color(0xFFD4E7FE),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.3])),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                  text: dtt.dateOfWeekFormat.format(now),
                  style: const TextStyle(
                      color: Color(0XFF263064),
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(
                      text: " " + dtt.dateFormat.format(now),
                      style: const TextStyle(
                          color: Color(0XFF263064),
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    )
                  ]),
            ),
          ),
          FutureBuilder<String?>(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = jsonDecode(snapshot.data.toString());

                return FutureBuilder<StudentCourses>(
                    future: API_Management().getStudentByStudentId(
                        data["data"]["jwtToken"], data["data"]["studentId"]),
                    builder: (context, studentData) {
                      if (studentData.hasData) {
                        String username = studentData.data!.data.fullName;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 8,
                                    )
                                  ],
                                ),
                                child: GestureDetector(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 10,
                                    child: ClipOval(
                                      child: Image.network(
                                        data["data"]["imagePath"],
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Text(
                                    "Hi $username",
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0XFF343E87),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return const Text("");
                      }
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Text("");
              }
            },
          ),
        ],
      ),
    );
  }

  Container _under() {
    return Container(
      margin: const EdgeInsets.only(top: 140),
      padding: const EdgeInsets.fromLTRB(20, 20, 5, 0),
      height: MediaQuery.of(context).size.height - 190,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD4E7FE), Colors.cyan, Color(0xFFF0F0F0)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Courses",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: FutureBuilder<String?>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data.toString());
                  int studentId = data["data"]["studentId"];
                  return FutureBuilder<Courses>(
                    future: API_Management().getCourseByStudentId(
                        data["data"]['jwtToken'], studentId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var studentCourse = snapshot.data;
                        return buildClassItem(
                            studentCourse!.title,
                            studentCourse.description,
                            studentCourse.courseId,
                            studentCourse.tutorId,
                            studentCourse.tutorRequestId,
                            studentCourse.studentId,
                            data["data"]['jwtToken']);
                      } else if (snapshot.hasError) {
                        return const Text("");
                      } else {
                        return const Text("");
                      }
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const Text("");
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildClassItem(String title, String description, int courseid,
      int tutorid, int tutorrequestid, int studentid, String token) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, right: 7, left: 5),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5, // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  title.trim(), //Subject Name
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Text(
                  description.trim(), //Address
                  overflow: TextOverflow.clip,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Get.to(() => const TutorViewCourseDetail(), arguments: {
                  //   "title": title,
                  //   "description": description,
                  //   "courseid": courseid,
                  //   "tutorid": tutorid,
                  //   "tutorrequestid": tutorrequestid,
                  //   "studentid": studentid,
                  //   "token": token,
                  // });
                },
                icon: const Icon(Icons.arrow_right_alt_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
