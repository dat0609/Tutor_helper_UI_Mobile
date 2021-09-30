class Area {
  int areaID;
  String areaName;

  Area(this.areaID, this.areaName);

  int get getAreaID {
    return areaID;
  }

  set setAreaID(int areaID) {
    this.areaID = areaID;
  }

  String get getAreaName {
    return areaName;
  }

  set getAreaName(String areaName) {
    this.areaName = areaName;
  }
}
