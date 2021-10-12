import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_helper/constants/strings.dart';
import 'package:tutor_helper/view/tutor_page/tutor_management.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as https;

class TutorLoginPage extends StatefulWidget {
  const TutorLoginPage({Key? key}) : super(key: key);

  @override
  _TutorLoginPageState createState() => _TutorLoginPageState();
}

class _TutorLoginPageState extends State<TutorLoginPage> {
  final storage = const FlutterSecureStorage();
  void _loginWithGoogle() async {
    setState(() {});
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(googleCredential);
    final tokenResult =
        await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final bodies = jsonEncode({
      "idToken": tokenResult,
      "role": "Tutor",
      "accessToken": "string",
      "providerId": "string",
      "signInMethod": "Google"
    });
    final response = await https.post(Uri.parse(Strings.signin_url),
        headers: headers, body: bodies);
    if (response.statusCode == 200) {
      storage.write(
          key: "jwtToken",
          value: jsonDecode(response.body)['data']['jwtToken']);
      // log(jsonDecode(response.body)['data'].toString());
      Get.offAll(() => const TutorManagement());
    }
  }

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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Hello tutor,Let's Login to your account",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        setState(() {});
                        _loginWithGoogle();
                      },
                    )
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
