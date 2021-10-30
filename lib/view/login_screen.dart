import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_helper/view/student_page/student_login_screen.dart';
import 'package:tutor_helper/view/tutor_page/tutor_login_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://shopme-stored.s3.ap-southeast-1.amazonaws.com/login.png"),
                fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text(
                      "Please login...",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "What role are you?",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => const StudentLoginPage());
                          },
                          icon: const Icon(Icons.book_online_outlined),
                          label: const Text("Student"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.purple[900]),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => const TutorLoginPage());
                          },
                          icon: const Icon(Icons.class__outlined),
                          label: const Text("Tutor"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.cyan[800]),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
