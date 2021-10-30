import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/students.dart';
import 'package:tutor_helper/model/subjects.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/view/tutor_page/view_course_detail.dart';
import 'package:tutor_helper/view/tutor_page/view_post_detail.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({Key? key}) : super(key: key);

  @override
  _TutorHomePageState createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage> {
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
      child: SingleChildScrollView(
        child: Stack(children: [
          _upper(),
          Column(
            children: [
              _under(),
              _under2(),
            ],
          )
        ]),
      ),
    );
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

                return FutureBuilder<TutorCourses>(
                    future: API_Management().getTutorByTutorID(
                        data["data"]["jwtToken"], data["data"]["tutorId"]),
                    builder: (context, tutorData) {
                      if (tutorData.hasData) {
                        String username = tutorData.data!.data.fullName;
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
                                Text(
                                  "Hi $username",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0XFF343E87),
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
      height: MediaQuery.of(context).size.height - 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Student's Request",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          FutureBuilder<String?>(
            future: _getData(),
            builder: (context, storageData) {
              if (storageData.hasData) {
                var data = jsonDecode(storageData.data.toString());
                int tutorId = data['data']['tutorId'];
                String token = data['data']['jwtToken'];
                return FutureBuilder<TutorRequests>(
                  future: API_Management().getAllTutorRequests(token),
                  builder: (context, tutorRequestsData) {
                    if (tutorRequestsData.hasData) {
                      return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: tutorRequestsData.data!.data.length,
                              itemBuilder: (context, index) {
                                var trData =
                                    tutorRequestsData.data!.data[index];
                                if (trData.status == "Approved") {
                                  return FutureBuilder<Subjects>(
                                      future:
                                          API_Management().getSubjects(token),
                                      builder: (context, subjectData) {
                                        if (subjectData.hasData) {
                                          String grade = "noGrade";
                                          String subject = "noSubject";
                                          String imageUrl = "";
                                          String studentName = "";
                                          var subData = subjectData.data!.data;
                                          for (int i = 0;
                                              i < subData.length;
                                              i++) {
                                            // ignore: unrelated_type_equality_checks
                                            if (subData[i].subjectId ==
                                                trData.subjectId) {
                                              grade =
                                                  subData[i].gradeId.toString();
                                              subject = subData[i]
                                                  .subjectName
                                                  .toString();
                                            }
                                          }
                                          return FutureBuilder<Students>(
                                              future: API_Management()
                                                  .getStudents(
                                                      token, trData.studentId),
                                              builder: (context, studentData) {
                                                if (studentData.hasData) {
                                                  var stuData =
                                                      studentData.data!.data;
                                                  imageUrl = stuData.imagePath
                                                      .toString();
                                                  studentName =
                                                      stuData.fullName;
                                                  return buildClassItem(
                                                      trData.title,
                                                      trData.description,
                                                      studentName,
                                                      imageUrl,
                                                      trData.tutorRequestId,
                                                      tutorId,
                                                      token,
                                                      trData.gradeId,
                                                      trData.studentId,
                                                      trData.subjectId,
                                                      subject,
                                                      grade);
                                                } else {
                                                  return const Visibility(
                                                    child: Text(""),
                                                    visible: false,
                                                  );
                                                }
                                              });
                                        } else {
                                          return const Visibility(
                                            child: Text(""),
                                            visible: false,
                                          );
                                        }
                                      });
                                } else {
                                  return const Visibility(
                                    child: Text(""),
                                    visible: false,
                                  );
                                }
                              }));
                    } else {
                      return const Text("");
                    }
                  },
                );
              } else {
                return const Text("");
              }
            },
          )
        ],
      ),
    );
  }

  Container buildClassItem(
      String courseTitle,
      String description,
      String fullName,
      String imageUrl,
      int tutorRequestID,
      int tutorId,
      String token,
      int gradeId,
      int studentid,
      int subjectId,
      String subjectName,
      String gradeName) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 50, 10),
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      height: 500,
      decoration: BoxDecoration(
        color: const Color(0xFFfafafa),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5, // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 295,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseTitle,
                        style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      Text(
                        "Grade $gradeName - $subjectName",
                        style: const TextStyle(
                            overflow: TextOverflow.clip,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 20,
                          child: ClipOval(
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                        Text(
                          fullName,
                          style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(110, 220, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(
                                () => const TutorViewPostDetail(),
                                arguments: {
                                  "tutorRequestID": tutorRequestID,
                                  "tutorId": tutorId,
                                  "token": token,
                                  "title": courseTitle,
                                  "description": description,
                                  "gradeId": gradeId,
                                  "studentid": studentid,
                                  "subjectId": subjectId,
                                },
                              );
                            },
                            child: const Text(
                              "More detail >>>",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ))
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Container _under2() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: MediaQuery.of(context).size.height - 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
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
                  int tutorID = data["data"]["tutorId"];
                  return FutureBuilder<TutorCourses>(
                    future: API_Management()
                        .getTutorByTutorID(data["data"]['jwtToken'], tutorID),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var tutorCourse = snapshot.data!.data.courses;
                        return ListView.builder(
                            itemCount: tutorCourse.length,
                            itemBuilder: (context, index) {
                              var courseData =
                                  snapshot.data!.data.courses[index];
                              if (courseData.status == true) {
                                return buildClassItem2(
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
          )
        ],
      ),
    );
  }

  Container buildClassItem2(String title, String description, int courseid,
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
                  Get.to(() => const TutorViewCourseDetail(), arguments: {
                    "title": title,
                    "description": description,
                    "courseid": courseid,
                    "tutorid": tutorid,
                    "tutorrequestid": tutorrequestid,
                    "studentid": studentid,
                    "token": token,
                  });
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
