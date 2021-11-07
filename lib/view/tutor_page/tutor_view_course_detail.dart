// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/view/tutor_page/tutor_create_class.dart';
import 'package:tutor_helper/view/tutor_page/tutor_create_event.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';
import 'package:tutor_helper/view/tutor_page/tutor_view_class_detail.dart';
import 'package:tutor_helper/view/tutor_page/tutor_view_student_info.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorViewCourseDetail extends StatefulWidget {
  const TutorViewCourseDetail({Key? key}) : super(key: key);

  @override
  _TutorViewCourseDetailState createState() => _TutorViewCourseDetailState();
}

class _TutorViewCourseDetailState extends State<TutorViewCourseDetail> {
  // ignore: non_constant_identifier_names
  var data_from_course_page = Get.arguments;
  final storage = const FlutterSecureStorage();
  String linkUrl = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_navigator(), _upper(), _class(), _under()],
      ),
    );
  }

  AppBar _navigator() {
    return AppBar(
      title: const Text("Course Infomation"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: () {
            showAlertDialog(context);
          },
        )
      ],
    );
  }

  Container _upper() {
    return Container(
      margin: const EdgeInsets.only(top: 75),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FB),
      ),
      child: Scaffold(
        body: Column(
          children: [
            listItem("Title", data_from_course_page["title"]),
            listItem("Desc", data_from_course_page["description"]),
          ],
        ),
      ),
    );
  }

  Container _under() {
    return Container(
      margin: const EdgeInsets.only(top: 575),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Get.to(() => const CreateClass(), arguments: {
                      "title": data_from_course_page["title"],
                      "description": data_from_course_page["description"],
                      "courseId": data_from_course_page["courseId"],
                      "tutorId": data_from_course_page["tutorId"],
                      "tutorrequestId": data_from_course_page["tutorrequestId"],
                      "studentId": data_from_course_page["studentId"],
                      "token": data_from_course_page["token"],
                    });
                  },
                  child: const Text(
                    "Create Class",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.cyan[800],
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  )),
              TextButton(
                onPressed: () {
                  Get.to(() => const TutorViewStudentInfo(), arguments: {
                    "token": data_from_course_page["token"],
                    "studentId": data_from_course_page["studentId"],
                  });
                },
                child: const Text(
                  "Student Info",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => launch(data_from_course_page["linkUrl"]),
                  child: const Text(
                    "Link Class",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  )),
              TextButton(
                onPressed: () {
                  AlertDialog(
                    title: const Text("Edit Link url"),
                    content: TextFormField(
                      initialValue: data_from_course_page["linkUrl"],
                      keyboardType: TextInputType.url,
                      onChanged: (value) {
                        linkUrl = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: const Text("Update"),
                        onPressed: () {
                          API_Management().updateCourse(
                              data_from_course_page["token"],
                              data_from_course_page["courseId"],
                              data_from_course_page["title"],
                              data_from_course_page["description"],
                              data_from_course_page["tutorId"],
                              data_from_course_page["tutorrequestId"],
                              data_from_course_page["studentId"],
                              linkUrl);
                        },
                      ),
                    ],
                  );
                },
                child: const Text(
                  "Edit Link",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF00bf8c),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () =>
                      Get.to(() => const CreateEvent(), arguments: {
                        'token': data_from_course_page['token'],
                        'courseId': data_from_course_page['courseId'],
                        'tutorId': data_from_course_page['tutorId'],
                        'studentId': data_from_course_page['studentId'],
                      }),
                  child: const Text(
                    "Create Event",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF3f2180),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  )),
              TextButton(
                onPressed: () {
                  log("Document");
                },
                child: const Text(
                  "Document",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF00bf8c),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Material listItem(String left, String right) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            left,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 135,
            child: Text(
              right.trim(), //Address
              overflow: TextOverflow.clip,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Container _class() {
    return Container(
      margin: const EdgeInsets.only(top: 175, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: MediaQuery.of(context).size.height - 350,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        gradient: LinearGradient(colors: [Colors.cyan.shade100, Colors.cyan]),
      ),
      child: FutureBuilder<Classes>(
          future:
              API_Management().getAllClasses(data_from_course_page["token"]),
          builder: (context, classesData) {
            if (classesData.hasData) {
              var classData = classesData.data!.data;
              return Expanded(
                  child: ListView.builder(
                      itemCount: classData.length,
                      itemBuilder: (context, index) {
                        if (classData[index].courseId ==
                                data_from_course_page["courseId"] &&
                            classData[index].status == true &&
                            DateTime.parse(classData[index].startTime)
                                .isAfter(DateTime.now())) {
                          return buildClassItem(
                              classData[index].courseId,
                              classData[index].title,
                              classData[index].description,
                              classData[index].startTime.toString(),
                              classData[index].endTime.toString(),
                              classData[index].id,
                              data_from_course_page["token"]);
                        } else {
                          return const Visibility(
                            child: Text(""),
                            visible: false,
                          );
                        }
                      }));
            } else if (classesData.hasError) {
              return const Visibility(
                child: Text(""),
                visible: false,
              );
            } else {
              return const Visibility(
                child: Text(""),
                visible: false,
              );
            }
          }),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.offAll(() => const TutorManagement());
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Deleted!"),
      content: const Text("The course has been deleted!!!"),
      actions: [
        okButton,
      ],
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        API_Management().deleteCourse(
            data_from_course_page["token"],
            data_from_course_page["courseId"],
            data_from_course_page["title"],
            data_from_course_page["description"],
            data_from_course_page["tutorId"],
            data_from_course_page["tutorrequestId"],
            data_from_course_page["studentId"],
            data_from_course_page["linkUrl"]);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Delete!"),
      content: const Text("Are you sure you want to Delete this course?"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return firstAlert;
      },
    );
  }

  Container buildClassItem(int courseId, String title, String description,
      String startTime, String endTime, int classId, String token) {
    var startTimeStr = startTime.split("T");
    String date = startTimeStr[0];
    var fromTimeStr = startTimeStr[1].split(":");
    String fromTime = fromTimeStr[0] + ":" + fromTimeStr[1];
    var toTimeStr = endTime.split("T")[1].split(":");
    String toTime = toTimeStr[0] + ":" + toTimeStr[1];
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          color: const Color(0xFFF9F9FB),
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 132,
                child: Text(
                  title.trim(), //Subject Name
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 132,
                child: Text(
                  description.trim(),
                  overflow: TextOverflow.clip,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 132,
                child: Text(
                  "Date: ${date.trim()}",
                  overflow: TextOverflow.clip,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 132,
                child: Text(
                  "${fromTime.trim()}-${toTime.trim()}", //Address
                  overflow: TextOverflow.clip,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.cyan[600],
                    borderRadius: BorderRadius.circular(90)),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => const ViewClassDetail(), arguments: {
                      "courseId": courseId,
                      "title": title,
                      "description": description,
                      "startTime": startTime,
                      "endTime": endTime,
                      "classId": classId,
                      "token": token,
                    });
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
