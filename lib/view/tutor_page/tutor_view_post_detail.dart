import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';

class TutorViewPostDetail extends StatefulWidget {
  const TutorViewPostDetail({Key? key}) : super(key: key);

  @override
  _TutorViewPostDetailState createState() => _TutorViewPostDetailState();
}

class _TutorViewPostDetailState extends State<TutorViewPostDetail> {
  var datafromPost = Get.arguments;
  final storage = const FlutterSecureStorage();
  int tutorRequestIDGotten = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _navigator(),
      _upper(),
    ]);
  }

  Container _upper() {
    tutorRequestIDGotten = datafromPost["tutorRequestID"];
    return Container(
      margin: const EdgeInsets.only(top: 75),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      height: 800,
      width: 500,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FB),
      ),
      child: Column(
        children: [
          // listItem("Student:", datafromPost),
          FutureBuilder<StudentCourses>(
              future: API_Management().getStudentByStudentId(
                  datafromPost["token"], datafromPost["studentId"]),
              builder: (context, studentData) {
                if (studentData.hasData) {
                  var stuData = studentData.data!.data;
                  return Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(stuData.imagePath),
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
                      listItem("Name", stuData.fullName),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // listItem("Email", stuData.email),
                    ],
                  );
                } else {
                  return const Visibility(
                    child: Text(""),
                    visible: false,
                  );
                }
              }),
          const SizedBox(
            height: 10,
          ),
          listItem("Title:", datafromPost["title"]),
          const SizedBox(
            height: 10,
          ),
          listItem("Desc:", datafromPost["description"]),
          const SizedBox(
            height: 10,
          ),
          //Hiển thị grade
          listItem("Grade:", "Grade " + datafromPost["gradeId"].toString()),
          const SizedBox(
            height: 10,
          ),
          //hiển thị môn
          listItem("Subject:", datafromPost["subjectName"]),
          const SizedBox(
            height: 10,
          ),
          //Hiển thị thông tin học sinh
          // listItem("student:", datafromPost["studentId"].toString()),
          const SizedBox(
            height: 200,
          ),
          // listItem("Grade:", data.grade.toString()),
          // const SizedBox(
          //   height: 10,
          // ),
          // listItem("Subject:", data.subject.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: const Text(
                    "Accept",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    backgroundColor: Colors.green[700],
                    textStyle: const TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _navigator() {
    return AppBar(
      title: const Text("Post Infomation"),
      actions: <Widget>[],
    );
  }

  Material listItem(String left, String right) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.offAll(() => const TutorManagement());
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Thank you!"),
      content: const Text("The request has been accepted!!!"),
      actions: [
        okButton,
      ],
    );
    Widget acceptButton = TextButton(
      child: const Text("Accept"),
      onPressed: () {
        API_Management().acceptTutorRequest(
            datafromPost["token"],
            datafromPost["tutorId"],
            datafromPost["tutorRequestID"],
            datafromPost["studentId"],
            datafromPost["gradeId"],
            datafromPost["title"],
            datafromPost["description"],
            datafromPost["subjectId"]);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Attention!"),
      content: const Text("Are you sure you want to accept the request?"),
      actions: [
        cancelButton,
        acceptButton,
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
}
