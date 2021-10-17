import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/view/tutor_page/home.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';

class TutorViewCourseDetail extends StatefulWidget {
  const TutorViewCourseDetail({Key? key}) : super(key: key);

  @override
  _TutorViewCourseDetailState createState() => _TutorViewCourseDetailState();
}

class _TutorViewCourseDetailState extends State<TutorViewCourseDetail> {
  var data = Get.arguments;
  final storage = const FlutterSecureStorage();
  int tutorRequestIDGotten = 0;
  var token;
  String title = "";
  String description = "";
  int courseId = 0;
  int tutorrequestId = 0;
  int tutorId = 0;
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
          listItem("Title", data[0]),
          listItem("Desc", data[1]),
          listItem("ID", data[2].toString()),
        ],
      ),
    );
  }

  Container _under() {
    return Container(
      margin: const EdgeInsets.only(top: 700),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                backgroundColor: Colors.red[900],
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
        API_Management()
            .deleteCourse(data[6], data[2], data[0], data[1], data[3], data[4]);
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
