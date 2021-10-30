// ignore_for_file: non_constant_identifier_names

class Strings {
  static String courses_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/courses?PageSize=10000";
  static String courses_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/courses/$id";
  }

  static String create_course =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/courses";

  static String tutors_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutors?PageSize=10000";
  static String tutors_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutors/$id";
  }

  static String tutorrequests_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutor-requests?PageSize=10000";
  static String tutorrequests_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/tutor-requests/$id";
  }

  static String student_signin_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/auth/sign-in-student";

  static String tutor_signin_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/auth/sign-in-tutor";

  static String class_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/classes";
  static String class_for_calendar_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/classes?PageSize=10000";
  static String class_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/classes/$id";
  }

  static String subject_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/subjects?PageSize=500";

  static String students_url =
      "https://tutorhelper20210920193710.azurewebsites.net/api/v1/students?PageSize=10000";
  static String student_get_url(int id) {
    return "https://tutorhelper20210920193710.azurewebsites.net/api/v1/students/$id";
  }
}
