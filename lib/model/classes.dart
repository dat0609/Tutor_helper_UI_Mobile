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
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createAt,
    required this.courseId,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String startTime;
  late final String endTime;
  late final bool status;
  late final String createAt;
  late final int courseId;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    // createAt = json['createAt'];
    courseId = json['courseId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['status'] = status;
    _data['createAt'] = createAt;
    _data['courseId'] = courseId;
    return _data;
  }
}
