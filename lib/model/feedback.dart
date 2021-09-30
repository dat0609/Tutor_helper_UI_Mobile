class Feedback {
  int feedbackID;
  int ratingScore;
  String feedbackContent;
  DateTime createAt;
  DateTime updateAt;

  Feedback(this.feedbackID, this.ratingScore, this.feedbackContent,
      this.createAt, this.updateAt);
  int get getfeedbackID {
    return feedbackID;
  }

  set setfeedbackID(int feedbackID) {
    this.feedbackID = feedbackID;
  }

  int get getratingScore {
    return ratingScore;
  }

  set setratingScore(int ratingScore) {
    this.ratingScore = ratingScore;
  }

  String get getfeedbackContent {
    return feedbackContent;
  }

  set setfeedbackContent(String feedbackContent) {
    this.feedbackContent = feedbackContent;
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
