import 'package:flutter/material.dart';
import 'package:tutor_helper/view/tutor_page/calendar.dart';
import 'package:tutor_helper/view/tutor_page/document.dart';
import 'package:tutor_helper/view/tutor_page/home.dart';
import 'package:tutor_helper/view/login_screen.dart';
import 'package:tutor_helper/view/tutor_page/view_post.dart';
import 'package:tutor_helper/view/student_page/calendar.dart';
import 'package:tutor_helper/view/student_page/document.dart';
import 'package:tutor_helper/view/student_page/home.dart';
import 'package:tutor_helper/view/login_screen.dart';
import 'package:tutor_helper/view/student_page/view_post.dart';

void main() {
  runApp(const SchoolManagement());
}

class SchoolManagement extends StatefulWidget {
  const SchoolManagement({Key? key}) : super(key: key);

  @override
  _SchoolManagementState createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  int _selectedItemIndex = 0; //TODO:RoleID = 1 thì là Tutor,=2 thì là Student

  @override
  Widget build(BuildContext context) {
    bool loggedin = true;
    int roleID = 1;
    List pages = [
      const TutorHomePage(),
      TutorDocumentPage(),
      const TutorCalendarPage(),
      const TutorViewPost(),
    ];
    if (roleID == 2) {
      pages = [
        const StudentHomePage(),
        StudentDocumentPage(),
        const StudentCalendarPage(),
        const StudentViewPost(), //Upload Post
      ];
    }
    if (loggedin == false) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      );
    }
    return MaterialApp(
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
