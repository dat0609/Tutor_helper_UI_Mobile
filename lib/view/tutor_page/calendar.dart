import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TutorCalendarPage extends StatefulWidget {
  const TutorCalendarPage({Key? key}) : super(key: key);

  @override
  _TutorCalendarPageState createState() => _TutorCalendarPageState();
}

class _TutorCalendarPageState extends State<TutorCalendarPage> {
  List<Appointment> meetings = <Appointment>[];
  List<int> listCourseId = <int>[];
  final storage = const FlutterSecureStorage();

  Future<String?> _getData() async {
    return await storage.read(key: "database");
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi', null);
    return Scaffold(
      body: FutureBuilder<String?>(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            int tutorID = data["data"]["tutorId"];
            var token = data["data"]["jwtToken"];
            return FutureBuilder<TutorCourses>(
              future: API_Management()
                  .getCoursesByTutorID(data["data"]['jwtToken'], tutorID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var tutorCourse = snapshot.data!.data.courses;
                  listCourseId.clear();
                  for (int i = 0; i < tutorCourse.length; i++) {
                    if (tutorCourse[i].status == true) {
                      listCourseId.add(tutorCourse[i].courseId);
                    }
                  }
                  return FutureBuilder<Classes>(
                      future: API_Management().getAllClass(token),
                      builder: (context, classesData) {
                        if (classesData.hasData) {
                          var classData = classesData.data!.data;
                          meetings.clear();
                          for (int i = 0; i < classData.length; i++) {
                            for (int k = 0; k < listCourseId.length; k++) {
                              if (listCourseId[k] == classData[i].courseId &&
                                  classData[i].status == true) {
                                meetings.add(Appointment(
                                    startTime: DateTime.parse(
                                        classData[i].startTime.toString()),
                                    endTime: DateTime.parse(
                                        classData[i].endTime.toString()),
                                    subject: classData[i].title,
                                    color: Colors.blue));
                              }
                            }
                          }
                          return SfCalendar(
                            view: CalendarView.week,
                            firstDayOfWeek: DateTime.monday,
                            dataSource: _MeetingDataSource(meetings),
                          );
                        } else if (classesData.hasError) {
                          return const Visibility(
                            child: Text(""),
                            visible: false,
                          );
                        } else {
                          return const Visibility(
                            child: Text(""),
                            visible: false,
                          );
                        }
                      });
                } else if (snapshot.hasError) {
                  return const Visibility(
                    child: Text(""),
                    visible: false,
                  );
                } else {
                  return const Visibility(
                    child: Text(""),
                    visible: false,
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Text("");
          }
        },
      ),
      appBar: AppBar(
        title: const Text("Calendar"),
        actions: [],
      ),
    );
  }
}

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
