import 'package:tutor_helper/model/tutor_requests.dart';

class Tutors {
  Tutors({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final Data data;
  late final String status;

  Tutors.fromJson(Map<String, dynamic> json) {
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
    required this.createAt,
    this.updateAt,
    required this.classes,
    required this.courses,
  });
  late final int tutorId;
  late final String email;
  late final String fullName;
  late final String phoneNumber;
  late final String createAt;
  late final Null updateAt;
  late final List<Classes> classes;
  late final List<dynamic> courses;

  Data.fromJson(Map<String, dynamic> json) {
    tutorId = json['tutorId'];
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    classes =
        List.from(json['classes']).map((e) => Classes.fromJson(e)).toList();
    courses = List.castFrom<dynamic, dynamic>(json['courses']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tutorId'] = tutorId;
    _data['email'] = email;
    _data['fullName'] = fullName;
    _data['phoneNumber'] = phoneNumber;
    _data['createAt'] = createAt;
    _data['updateAt'] = updateAt;
    _data['classes'] = classes.map((e) => e.toJson()).toList();
    _data['courses'] = courses;
    return _data;
  }
}

class Classes {
  Classes({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.tutorId,
    required this.tutorRequestId,
    required this.createAt,
    this.updateAt,
    this.tutorRequest,
  });
  late final int id;
  late final String title;
  late final String description;
  late final bool status;
  late final int tutorId;
  late final int tutorRequestId;
  late final String createAt;
  late final String? updateAt;
  late final TutorRequests? tutorRequest;

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    tutorId = json['tutorId'];
    tutorRequestId = json['tutorRequestId'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    tutorRequest = json['tutorRequest'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    _data['tutorId'] = tutorId;
    _data['tutorRequestId'] = tutorRequestId;
    _data['createAt'] = createAt;
    _data['updateAt'] = updateAt;
    _data['tutorRequest'] = tutorRequest;
    return _data;
  }
}
