// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:tutor_helper/view/tutor_page/tutor_create_class.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';
import 'package:tutor_helper/view/tutor_page/tutor_view_class_detail.dart';

class StudentViewTutorInfo extends StatefulWidget {
  const StudentViewTutorInfo({Key? key}) : super(key: key);

  @override
  _StudentViewTutorInfoState createState() => _StudentViewTutorInfoState();
}

class _StudentViewTutorInfoState extends State<StudentViewTutorInfo> {
  // ignore: non_constant_identifier_names
  var data_from_course_detail_page = Get.arguments;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_navigator(), _upper()],
      ),
    );
  }

  AppBar _navigator() {
    return AppBar(
      title: const Text("Student Infomation"),
      // actions: <Widget>[
      //   IconButton(
      //     icon: const Icon(Icons.delete_forever),
      //     onPressed: () {
      //       showAlertDialog(context);
      //     },
      //   )
      // ],
    );
  }

  Container _upper() {
    return Container(
      margin: const EdgeInsets.only(top: 75),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      height: 800,
      width: 500,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FB),
      ),
      child: Scaffold(
          body: FutureBuilder<TutorCourses>(
              future: API_Management().getTutorByTutorID(
                  data_from_course_detail_page["token"],
                  data_from_course_detail_page["tutorId"]),
              builder: (context, tutorData) {
                if (tutorData.hasData) {
                  var tData = tutorData.data!.data;
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(tData.imagePath),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          border: Border.all(
                            color: Colors.cyan,
                            width: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      listItem("Name", tData.fullName),
                      const SizedBox(
                        height: 10,
                      ),
                      listItem("Email", tData.email),
                      const SizedBox(
                        height: 10,
                      ),
                      listItem("Phone", tData.phoneNumber),
                    ],
                  );
                } else {
                  return const Visibility(
                    child: Text(""),
                    visible: false,
                  );
                }
              })),
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
}
