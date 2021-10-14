class Areas {
  Areas({
    required this.message,
    required this.data,
    required this.status,
  });
  late final String message;
  late final List<Data> data;
  late final String status;

  Areas.fromJson(Map<String, dynamic> json) {
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
    required this.areaId,
    required this.areaName,
    required this.schools,
  });
  late final int areaId;
  late final String areaName;
  late final List<dynamic> schools;

  Data.fromJson(Map<String, dynamic> json) {
    areaId = json['areaId'];
    areaName = json['areaName'];
    schools = List.castFrom<dynamic, dynamic>(json['schools']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['areaId'] = areaId;
    _data['areaName'] = areaName;
    _data['schools'] = schools;
    return _data;
  }
}
