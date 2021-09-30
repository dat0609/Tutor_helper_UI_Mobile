class Course {
  int courseID;
  String title;
  String description;
  bool status;
  int tutorID;
  int tutorRequestID;
  DateTime createAt;
  DateTime updateAt;

  Course(this.courseID, this.title, this.description, this.status, this.tutorID,
      this.tutorRequestID, this.createAt, this.updateAt);

  int get getcourseID {
    return courseID;
  }

  set setcourseID(int courseID) {
    this.courseID = courseID;
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

  int get gettutorID {
    return tutorID;
  }

  set settutorID(int tutorID) {
    this.tutorID = tutorID;
  }

  int get gettutorRequestID {
    return tutorRequestID;
  }

  set settutorRequestID(int tutorRequestID) {
    this.tutorRequestID = tutorRequestID;
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
