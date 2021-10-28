class Strings {
  static String courses_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/courses";
  static String courses_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/courses/$id";
  }

  static String tutors_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutors";
  static String tutors_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutors/$id";
  }

  static String tutorrequests_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutor-requests";
  static String tutorrequests_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutor-requests/$id";
  }

  static String createCourses =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/courses";

  static String signin_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/auth/sign-in-tutor";

  static String class_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/classes";
  static String class_for_calendar_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/classes?PageSize=1000";
  static String class_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/classess/$id";
  }
}
