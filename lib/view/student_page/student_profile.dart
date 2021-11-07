import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/view/student_page/student_management.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  String username = "";
  String email = "";
  String phone = "";
  String token = "";
  String imagePath = "";
  bool firstTime = true;
  int schoolId = 0;
  int gradeId = 0;
  int studentId = 0;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("View Profile"),
        backgroundColor: const Color(0XFF263064),
        elevation: 1,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data.toString());
                  imagePath = data["data"]['imagePath'].toString();
                  token = data["data"]['jwtToken'];
                  return FutureBuilder<StudentCourses>(
                    future: API_Management().getStudentBystudentId(
                        data["data"]['jwtToken'], data["data"]['studentId']),
                    builder: (context, studentData) {
                      if (studentData.hasData) {
                        email = data["data"]['email'];
                        imagePath = studentData.data!.data.imagePath;
                        studentId = studentData.data!.data.studentId;
                        schoolId = studentData.data!.data.schoolId;
                        gradeId = studentData.data!.data.gradeId;
                        if (firstTime) {
                          username = studentData.data!.data.fullName;
                          phone = studentData.data!.data.phoneNumber;
                          if (phone == "00000") {
                            phone = "";
                          }
                          firstTime = false;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // margin: const EdgeInsets.only(bottom: 7),
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      image: DecorationImage(
                                        image: NetworkImage(imagePath),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50.0)),
                                      border: Border.all(
                                        color: Colors.cyan,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    studentData.data!.data.fullName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 7),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 10, 15),
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: false,
                                    initialValue: email,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.name,
                                    initialValue: username,
                                    onChanged: (value) {
                                      username = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Phone number",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    initialValue: phone,
                                    onChanged: (value) {
                                      phone = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Visibility(
                          child: Text(""),
                          visible: false,
                        );
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
            const SizedBox(
              height: 200,
            ),
            ElevatedButton(
                onPressed: () {
                  if (phone == "" || phone == "00000") {
                    Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Phone Error",
                        desc: "Please input your phone number!",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "OK",
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          )
                        ]).show();
                  } else {
                    Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Update Profile!",
                        desc: "Are you sure to update your profile?",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Cancel",
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          DialogButton(
                            child: const Text(
                              "Update",
                            ),
                            onPressed: () {
                              API_Management().updateStudentProfile(
                                  token,
                                  studentId,
                                  email,
                                  username,
                                  phone,
                                  schoolId,
                                  gradeId,
                                  imagePath);
                              Alert(
                                  context: context,
                                  type: AlertType.success,
                                  title: "Completed!",
                                  desc:
                                      "Your profile has been updated successfully!",
                                  buttons: [
                                    DialogButton(
                                      child: const Text(
                                        "OK",
                                      ),
                                      onPressed: () {
                                        Get.offAll(
                                            () => const StudentManagement());
                                      },
                                    )
                                  ]).show();
                            },
                          )
                        ]).show();
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 25),
                ))
          ],
        ),
      ),
    );
  }
}
