import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';

class StudentCalendarPage extends StatefulWidget {
  const StudentCalendarPage({Key? key}) : super(key: key);

  @override
  _StudentCalendarPageState createState() => _StudentCalendarPageState();
}

class _StudentCalendarPageState extends State<StudentCalendarPage> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi', null);
    final DateTime now = DateTime.now();
    DateTimeTutor dtt = DateTimeTutor();

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          alignment: Alignment.topCenter,
          color: const Color(0xFFF0F0F0),
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.grey),
                  const SizedBox(
                    width: 15,
                  ),
                  RichText(
                    text: TextSpan(
                        text: dtt.monthFormat.format(now),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF263064),
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: " " + dtt.yearFormat.format(now),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              const Text(
                "Today",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF3E3993),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 100,
          child: Container(
            height: MediaQuery.of(context).size.height - 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat
                              .format(now.subtract(new Duration(days: 3))),
                          int.parse(dtt.dayForCalendarFormat
                              .format(now.subtract(new Duration(days: 3)))),
                          false),
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat
                              .format(now.subtract(new Duration(days: 2))),
                          int.parse(dtt.dayForCalendarFormat
                              .format(now.subtract(new Duration(days: 2)))),
                          false),
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat
                              .format(now.subtract(new Duration(days: 1))),
                          int.parse(dtt.dayForCalendarFormat
                              .format(now.subtract(new Duration(days: 1)))),
                          false),
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat.format(now),
                          int.parse(dtt.dayForCalendarFormat.format(now)),
                          true),
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat
                              .format(now.add(new Duration(days: 1))),
                          int.parse(dtt.dayForCalendarFormat
                              .format(now.add(new Duration(days: 1)))),
                          false),
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat
                              .format(now.add(new Duration(days: 2))),
                          int.parse(dtt.dayForCalendarFormat
                              .format(now.add(new Duration(days: 2)))),
                          false),
                      buildDateColumn(
                          dtt.dateOfWeekForCalendarFormat
                              .format(now.add(new Duration(days: 3))),
                          int.parse(dtt.dayForCalendarFormat
                              .format(now.add(new Duration(days: 3)))),
                          false),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Task list
                        buildClassDetail(
                            DateTime.parse("2021-10-01T08:45:00Z"),
                            DateTime.parse("2021-10-01T09:45:00Z"),
                            "subjectName",
                            "subjectDetail",
                            "tutorImage",
                            "tutorName",
                            "tutorNumber",
                            "address",
                            "addressDetail")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Container buildClassDetail(
      DateTime startTime,
      DateTime endTime,
      String subjectName,
      String subjectDetail,
      String tutorImage,
      String tutorName,
      String tutorNumber,
      String address,
      String addressDetail) {
    DateTimeTutor dtt = DateTimeTutor();
    String startTimeString = dtt.timeFormat.format(startTime).split(" ")[0];
    String timeDuration = dtt.getDurationTime(startTime, endTime);
    String midday = dtt.timeFormat.format(startTime).split(" ")[1];
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 10,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(5),
                    )),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: startTimeString, //StartTime
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: midday, //midday
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            )
                          ]),
                    ),
                    Text(
                      timeDuration, //time duration
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 185,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(right: 10, left: 30),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subjectName, //Subject
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  subjectDetail, //Subject Detail
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 9,
                      backgroundImage: NetworkImage(tutorImage //TutorImage
                          ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tutorName, //TutorName
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          tutorNumber, //TutorNumber
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address, //Address
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          addressDetail, //Address Detail
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildDateColumn(String weekDay, int date, bool isActive) {
    return Container(
      decoration: isActive
          ? BoxDecoration(
              color: const Color(0xff402fcc),
              borderRadius: BorderRadius.circular(10))
          : const BoxDecoration(),
      height: 55,
      width: 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            weekDay,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
          Text(
            date.toString(),
            style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
