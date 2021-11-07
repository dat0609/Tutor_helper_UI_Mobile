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
import 'package:tutor_helper/view/tutor_page/tutor_view_course_detail.dart';
import 'package:tutor_helper/view/tutor_page/tutor_view_post_detail.dart';

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
  List<String> listGrades = [
    "Grade 1",
    "Grade 2",
    "Grade 3",
    "Grade 4",
    "Grade 5",
    "Grade 6",
    "Grade 7",
    "Grade 8",
    "Grade 9",
    "Grade 10",
    "Grade 11",
    "Grade 12",
  ];
  List<String> listSubjects = [];
  Map<String, int> mapSubject = {};
  String listGradeItem = "";
  String listSubjectItem = "";
  int gradeId = 0;
  int subjectId = 0;
  int gradeNow = 1;
  int subjectNow = 1;
  bool firstTime = true;
  bool gradeChanged = false;

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
        child: Stack(children: [_upper(), _under()]),
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
    if (firstTime) {
      listGradeItem = listGrades[0].toString();
      gradeChanged = true;
      gradeNow = 1;
      subjectNow = 1;
    }
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
            "Student's Request",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Grade:", style: TextStyle(fontSize: 20)),
              Text("Subject:", style: TextStyle(fontSize: 20)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                value: listGradeItem,
                icon: const Icon(Icons.keyboard_arrow_down),
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    listGradeItem = newValue.toString();
                    gradeChanged = true;
                  });
                  var listGradeItemsStr = newValue.toString().split(" ");
                  gradeNow = int.parse(listGradeItemsStr[1]);
                  gradeId = gradeNow;
                },
                items: listGrades.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
              ),
              FutureBuilder<String?>(
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = jsonDecode(snapshot.data.toString());
                    return FutureBuilder<Subjects>(
                        future: API_Management().getSubjectByGrade(
                            data["data"]["jwtToken"], gradeNow),
                        builder: (context, subjectData) {
                          if (subjectData.hasData) {
                            var sData = subjectData.data!.data;
                            listSubjects.clear();
                            mapSubject.clear();
                            for (int i = 0; i < sData.length; i++) {
                              listSubjects.add(sData[i].subjectName);
                              mapSubject[sData[i].subjectName] =
                                  sData[i].subjectId;
                            }
                            if (gradeChanged) {
                              listSubjectItem = listSubjects[0].toString();
                            }
                            firstTime = false;
                            return DropdownButton(
                              value: listSubjectItem,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: listSubjects.map((String items) {
                                return DropdownMenuItem(
                                    value: items, child: Text(items));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  listSubjectItem = newValue.toString();
                                  subjectNow =
                                      mapSubject[listSubjectItem]!.toInt();
                                  gradeChanged = false;
                                });
                              },
                            );
                          } else {
                            return const Visibility(
                              child: Text(""),
                              visible: false,
                            );
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
          FutureBuilder<String?>(
            future: _getData(),
            builder: (context, storageData) {
              if (storageData.hasData) {
                var data = jsonDecode(storageData.data.toString());
                int tutorId = data['data']['tutorId'];
                String token = data['data']['jwtToken'];
                return FutureBuilder<TutorRequests>(
                  future: API_Management()
                      .getTutorRequestsBySubjectId(token, subjectNow),
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
                                          return FutureBuilder<StudentCourses>(
                                              future: API_Management()
                                                  .getStudentBystudentId(
                                                      token, trData.studentId),
                                              builder: (context, studentData) {
                                                if (studentData.hasData) {
                                                  var stuData =
                                                      studentData.data!.data;
                                                  imageUrl = stuData.imagePath
                                                      .toString();
                                                  studentName =
                                                      stuData.fullName;
                                                  if (trData.subjectId ==
                                                      subjectNow) {
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
      String fullName,
      String imageUrl,
      int tutorRequestID,
      int tutorId,
      String token,
      int gradeId,
      int studentId,
      int subjectId,
      String subjectName,
      String gradeName) {
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
                    padding: const EdgeInsets.fromLTRB(110, 120, 0, 0),
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
                                  "studentId": studentId,
                                  "subjectId": subjectId,
                                  "subjectName": subjectName
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
}
