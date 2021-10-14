import 'package:tutor_helper/model/courses.dart';

class Classes {
  Classes({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Classes.fromJson(Map<String, dynamic> json) {
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
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createAt,
    this.updateAt,
    required this.courseId,
    this.course,
  });
  late final int id;
  late final String title;
  late final String description;
  late final bool status;
  late final String createAt;
  late final String? updateAt;
  late final int courseId;
  late final Courses? course;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    courseId = json['courseId'];
    course = json['course'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['status'] = status;
    _data['createAt'] = createAt;
    _data['updateAt'] = updateAt;
    _data['courseId'] = courseId;
    _data['course'] = course;
    return _data;
  }
}
