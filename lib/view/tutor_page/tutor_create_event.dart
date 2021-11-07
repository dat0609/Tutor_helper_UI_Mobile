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
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var data_from_course_detail = Get.arguments;
  final storage = const FlutterSecureStorage();
  DateTime selectedStartDate = DateTime.now();
  String startTimeChanged = '';
  String startTimeToValidate = '';
  String startTimeSaved = '';
  String endTimeChanged = '';
  String endTimeToValidate = '';
  String endTimeSaved = '';
  String title = "";
  String description = "";

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _navigator(),
      _upper(),
      _under(),
    ]);
  }

  AppBar _navigator() {
    return AppBar(
      title: const Text("Create Event"),
    );
  }

  Widget _upper() {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        height: 800,
        width: 500,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9FB),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Title",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                title = value;
              },
            ),
            Row(
              children: const [
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onChanged: (value) {
                description = value;
              },
            ),
            Wrap(children: const [
              Text(
                "Choose Time for Event",
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
                  "Date:",
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
          ],
        ),
      ),
    );
  }

  Container _under() {
    return Container(
      margin: const EdgeInsets.only(top: 630),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Create Event",
                    desc: "Are you sure you want to Create this Event?",
                    buttons: [
                      DialogButton(
                          onPressed: () => Get.back(),
                          child: const Text("Cancel")),
                      DialogButton(
                          onPressed: () {
                            String startTime =
                                selectedStartDate.toString().split(" ")[0] +
                                    "T" +
                                    startTimeChanged +
                                    ":00.000Z";
                            String endTime =
                                selectedStartDate.toString().split(" ")[0] +
                                    "T" +
                                    endTimeChanged +
                                    ":00.000Z";
                            API_Management().createClass(
                                data_from_course_detail["token"],
                                data_from_course_detail["courseId"],
                                title,
                                description,
                                startTime,
                                endTime,
                                data_from_course_detail["tutorId"],
                                data_from_course_detail["studentId"]);
                            Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Event Created!",
                                desc:
                                    "The Event has been Created successfully!",
                                buttons: [
                                  DialogButton(
                                      onPressed: () => Get.offAll(
                                          () => const TutorManagement()),
                                      child: const Text("OK")),
                                ]).show();
                          },
                          child: const Text("Create")),
                    ]).show();
              },
              child: const Text(
                "Create Event",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.cyan,
                textStyle: const TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
