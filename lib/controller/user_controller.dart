import 'package:get/get.dart';

class UserArguments extends GetxController {
  UserArguments({required this.accessToken, required this.idToken});
  final String accessToken;
  final String idToken;
}
