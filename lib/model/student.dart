import 'user.dart';

class Student extends User {
  String fullName;
  String phoneNumber;
  int schoolID;
  int gradeID;
  DateTime createAt;
  DateTime updateAt;

  Student(this.fullName, this.phoneNumber, this.schoolID, this.gradeID,
      this.createAt, this.updateAt, int userID, String email, int roleID)
      : super(userID, email, roleID) {
    super.userID = userID;
    super.email = email;
    super.roleID = roleID;
  }

  String get getFullName {
    return fullName;
  }

  set setfullName(String fullName) {
    this.fullName = fullName;
  }

  int get getSchoolID {
    return schoolID;
  }

  set setSchoolID(int schoolID) {
    this.schoolID = schoolID;
  }

  String get getphoneNumber {
    return phoneNumber;
  }

  set setphoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  int get getGradeID {
    return gradeID;
  }

  set setGradeID(int gradeID) {
    this.gradeID = gradeID;
  }

  DateTime get getcreateAt {
    return createAt;
  }

  set setcreateAt(DateTime createAt) {
    this.createAt = createAt;
  }

  DateTime get getupdateAt {
    return updateAt;
  }

  set setupdateAt(DateTime updateAt) {
    this.updateAt = updateAt;
  }
}
