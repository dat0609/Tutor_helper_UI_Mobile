// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/api/api_management.dart';
import 'package:date_time_picker/date_time_picker.dart';

class ViewClassDetail extends StatefulWidget {
  const ViewClassDetail({Key? key}) : super(key: key);

  @override
  _ViewClassDetailState createState() => _ViewClassDetailState();
}

class _ViewClassDetailState extends State<ViewClassDetail> {
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
  String date = "";
  String title = "";
  String description = "";
  bool firstTime = true;

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
    return AppBar(
      title: const Text("Class Infomation"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: () {
            showAlertDialogForDelete(context);
          },
        )
      ],
    );
  }

  Widget _upper() {
    var startDateTimeStr =
        data_from_course_detail["startTime"].toString().split("T");
    date = startDateTimeStr[0];
    var startTimeStr = startDateTimeStr[1].split(":");
    String startTime = startTimeStr[0] + ":" + startTimeStr[1];

    var endDateTimeStr =
        data_from_course_detail["endTime"].toString().split("T");
    var endTimeStr = endDateTimeStr[1].split(":");
    String endTime = endTimeStr[0] + ":" + endTimeStr[1];

    if (firstTime) {
      startTimeChanged = startTime;
      endTimeChanged = endTime;
      title = data_from_course_detail["title"];
      description = data_from_course_detail["description"];
      firstTime = false;
    }

    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.only(top: 75),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
              initialValue: data_from_course_detail["title"],
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
              initialValue: data_from_course_detail["description"],
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onChanged: (value) {
                description = value;
              },
            ),
            Wrap(children: const [
              Text(
                "Change Time for Class",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              )
            ]),
            Wrap(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.time,
                  timePickerEntryModeInput: true,
                  initialValue: startTime,
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
                  initialValue: endTime,
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
              height: 50,
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
              showAlertDialogForUpdate(context);
            },
            child: const Text(
              "Update Class",
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.cyan,
              textStyle: const TextStyle(fontSize: 20),
            ))
      ],
    );
  }

  showAlertDialogForUpdate(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.back();
        Get.back();
        Get.back();
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Class Updated!"),
      content: const Text("The class has been Updated!!!"),
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
    Widget updatedButton = TextButton(
      child: const Text("Update"),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            API_Management().updateClass(
                data_from_course_detail["token"],
                data_from_course_detail["classid"],
                data_from_course_detail["courseid"],
                title,
                description,
                date + "T" + startTimeChanged + ":00",
                date + "T" + endTimeChanged + ":00",
                true);
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Update Class!"),
      content: const Text("Are you sure you want to Update this Class?"),
      actions: [
        cancelButton,
        updatedButton,
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

  showAlertDialogForDelete(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Get.back();
        Get.back();
        Get.back();
      },
    );
    AlertDialog secondAlert = AlertDialog(
      title: const Text("Class Deleted!"),
      content: const Text("The class has been Deleted!!!"),
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
    Widget deleteButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            API_Management().updateClass(
                data_from_course_detail["token"],
                data_from_course_detail["classid"],
                data_from_course_detail["courseid"],
                title,
                description,
                date + "T" + startTimeChanged + ":00",
                date + "T" + endTimeChanged + ":00",
                false);
            return secondAlert;
          },
        );
      },
    );
    AlertDialog firstAlert = AlertDialog(
      title: const Text("Delete Class!"),
      content: const Text("Are you sure you want to Delete this Class?"),
      actions: [
        cancelButton,
        deleteButton,
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
