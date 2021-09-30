class Grade {
  int gradeID;
  String gradeName;

  Grade(this.gradeID, this.gradeName);

  int get getGradeID {
    return gradeID;
  }

  set setGradeID(int gradeID) {
    this.gradeID = gradeID;
  }

  String get getGradeName {
    return gradeName;
  }

  set getGradeName(String gradeName) {
    this.gradeName = gradeName;
  }
}
