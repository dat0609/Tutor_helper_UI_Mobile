class Grades {
  Grades({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Grades.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.gradeId,
    required this.gradeName,
    required this.students,
    required this.subjects,
    required this.tutorRequests,
  });
  late final int gradeId;
  late final String gradeName;
  late final List<dynamic> students;
  late final List<dynamic> subjects;
  late final List<dynamic> tutorRequests;

  Data.fromJson(Map<String, dynamic> json) {
    gradeId = json['gradeId'];
    gradeName = json['gradeName'];
    students = List.castFrom<dynamic, dynamic>(json['students']);
    subjects = List.castFrom<dynamic, dynamic>(json['subjects']);
    tutorRequests = List.castFrom<dynamic, dynamic>(json['tutorRequests']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gradeId'] = gradeId;
    _data['gradeName'] = gradeName;
    _data['students'] = students;
    _data['subjects'] = subjects;
    _data['tutorRequests'] = tutorRequests;
    return _data;
  }
}
