import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
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
  var token;
  String title = "";
  String description = "";
  int tutorId = 0;
  int tutorrequestId = 0;
  int studentId = 0;
  int subjectId = 0;

  Future<String?> _getToken() async {
    return await storage.read(key: "jwtToken");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_navigator(), _upper(), _under()]);
  }

  Container _upper() {
    tutorRequestIDGotten = datafromPost["tutorRequestID"];
    return Container(
      margin: const EdgeInsets.only(top: 75),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      height: 800,
      width: 400,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FB),
      ),
      child: FutureBuilder<TutorRequests>(
        future: API_Management().getAllTutorRequests(datafromPost["token"]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.data[index];
                  if (data.tutorRequestId == tutorRequestIDGotten) {
                    title = data.title.toString();
                    description = data.description.toString();
                    tutorId = datafromPost["tutorId"];
                    tutorrequestId = data.tutorRequestId;
                    studentId = data.studentId;
                    subjectId = data.subjectId;
                    return Column(
                      children: [
                        listItem("Student:", data.studentId.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        listItem("Title:", data.title.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        listItem("Desc:", data.description.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        // listItem("Grade:", data.grade.toString()),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // listItem("Subject:", data.subject.toString()),
                      ],
                    );
                  }
                  return const Visibility(child: Text(""), visible: false);
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Text("");
          }
        },
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
    );
  }

  AppBar _navigator() {
    return AppBar(
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
        API_Management().acceptTutorRequest(datafromPost["token"], tutorId,
            tutorrequestId, studentId, 1, title, description, subjectId);
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
