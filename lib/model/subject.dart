class Subject {
  int subjectID;
  String subjectName;
  int gradeID;

  Subject(this.subjectID, this.subjectName, this.gradeID);

  int get getsubjectID {
    return subjectID;
  }

  set setsubjectID(int subjectID) {
    this.subjectID = subjectID;
  }

  String get getsubjectName {
    return subjectName;
  }

  set getsubjectName(String subjectName) {
    this.subjectName = subjectName;
  }

  int get getgradeID {
    return gradeID;
  }

  set setgradeID(int gradeID) {
    this.gradeID = gradeID;
  }
}
