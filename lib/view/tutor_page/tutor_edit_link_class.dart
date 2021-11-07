// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';

class EditLinkClass extends StatefulWidget {
  const EditLinkClass({Key? key}) : super(key: key);

  @override
  _EditLinkClassState createState() => _EditLinkClassState();
}

class _EditLinkClassState extends State<EditLinkClass> {
  var data_from_course_detail = Get.arguments;
  final storage = const FlutterSecureStorage();
  String linkUrl = "";
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _navigator(),
      _upper(),
      _under(),
    ]);
  }

  AppBar _navigator() {
    return AppBar(
      title: const Text("Edit Link Class"),
    );
  }

  Widget _upper() {
    if (firstTime) {
      linkUrl = data_from_course_detail["linkUrl"];
      firstTime = false;
    }
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        height: 800,
        width: 500,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9FB),
        ),
        child: Column(children: [
          Row(
            children: const [
              Text(
                "Link URL",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          TextFormField(
            initialValue: linkUrl,
            keyboardType: TextInputType.url,
            onChanged: (value) {
              linkUrl = value;
            },
          ),
        ]),
      ),
    );
  }

  Container _under() {
    return Container(
      margin: const EdgeInsets.only(top: 630),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Edit Link",
                    desc: "Are you sure you want to Edit this Link?",
                    buttons: [
                      DialogButton(
                          onPressed: () => Get.back(),
                          child: const Text("Cancel")),
                      DialogButton(
                          onPressed: () {
                            API_Management().updateCourse(
                                data_from_course_detail["token"],
                                data_from_course_detail["courseId"],
                                data_from_course_detail["title"],
                                data_from_course_detail["description"],
                                data_from_course_detail["tutorId"],
                                data_from_course_detail["tutorrequestId"],
                                data_from_course_detail["studentId"],
                                linkUrl);
                            Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Successfully",
                                desc: "This Link has been update successfully!",
                                buttons: [
                                  DialogButton(
                                      onPressed: () => Get.offAll(
                                          () => const TutorManagement()),
                                      child: const Text("OK")),
                                ]).show();
                          },
                          child: const Text("Edit")),
                    ]).show();
              },
              child: const Text(
                "Edit Link",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.cyan,
                textStyle: const TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
