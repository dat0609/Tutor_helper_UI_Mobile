import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/view/login_screen.dart';
import 'package:tutor_helper/view/student_page/student_profile.dart';

class StudentSettingPage extends StatefulWidget {
  const StudentSettingPage({Key? key}) : super(key: key);

  @override
  _StudentSettingPageState createState() => _StudentSettingPageState();
}

class _StudentSettingPageState extends State<StudentSettingPage> {
  String username = "";
  String email = "";
  final storage = const FlutterSecureStorage();
  void _logOut() async {
    return await storage.deleteAll();
  }

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
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: const Color(0XFF263064),
        elevation: 1,
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data.toString());
                  var imagePath = data["data"]['imagePath'].toString();
                  return FutureBuilder<StudentCourses>(
                    future: API_Management().getStudentByStudentId(
                        data["data"]['jwtToken'], data["data"]['studentId']),
                    builder: (context, studentData) {
                      if (studentData.hasData) {
                        email = data["data"]['email'];
                        username = studentData.data!.data.fullName;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 7),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    username,
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 7),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 25, 10, 20),
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    email,
                                    style: const TextStyle(color: Colors.cyan),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Username",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    username,
                                    style: const TextStyle(color: Colors.cyan),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 7),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 10, 15),
                              color: Colors.white,
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    ),
                                    Icon(Icons.note_alt_outlined)
                                  ],
                                ),
                                onPressed: () {
                                  Get.to(() => const StudentProfilePage());
                                },
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
            Container(
              margin: const EdgeInsets.only(bottom: 7),
              padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
              color: Colors.white,
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    Icon(Icons.exit_to_app)
                  ],
                ),
                onPressed: () async {
                  await GoogleSignIn().disconnect();
                  await FirebaseAuth.instance.signOut();
                  _logOut();
                  Get.offAll(() => const LoginPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
