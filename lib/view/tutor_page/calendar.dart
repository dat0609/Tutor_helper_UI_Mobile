import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/model/classes.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TutorCalendarPage extends StatefulWidget {
  const TutorCalendarPage({Key? key}) : super(key: key);

  @override
  _TutorCalendarPageState createState() => _TutorCalendarPageState();
}

class _TutorCalendarPageState extends State<TutorCalendarPage> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi', null);
    final DateTime now = DateTime.now();
    DateTimeTutor dtt = DateTimeTutor();
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: DateTime.monday,
      ),
    );
  }
}

late Map<DateTime, List<Appointment>> _dataCollection;

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future.delayed(const Duration(seconds: 1));
    final List<Appointment> meetings = <Appointment>[];
    DateTime date = DateTime(startDate.year, startDate.month, startDate.day);
    final DateTime appEndDate =
        DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    while (date.isBefore(appEndDate)) {
      final List<Appointment>? data = _dataCollection[date];
      if (data == null) {
        date = date.add(const Duration(days: 1));
        continue;
      }

      for (final Appointment meeting in data) {
        if (appointments!.contains(meeting)) {
          continue;
        }

        meetings.add(meeting);
      }
      date = date.add(const Duration(days: 1));
    }

    appointments!.addAll(meetings);
    notifyListeners(CalendarDataSourceAction.add, meetings);
  }
}
