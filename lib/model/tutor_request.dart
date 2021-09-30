class TutorRequest {
  int tutorRequestID;
  String title;
  String description;
  bool status;
  int studentID;
  int subjectID;
  int gradeID;
  DateTime createAt;
  DateTime updateAt;

  TutorRequest(
      this.tutorRequestID,
      this.title,
      this.description,
      this.status,
      this.studentID,
      this.subjectID,
      this.gradeID,
      this.createAt,
      this.updateAt);

  int get gettutorRequestID {
    return tutorRequestID;
  }

  set settutorRequestID(int tutorRequestID) {
    this.tutorRequestID = tutorRequestID;
  }

  String get gettitle {
    return title;
  }

  set settitle(String title) {
    this.title = title;
  }

  String get getdescription {
    return description;
  }

  set setdescription(String description) {
    this.description = description;
  }

  bool get getstatus {
    return status;
  }

  set setstatus(bool status) {
    this.status = status;
  }

  int get getstudentID {
    return studentID;
  }

  set setstudentID(int studentID) {
    this.studentID = studentID;
  }

  int get getsubjectID {
    return subjectID;
  }

  set setsubjectID(int subjectID) {
    this.subjectID = subjectID;
  }

  int get getgradeID {
    return gradeID;
  }

  set setgradeID(int gradeID) {
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
