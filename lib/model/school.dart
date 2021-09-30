class School {
  int schoolID;
  String schoolName;
  String schoolAddress;
  int schoolLevel;
  int areaID;

  School(this.schoolID, this.schoolName, this.schoolAddress, this.schoolLevel,
      this.areaID);

  int get getSchoolID {
    return schoolID;
  }

  set setSchoolID(int schoolID) {
    this.schoolID = schoolID;
  }

  String get getSchoolName {
    return schoolName;
  }

  set getSchoolName(String schoolName) {
    this.schoolName = schoolName;
  }

  String get getSchoolAddress {
    return schoolAddress;
  }

  set getSchoolAddress(String schoolAddress) {
    this.schoolAddress = schoolAddress;
  }

  int get getSchoolLevel {
    return schoolLevel;
  }

  set getSchoolLevel(int schoolLevel) {
    this.schoolLevel = schoolLevel;
  }

  int get getAreaID {
    return areaID;
  }

  set setAreaID(int areaID) {
    this.areaID = areaID;
  }
}
