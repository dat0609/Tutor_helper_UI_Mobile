// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tutor_helper/view/student_page/student_calendar.dart';
import 'package:tutor_helper/view/student_page/student_request.dart';
import 'package:tutor_helper/view/student_page/student_home.dart';
import 'package:tutor_helper/view/student_page/student_setting.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  _StudentManagementState createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    List pages = [
      const StudentHomePage(),
      const StudentRequestPage(),
      const StudentCalendarPage(),
      const StudentSettingPage(),
    ];
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
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                title: Text("Request"),
                icon: Icon(Icons.computer_outlined),
              ),
              BottomNavigationBarItem(
                title: Text("Calendar"),
                icon: Icon(Icons.calendar_today_outlined),
              ),
              BottomNavigationBarItem(
                title: Text("Profile"),
                icon: Icon(Icons.person_outlined),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]),
    );
  }
}
