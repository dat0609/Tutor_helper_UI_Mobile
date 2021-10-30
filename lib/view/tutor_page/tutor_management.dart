// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tutor_helper/view/tutor_page/calendar.dart';
import 'package:tutor_helper/view/tutor_page/profile.dart';
import 'package:tutor_helper/view/tutor_page/home.dart';

class TutorManagement extends StatefulWidget {
  const TutorManagement({Key? key}) : super(key: key);

  @override
  _TutorManagementState createState() => _TutorManagementState();
}

class _TutorManagementState extends State<TutorManagement> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    List pages = [
      const TutorHomePage(),
      const TutorCalendarPage(),
      const SettingPage(),
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
