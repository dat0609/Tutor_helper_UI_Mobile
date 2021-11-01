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
  final CalendarController _controller = CalendarController();
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
                  .getTutorByTutorID(data["data"]['jwtToken'], tutorID),
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
                      future: API_Management().getAllClasses(token),
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
                                    color: const Color(0XFF263064)));
                              }
                            }
                          }
                          return SfCalendar(
                            view: CalendarView.week,
                            allowedViews: const [
                              CalendarView.day,
                              CalendarView.week,
                              CalendarView.workWeek,
                              CalendarView.month,
                              CalendarView.timelineDay,
                              CalendarView.timelineWeek,
                              CalendarView.timelineWorkWeek
                            ],
                            firstDayOfWeek: DateTime.monday,
                            dataSource: _MeetingDataSource(meetings),
                            todayHighlightColor: const Color(0XFF263064),
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
                  return SfCalendar(
                    view: CalendarView.week,
                    allowedViews: const [
                      CalendarView.day,
                      CalendarView.week,
                      CalendarView.workWeek,
                      CalendarView.month,
                      CalendarView.timelineDay,
                      CalendarView.timelineWeek,
                      CalendarView.timelineWorkWeek
                    ],
                    firstDayOfWeek: DateTime.monday,
                    dataSource: _MeetingDataSource(meetings),
                    todayHighlightColor: const Color(0XFF263064),
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
        backgroundColor: const Color(0xFFD4E7FE),
        foregroundColor: const Color(0XFF263064),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_controller.view == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      _controller.view = CalendarView.day;
    } else if ((_controller.view == CalendarView.week ||
            _controller.view == CalendarView.workWeek) &&
        calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      _controller.view = CalendarView.day;
    }
  }
}

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
