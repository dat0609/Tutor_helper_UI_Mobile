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
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final _googleSignInAccount = await _googleSignIn.signIn();
      if (_googleSignInAccount == null) {
        setState(() {});
        return;
      }
      final _googleSigninAuthentication =
          await _googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: _googleSigninAuthentication.accessToken,
        idToken: _googleSigninAuthentication.idToken,
      );
      String accessToken = _googleSigninAuthentication.accessToken.toString();
      String idToken = _googleSigninAuthentication.idToken.toString();
      await FirebaseAuth.instance.signInWithCredential(credential);
      await storage.write(key: "accessToken", value: accessToken);
      await storage.write(key: "idToken", value: idToken);
      await https.post(Uri.parse(Strings.signin_url), headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "idToken": idToken,
        "role": "tutor",
        "accessToken": accessToken,
      });

      Get.to(() => const TutorManagement());
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = 'This account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          content = 'The user you tried to log into was not found';
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Log in with Google failed'),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'))
                ],
              ));
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
