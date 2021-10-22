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

  static List<List<String>> getDaysInBetween(String startDateStr,
      String endDateStr, int weekdate, String startTime, String endTime) {
    List<List<String>> dateTimeData = [];
    DateTime startDate = DateTime.parse(startDateStr);
    DateTime endDate = DateTime.parse(endDateStr);
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      if (startDate.add(Duration(days: i)).weekday == weekdate) {
        List<String> dateData = [];
        String date =
            DateFormat('yyyy-MM-dd').format(startDate.add(Duration(days: i)));
        dateData.add(date + "T" + startTime + ":00.000Z");
        dateData.add(date + "T" + endTime + ":00.000Z");
        dateTimeData.add(dateData);
      }
    }
    return dateTimeData;
  }
}
