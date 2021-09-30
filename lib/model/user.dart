class User {
  int userID;
  String email;
  int roleID;

  User(this.userID, this.email, this.roleID);

  int get getUserID {
    return userID;
  }

  set setUserID(int userID) {
    this.userID = userID;
  }

  String get getEmail {
    return email;
  }

  set getEmail(String email) {
    this.email = email;
  }

  int get getRoleID {
    return roleID;
  }

  set setRoleID(int roleID) {
    this.roleID = roleID;
  }
}
