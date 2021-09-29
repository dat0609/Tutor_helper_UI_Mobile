class User {
  String userID;
  String fullName;
  String phoneNumber;
  late DateTime createAt;
  late DateTime updateAt;

  User(this.userID, this.fullName, this.phoneNumber, this.createAt,
      this.updateAt);

  String get getUserID {
    return userID;
  }

  set setUserID(String userID) {
    this.userID = userID;
  }

  String get getFullName {
    return fullName;
  }

  set getFullName(String fullName) {
    this.fullName = fullName;
  }

  String get getPhoneNumber {
    return phoneNumber;
  }

  set setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  DateTime get getCreateAt {
    return createAt;
  }

  set setCreateAt(DateTime createAt) {
    this.createAt = createAt;
  }

  DateTime get getUpdateAtt {
    return createAt;
  }

  set setUpdateAt(DateTime updateAt) {
    this.updateAt = updateAt;
  }
}

class Student extends User {
  String schoolID = '';
  String gradeID = '';

  Student(this.schoolID, this.gradeID, String userID, String fullName,
      String phoneNumber, DateTime createAt, DateTime updateAt)
      : super(userID, fullName, phoneNumber, createAt, updateAt) {
    super.userID = userID;
    super.fullName = fullName;
    super.phoneNumber = phoneNumber;
    super.createAt = createAt;
    super.updateAt = updateAt;
  }

  String get getSchoolID {
    return schoolID;
  }

  set setSchoolID(String schoolID) {
    this.schoolID = schoolID;
  }

  String get getGradeID {
    return gradeID;
  }

  set setGradeID(String gradeID) {
    this.gradeID = gradeID;
  }
}
