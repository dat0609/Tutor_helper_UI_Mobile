class Role {
  int roleID;
  String roleName;

  Role(this.roleID, this.roleName);

  int get getRoleID {
    return roleID;
  }

  set setRoleID(int roleID) {
    this.roleID = roleID;
  }

  String get getRoleName {
    return roleName;
  }

  set getRoleName(String roleName) {
    this.roleName = roleName;
  }
}
