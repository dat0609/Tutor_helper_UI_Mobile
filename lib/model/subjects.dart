class Subjects {
  Subjects({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Subjects.fromJson(Map<String, dynamic> json) {
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
    required this.subjectId,
    required this.subjectName,
    required this.gradeId,
  });
  late final int subjectId;
  late final String subjectName;
  late final int gradeId;

  Data.fromJson(Map<String, dynamic> json) {
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    gradeId = json['gradeId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subjectId'] = subjectId;
    _data['subjectName'] = subjectName;
    _data['gradeId'] = gradeId;
    return _data;
  }
}
