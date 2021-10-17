import 'package:intl/intl.dart';

class DateTimeTutor {
  DateFormat dateOfWeekFormat = DateFormat('EEE');
  DateFormat dateFormat = DateFormat('d MMM');
  DateFormat monthFormat = DateFormat('MMM');
  DateFormat yearFormat = DateFormat('y');
  DateFormat dateOfWeekForCalendarFormat = DateFormat('E');
  DateFormat dayForCalendarFormat = DateFormat('d');
  DateFormat timeFormat = DateFormat('jm');

  String getDurationTime(DateTime startTime, DateTime endTime) {
    var diffTime = endTime.difference(startTime);
    String hours = diffTime.toString().split(':')[0];
    String minutes = diffTime.toString().split(':')[1];
    return "$hours h $minutes min";
  }
}
