import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/subjects.dart';
import 'package:tutor_helper/view/student_page/student_management.dart';
import 'package:tutor_helper/view/student_page/student_request.dart';

class StudentCreateRequest extends StatefulWidget {
  const StudentCreateRequest({Key? key}) : super(key: key);

  @override
  _StudentCreateRequestState createState() => _StudentCreateRequestState();
}

class _StudentCreateRequestState extends State<StudentCreateRequest> {
  var data_from_student_request = Get.arguments;
  final storage = const FlutterSecureStorage();
  String title = "";
  String description = "";
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
  bool firstTime = true;
  bool gradeChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        _navigator(),
        _upper(),
      ]),
    );
  }

  Container _upper() {
    if (firstTime) {
      listGradeItem = listGrades[0].toString();
      gradeChanged = true;
      gradeNow = 1;
      gradeId = 1;
      subjectId = 1;
    }
    return Container(
      margin: const EdgeInsets.only(top: 75),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      height: 800,
      width: 500,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // listItem("Student:", datafromPost),
          const SizedBox(
            height: 10,
          ),
          const Text("Title", style: TextStyle(fontSize: 20)),
          TextFormField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              title = value;
            },
          ),
          const Text("Description", style: TextStyle(fontSize: 20)),
          TextFormField(
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              description = value;
            },
            maxLength: null,
            maxLines: 5,
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
              FutureBuilder<Subjects>(
                  future: API_Management().getSubjectByGrade(
                      data_from_student_request["token"], gradeNow),
                  builder: (context, subjectData) {
                    if (subjectData.hasData) {
                      var sData = subjectData.data!.data;
                      listSubjects.clear();
                      mapSubject.clear();
                      for (int i = 0; i < sData.length; i++) {
                        listSubjects.add(sData[i].subjectName);
                        mapSubject[sData[i].subjectName] = sData[i].subjectId;
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
                  }),
            ],
          ),
          _createButton()
        ],
      ),
    );
  }

  Row _createButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              subjectId = mapSubject[listSubjectItem]!.toInt();
              Alert(
                  type: AlertType.info,
                  context: context,
                  title: "Create Request",
                  desc: "Are you sure to create this request?",
                  buttons: [
                    DialogButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    DialogButton(
                      child: const Text("Create"),
                      onPressed: () {
                        API_Management().createRequest(
                            data_from_student_request["token"],
                            title,
                            description,
                            data_from_student_request["studentId"],
                            gradeId,
                            subjectId);
                        Alert(
                            type: AlertType.success,
                            context: context,
                            title: "Create Request Successfuly",
                            buttons: [
                              DialogButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Get.offAll(() => const StudentManagement());
                                },
                              ),
                            ]).show();
                      },
                    ),
                  ]).show();
            },
            child: const Text(
              "Create",
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              backgroundColor: Colors.cyan[700],
              textStyle: const TextStyle(fontSize: 20),
            )),
      ],
    );
  }

  AppBar _navigator() {
    return AppBar(
      title: const Text("Create Tutor Request"),
      actions: <Widget>[],
    );
  }
}
