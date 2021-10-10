import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/view/tutor_page/calendar.dart';
import 'package:tutor_helper/view/tutor_page/document.dart';
import 'package:tutor_helper/view/tutor_page/home.dart';
import 'package:tutor_helper/view/tutor_page/view_post.dart';

class TutorManagement extends StatefulWidget {
  const TutorManagement({Key? key}) : super(key: key);

  @override
  _TutorManagementState createState() => _TutorManagementState();
}

class _TutorManagementState extends State<TutorManagement> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    print(data);
    List pages = [
      const TutorHomePage(),
      TutorDocumentPage(),
      const TutorCalendarPage(),
      const TutorViewPost(),
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
