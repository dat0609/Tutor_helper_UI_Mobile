import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/api/noti_api.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/model/courses.dart';
import 'package:tutor_helper/model/studentcourses.dart';
import 'package:tutor_helper/model/tutorcourses.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class StudentCalendarPage extends StatefulWidget {
  const StudentCalendarPage({Key? key}) : super(key: key);

  @override
  _StudentCalendarPageState createState() => _StudentCalendarPageState();
}

class _StudentCalendarPageState extends State<StudentCalendarPage> {
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
            int studentId = data["data"]["studentId"];
            var token = data["data"]["jwtToken"];
            return FutureBuilder<Coursess>(
              future: API_Management()
                  .getCourseByStudentId(data["data"]['jwtToken'], studentId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var studentCourse = snapshot.data!.data;
                  listCourseId.clear();
                  for (int i = 0; i < studentCourse.length; i++) {
                    if (studentCourse[i].status == true) {
                      listCourseId.add(studentCourse[i].courseId);
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
                                if (DateTime.parse(
                                        classData[i].startTime.toString())
                                    .subtract(const Duration(minutes: 10))
                                    .isAfter(DateTime.now())) {
                                  NotiApi.showScheduleNoti(
                                      id: i,
                                      title: "You have a class today!",
                                      body: classData[i].title,
                                      scheduleDate: DateTime.parse(
                                              classData[i].startTime.toString())
                                          .subtract(
                                              const Duration(minutes: 10)));
                                }
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
