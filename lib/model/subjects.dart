class Subjects {
  Subjects({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final Data data;
  late final String status;

  Subjects.fromJson(Map<String, dynamic> json) {
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
    required this.subjectId,
    required this.subjectName,
    required this.gradeId,
    this.grade,
    required this.tutorRequests,
  });
  late final int subjectId;
  late final String subjectName;
  late final int gradeId;
  late final Null grade;
  late final List<dynamic> tutorRequests;

  Data.fromJson(Map<String, dynamic> json) {
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    gradeId = json['gradeId'];
    grade = json['grade'];
    tutorRequests = List.castFrom<dynamic, dynamic>(json['tutorRequests']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subjectId'] = subjectId;
    _data['subjectName'] = subjectName;
    _data['gradeId'] = gradeId;
    _data['grade'] = grade;
    _data['tutorRequests'] = tutorRequests;
    return _data;
  }
}
