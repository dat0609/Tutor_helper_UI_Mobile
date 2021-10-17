import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/view/tutor_page/profile.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/view/tutor_page/view_course_detail.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({Key? key}) : super(key: key);

  @override
  _TutorHomePageState createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage> {
  final storage = const FlutterSecureStorage();

  Future<String?> _getData() async {
    return await storage.read(key: "database");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_upper(), _under()]);
  }

  Container _upper() {
    initializeDateFormatting('vi', null);
    final DateTime now = DateTime.now();
    DateTimeTutor dtt = DateTimeTutor();
    String imageLink = "assets/images/default_avatar.png";

    return Container(
      decoration: const BoxDecoration(
          //color: Color(0xFFD4E7FE),
          gradient: LinearGradient(
              colors: [
                Color(0xFFD4E7FE),
                Color(0xFFF0F0F0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.3])),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 8,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    child: Image.asset(
                      imageLink,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TutorEditProfilePage()),
                      );
                    },
                  )),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String?>(
                    future: _getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = jsonDecode(snapshot.data.toString());
                        var email = data["data"]['email'].toString().split("@");
                        String username = email[0];
                        return Text(
                          "Hi  $username",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color(0XFF343E87),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const Text("");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Here is a list of schedule",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "You need to check...",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Positioned _under() {
    return Positioned(
      top: 185,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height - 245,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FutureBuilder<String?>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = jsonDecode(snapshot.data.toString());
              int tutorID = data["data"]["tutorId"];
              return FutureBuilder<TutorCourses>(
                future: API_Management()
                    .getCoursesByTutorID(data["data"]['jwtToken'], tutorID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var tutorCourse = snapshot.data!.data.courses;
                    return ListView.builder(
                        itemCount: tutorCourse.length,
                        itemBuilder: (context, index) {
                          var courseData = snapshot.data!.data.courses[index];
                          if (courseData.status == true) {
                            return buildClassItem(
                                courseData.title,
                                courseData.description,
                                courseData.courseId,
                                courseData.tutorId,
                                courseData.tutorRequestId,
                                courseData.tutorId,
                                data["data"]['jwtToken']);
                          } else {
                            return const Visibility(
                              child: Text("data"),
                              visible: false,
                            );
                          }
                        });
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
      ),
    );
  }

  Container buildClassItem(String title, String description, int courseid,
      int tutorid, int tutorrequestid, int studentid, String token) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  title.trim(), //Subject Name
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
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
                  Get.to(() => const TutorViewCourseDetail(), arguments: [
                    title,
                    description,
                    courseid,
                    tutorid,
                    tutorrequestid,
                    studentid,
                    token,
                  ]);
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
