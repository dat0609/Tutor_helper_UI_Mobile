import 'user.dart';

class Student extends User {
  String schoolID;
  String gradeID;

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
