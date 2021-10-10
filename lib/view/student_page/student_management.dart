import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/view/tutor_page/calendar.dart';
import 'package:tutor_helper/view/tutor_page/document.dart';
import 'package:tutor_helper/view/tutor_page/home.dart';
import 'package:tutor_helper/view/tutor_page/view_post.dart';
import 'package:tutor_helper/view/student_page/calendar.dart';
import 'package:tutor_helper/view/student_page/document.dart';
import 'package:tutor_helper/view/student_page/home.dart';
import 'package:tutor_helper/view/student_page/view_post.dart';
import 'package:tutor_helper/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const StudentManagement());
}

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  _StudentManagementState createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool loginStatus = false;
    String role = "";
    var data = Get.arguments;
    if (data != null) {
      print(data);
      role = data[0];
      loginStatus = data[1];
    }
    print("role now is " + role);
    if (loginStatus == false) {
      return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      );
    }
    List pages = [
      const TutorHomePage(),
      TutorDocumentPage(),
      const TutorCalendarPage(),
      const TutorViewPost(),
    ];
    if (role == "student") {
      pages = [
        const StudentHomePage(),
        StudentDocumentPage(),
        const StudentCalendarPage(),
        const StudentViewPost(), //Upload Post
      ];
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: const Color(0xFFF0F0F0),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
            currentIndex: _selectedItemIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _selectedItemIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                title: Text("Home"),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text("Document"),
                icon: Icon(Icons.dashboard_customize_rounded),
              ),
              BottomNavigationBarItem(
                title: Text("Calendar"),
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text("Post"),
                icon: Icon(Icons.table_view_rounded),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]),
    );
  }
}
