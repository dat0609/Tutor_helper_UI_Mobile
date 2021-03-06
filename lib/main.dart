import 'package:flutter/material.dart';
import 'package:tutor_helper/calendar.dart';
import 'package:tutor_helper/document.dart';
import 'package:tutor_helper/home.dart';
import 'package:tutor_helper/login_screen.dart';
import 'package:tutor_helper/sign_up.dart';
import 'package:tutor_helper/view_post.dart';

void main() {
  runApp(SchoolManagement());
}

class SchoolManagement extends StatefulWidget {
  const SchoolManagement({Key? key}) : super(key: key);

  @override
  _SchoolManagementState createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  int _selectedItemIndex = 0;
  final List pages = [
    const HomePage(),
    const DocumentPage(),
    const CalendarPage(),
    const ViewPost(),
    //DocumentPage(),
  ];
  @override
  Widget build(BuildContext context) {
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
                title: Text(""),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.dashboard_customize_rounded),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                title: Text(""),
                icon: Icon(Icons.table_view_rounded),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]),
    );
  }
}
