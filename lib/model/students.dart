class Students {
  Students({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Students.fromJson(Map<String, dynamic> json) {
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
    required this.studentId,
    required this.email,
    required this.fullName,
    required this.grade,
    required this.phoneNumber,
    required this.schoolId,
    required this.gradeId,
    required this.createAt,
    this.updateAt,
    this.gradeNavigation,
    this.school,
    required this.tutorRequests,
  });
  late final int studentId;
  late final String email;
  late final String fullName;
  late final int grade;
  late final String phoneNumber;
  late final int schoolId;
  late final int gradeId;
  late final String createAt;
  late final String? updateAt;
  late final Null gradeNavigation;
  late final Null school;
  late final List<dynamic> tutorRequests;

  Data.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    email = json['email'];
    fullName = json['fullName'];
    grade = json['grade'];
    phoneNumber = json['phoneNumber'];
    schoolId = json['schoolId'];
    gradeId = json['gradeId'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    gradeNavigation = json['gradeNavigation'];
    school = json['school'];
    tutorRequests = List.castFrom<dynamic, dynamic>(json['tutorRequests']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['studentId'] = studentId;
    _data['email'] = email;
    _data['fullName'] = fullName;
    _data['grade'] = grade;
    _data['phoneNumber'] = phoneNumber;
    _data['schoolId'] = schoolId;
    _data['gradeId'] = gradeId;
    _data['createAt'] = createAt;
    _data['updateAt'] = updateAt;
    _data['gradeNavigation'] = gradeNavigation;
    _data['school'] = school;
    _data['tutorRequests'] = tutorRequests;
    return _data;
  }
}
