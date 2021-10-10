import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/model/tutors.dart';

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
    required this.createAt,
    this.updateAt,
    this.tutor,
    this.tutorRequest,
    required this.classes,
    required this.feedbacks,
  });
  late final int courseId;
  late final String title;
  late final String description;
  late final bool status;
  late final int tutorId;
  late final int tutorRequestId;
  late final String createAt;
  late final String? updateAt;
  late final Tutors? tutor;
  late final TutorRequests? tutorRequest;
  late final List<dynamic> classes;
  late final List<dynamic> feedbacks;

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    tutorId = json['tutorId'];
    tutorRequestId = json['tutorRequestId'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    tutor = json['tutor'];
    tutorRequest = json['tutorRequest'];
    classes = List.castFrom<dynamic, dynamic>(json['classes']);
    feedbacks = List.castFrom<dynamic, dynamic>(json['feedbacks']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['courseId'] = courseId;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    _data['tutorId'] = tutorId;
    _data['tutorRequestId'] = tutorRequestId;
    _data['createAt'] = createAt;
    _data['updateAt'] = updateAt;
    _data['tutor'] = tutor;
    _data['tutorRequest'] = tutorRequest;
    _data['classes'] = classes;
    _data['feedbacks'] = feedbacks;
    return _data;
  }
}
