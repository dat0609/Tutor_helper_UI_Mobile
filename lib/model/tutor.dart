import 'user.dart';

class Tutor extends User {
  String fullName;
  String phoneNumber;
  DateTime createAt;
  DateTime updateAt;

  Tutor(this.fullName, this.phoneNumber, this.createAt, this.updateAt,
      int userID, String email, int roleID)
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

  String get getphoneNumber {
    return phoneNumber;
  }

  set setphoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
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
