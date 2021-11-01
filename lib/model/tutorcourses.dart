class TutorCourses {
  TutorCourses({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final Data data;
  late final String status;

  TutorCourses.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.tutorId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.imagePath,
    required this.courses,
  });
  late final int tutorId;
  late final String email;
  late final String fullName;
  late final String phoneNumber;
  late final String imagePath;
  late final List<Courses> courses;

  Data.fromJson(Map<String, dynamic> json) {
    tutorId = json['tutorId'];
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    imagePath = json['imagePath'];
    courses =
        List.from(json['courses']).map((e) => Courses.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tutorId'] = tutorId;
    _data['email'] = email;
    _data['fullName'] = fullName;
    _data['phoneNumber'] = phoneNumber;
    _data['imagePath'] = imagePath;
    _data['courses'] = courses.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Courses {
  Courses({
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

  Courses.fromJson(Map<String, dynamic> json) {
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
