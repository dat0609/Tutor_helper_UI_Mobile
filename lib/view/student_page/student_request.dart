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
import 'package:tutor_helper/view/student_page/student_create_request.dart';

class StudentRequestPage extends StatefulWidget {
  const StudentRequestPage({Key? key}) : super(key: key);

  @override
  _StudentRequestPageState createState() => _StudentRequestPageState();
}

class _StudentRequestPageState extends State<StudentRequestPage> {
  String imageLink = "assets/images/default_avatar.png";
  final DateTime now = DateTime.now();
  DateTimeTutor dt = DateTimeTutor();
  final storage = const FlutterSecureStorage();
  String token = "";
  int studentId = 0;

  Future<String?> _getData() async {
    return await storage.read(key: "database");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Stack(children: [_upper(), _under()]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_circle_sharp,
          size: 50,
        ),
        onPressed: () {
          Get.to(() => const StudentCreateRequest(),
              arguments: {"token": token, "studentId": studentId});
        },
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
                token = data["data"]["jwtToken"];
                studentId = data["data"]["studentId"];
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
      height: MediaQuery.of(context).size.height - 200,
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
            "Your Request",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          FutureBuilder<String?>(
            future: _getData(),
            builder: (context, storageData) {
              if (storageData.hasData) {
                var data = jsonDecode(storageData.data.toString());
                int studentId = data['data']['studentId'];
                String token = data['data']['jwtToken'];
                return FutureBuilder<TutorRequests>(
                  future: API_Management().getAllTutorRequests(token),
                  builder: (context, tutorRequestsData) {
                    if (tutorRequestsData.hasData) {
                      return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: tutorRequestsData.data!.data.length,
                              itemBuilder: (context, index) {
                                var trData =
                                    tutorRequestsData.data!.data[index];
                                return FutureBuilder<Subjects>(
                                    future: API_Management().getSubjects(token),
                                    builder: (context, subjectData) {
                                      if (subjectData.hasData) {
                                        String grade = "noGrade";
                                        String subject = "noSubject";
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
                                        return FutureBuilder<StudentCourses>(
                                            future: API_Management()
                                                .getStudentByStudentId(
                                                    token, trData.studentId),
                                            builder: (context, studentData) {
                                              if (studentData.hasData) {
                                                var stuData =
                                                    studentData.data!.data;
                                                if (stuData.studentId ==
                                                    studentId) {
                                                  return buildClassItem(
                                                      trData.title,
                                                      trData.description,
                                                      trData.tutorRequestId,
                                                      token,
                                                      trData.gradeId,
                                                      trData.studentId,
                                                      trData.subjectId,
                                                      subject,
                                                      grade,
                                                      trData.status);
                                                } else {
                                                  return const Visibility(
                                                    child: Text(""),
                                                    visible: false,
                                                  );
                                                }
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
          ),
          // const SizedBox(
          //   height: 30,
          // ),
        ],
      ),
    );
  }

  Container buildClassItem(
      String courseTitle,
      String description,
      int tutorRequestID,
      String token,
      int gradeId,
      int studentid,
      int subjectId,
      String subjectName,
      String gradeName,
      String status) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 20, 0),
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
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
              width: MediaQuery.of(context).size.height - 450,
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
                        "Grade $gradeName - $subjectName",
                        style: const TextStyle(
                            overflow: TextOverflow.clip,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text("Status: $status")],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(110, 110, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              // Get.to(
                              //   () => const TutorViewPostDetail(),
                              //   arguments: {
                              //     "tutorRequestID": tutorRequestID,
                              //     "tutorId": tutorId,
                              //     "token": token,
                              //     "title": courseTitle,
                              //     "description": description,
                              //     "gradeId": gradeId,
                              //     "studentId": studentid,
                              //     "subjectId": subjectId,
                              //   },
                              // );
                            },
                            child: const Text(
                              "",
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
}
