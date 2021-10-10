class Tutors {
  Tutors({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Tutors.fromJson(Map<String, dynamic> json) {
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
    required this.tutorId,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.createAt,
    this.updateAt,
    required this.courses,
  });
  late final int tutorId;
  late final String email;
  late final String fullName;
  late final String phoneNumber;
  late final String? createAt;
  late final String? updateAt;
  late final List<dynamic> courses;

  Data.fromJson(Map<String, dynamic> json) {
    tutorId = json['tutorId'];
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
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
    _data['courses'] = courses;
    return _data;
  }
}
