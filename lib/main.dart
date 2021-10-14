import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const TutorHelper());
}

class TutorHelper extends StatefulWidget {
  const TutorHelper({Key? key}) : super(key: key);

  @override
  _TutorHelperState createState() => _TutorHelperState();
}

class _TutorHelperState extends State<TutorHelper> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
