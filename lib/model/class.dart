class Class {
  int classID;
  DateTime startTime;
  DateTime endTime;
  int courseID;
  int feedbackID;
  DateTime createAt;
  DateTime updateAt;

  Class(this.classID, this.startTime, this.endTime, this.courseID,
      this.feedbackID, this.createAt, this.updateAt);

  int get getclassID {
    return classID;
  }

  set setcclassID(int classID) {
    this.classID = classID;
  }

  DateTime get getstartTime {
    return startTime;
  }

  set setstartTime(DateTime startTime) {
    this.startTime = startTime;
  }

  DateTime get getendTime {
    return endTime;
  }

  set setendTime(DateTime endTime) {
    this.endTime = endTime;
  }

  int get getcourseID {
    return courseID;
  }

  set setcourseID(int courseID) {
    this.courseID = courseID;
  }

  int get getfeedbackID {
    return feedbackID;
  }

  set setfeedbackID(int feedbackID) {
    this.feedbackID = feedbackID;
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
