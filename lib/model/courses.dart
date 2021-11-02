class Courses {
  Courses({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Courses.fromJson(Map<String, dynamic> json) {
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
    required this.courseId,
    required this.title,
    required this.description,
    required this.status,
    required this.tutorId,
    required this.tutorRequestId,
    required this.studentId,
  });
  late final int courseId;
  late final String title;
  late final String description;
  late final bool status;
  late final int tutorId;
  late final int tutorRequestId;
  late final int studentId;

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    tutorId = json['tutorId'];
    tutorRequestId = json['tutorRequestId'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['courseId'] = courseId;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    _data['tutorId'] = tutorId;
    _data['tutorRequestId'] = tutorRequestId;
    _data['studentId'] = studentId;
    return _data;
  }
}
