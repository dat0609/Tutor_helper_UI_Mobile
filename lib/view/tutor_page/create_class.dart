// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_picker/day_picker.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({Key? key}) : super(key: key);

  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final List<DayInWeek> _days = [
    DayInWeek("Sun"),
    DayInWeek("Mon"),
    DayInWeek("Tue"),
    DayInWeek("Wed"),
    DayInWeek("Thu"),
    DayInWeek("Fri"),
    DayInWeek("Sat"),
  ];
  var data_from_course_detail = Get.arguments;
  final storage = const FlutterSecureStorage();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String startTimeChanged = '';
  String startTimeToValidate = '';
  String startTimeSaved = '';
  String endTimeChanged = '';
  String endTimeToValidate = '';
  String endTimeSaved = '';
  List<int> weekdateData = [];
  List<List<String>> classDateTimeData = [];

  _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.parse("2100-01-01"),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.parse("2100-01-01"),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_navigator(), _upper()]);
  }

  AppBar _navigator() {
    return AppBar();
  }

  Widget _upper() {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        height: 800,
        width: 400,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9FB),
        ),
        child: Column(
          children: [
            Wrap(children: const [
              Text(
                "Choose Time for Class",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              )
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Start Date:",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _startDate(context),
                    child: Text(
                      "${selectedStartDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "End Date:",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => _endDate(context),
                    child: Text(
                      "${selectedEndDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                SelectWeekDays(
                  days: _days,
                  border: false,
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      colors: [Color(0xFF1DACE0), Color(0xFF1DACE0)],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  onSelect: (List<String> values) {
                    weekdateData.clear();
                    Map<String, int> weekday = {
                      "Mon": 1,
                      "Tue": 2,
                      "Wed": 3,
                      "Thu": 4,
                      "Fri": 5,
                      "Sat": 6,
                      "Sun": 7,
                    };
                    var entryList = weekday.entries.toList();
                    for (int i = 0; i < values.length; i++) {
                      for (int k = 0; k < weekday.length; k++) {
                        if (values[i] == entryList[k].key) {
                          weekdateData.add(entryList[k].value);
                          break;
                        }
                      }
                    }
                  },
                ),
              ],
            ),
            Wrap(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.time,
                  timePickerEntryModeInput: true,
                  initialValue: '',
                  icon: const Icon(Icons.access_time),
                  timeLabelText: "Start Time",
                  use24HourFormat: true,
                  locale: const Locale('vi', 'VN'),
                  onChanged: (val) => setState(() => startTimeChanged = val),
                  validator: (val) {
                    setState(() => startTimeToValidate = val ?? '');
                    return null;
                  },
                  onSaved: (val) => setState(() => startTimeSaved = val ?? ''),
                ),
              ],
            ),
            Wrap(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.time,
                  timePickerEntryModeInput: true,
                  initialValue: '',
                  icon: const Icon(Icons.access_time),
                  timeLabelText: "End Time",
                  use24HourFormat: true,
                  locale: const Locale('vi', 'VN'),
                  onChanged: (val) => setState(() => endTimeChanged = val),
                  validator: (val) {
                    setState(() => endTimeToValidate = val ?? '');
                    return null;
                  },
                  onSaved: (val) => setState(() => endTimeSaved = val ?? ''),
                ),
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            _under(),
          ],
        ),
      ),
    );
  }

  Row _under() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              classDateTimeData.clear();
              for (int i = 0; i < weekdateData.length; i++) {
                List<List<String>> dateTimeData =
                    DateTimeTutor.getDaysInBetween(
                        "${selectedStartDate.toLocal()}".split(' ')[0],
                        "${selectedEndDate.toLocal()}".split(' ')[0],
                        weekdateData[i],
                        startTimeChanged,
                        endTimeChanged);
                for (int k = 0; k < dateTimeData.length; k++) {
                  classDateTimeData.add(dateTimeData[k]);
                }
              }
              showAlertDialog(context);
            },
            child: const Text(
              "Create Class",
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.cyan,
              textStyle: const TextStyle(fontSize: 20),
            ))
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.offAll(() => const TutorManagement());
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Class Created!"),
      content: const Text("The class has been Created!!!"),
      actions: [
        okButton,
      ],
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget createButton = TextButton(
      child: const Text("Create"),
      onPressed: () {
        for (int i = 0; i < classDateTimeData.length; i++) {
          var date = classDateTimeData[i][0].split("T");
          String dateStr = date[0];
          API_Management().createClass(
              data_from_course_detail["token"],
              data_from_course_detail["courseid"],
              "Class of " +
                  data_from_course_detail["courseid"].toString() +
                  " at $dateStr",
              "This is Desc",
              classDateTimeData[i][0],
              classDateTimeData[i][1]);
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Create Class!"),
      content: const Text("Are you sure you want to Create this Class?"),
      actions: [
        cancelButton,
        createButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return firstAlert;
      },
    );
  }
}
