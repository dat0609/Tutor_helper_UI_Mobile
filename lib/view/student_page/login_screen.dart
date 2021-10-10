import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_helper/api/api_manage.dart';
import 'package:tutor_helper/model/tutors.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  _StudentLoginPageState createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  late Future<Tutors> _tutors;

  @override
  void initState() {
    _tutors = API_Manager().getTutors();
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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
                      "Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Login to your account",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () async {
                        await _googleSignIn.signIn();
                        setState(() {});
                        FutureBuilder<Tutors>(
                            future: _tutors,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.data.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.data[index];

                                    return Text("");
                                  },
                                );
                              } else {
                                return const Text("");
                              }
                            });
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
