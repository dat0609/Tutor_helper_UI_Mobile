import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/view/tutor_page/create_class.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';

class TutorViewCourseDetail extends StatefulWidget {
  const TutorViewCourseDetail({Key? key}) : super(key: key);

  @override
  _TutorViewCourseDetailState createState() => _TutorViewCourseDetailState();
}

class _TutorViewCourseDetailState extends State<TutorViewCourseDetail> {
  var data_from_home_page = Get.arguments;
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
    return Stack(children: [_navigator(), _upper()]);
  }

  AppBar _navigator() {
    return AppBar(
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      height: 800,
      width: 400,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FB),
      ),
      child: Column(
        children: [
          listItem("Title", data_from_home_page["title"]),
          listItem("Desc", data_from_home_page["description"]),
          const SizedBox(
            height: 440,
          ),
          _under(),
        ],
      ),
    );
  }

  Container _under() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                Get.to(() => const CreateClass(), arguments: {
                  "title": data_from_home_page["title"],
                  "description": data_from_home_page["description"],
                  "courseid": data_from_home_page["courseid"],
                  "tutorid": data_from_home_page["tutorid"],
                  "tutorrequestid": data_from_home_page["tutorrequestid"],
                  "studentid": data_from_home_page["tutorid"],
                  "token": data_from_home_page["token"],
                });
              },
              child: const Text(
                "Create Class",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.cyan,
                textStyle: const TextStyle(fontSize: 20),
              )),
          TextButton(
              onPressed: () {
                print("Student Info");
              },
              child: const Text(
                "Student Info",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: const TextStyle(fontSize: 20),
              )),
        ],
      ),
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
            data_from_home_page["token"],
            data_from_home_page["courseid"],
            data_from_home_page["title"],
            data_from_home_page["description"],
            data_from_home_page["tutorid"],
            data_from_home_page["tutorrequestid"]);
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
}
