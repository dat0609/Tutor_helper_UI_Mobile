import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutor_helper/model/courses.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/view/tutor_page/profile.dart';
import 'package:tutor_helper/api/api_manage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TutorHomePage extends StatefulWidget {
  const TutorHomePage({Key? key}) : super(key: key);

  @override
  _TutorHomePageState createState() => _TutorHomePageState();
}

class _TutorHomePageState extends State<TutorHomePage> {
  final storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: "jwtToken");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_upper(), _under()]);
  }

  Container _upper() {
    initializeDateFormatting('vi', null);
    final DateTime now = DateTime.now();
    DateTimeTutor dtt = DateTimeTutor();
    String imageLink = "assets/images/default_avatar.png";

    return Container(
      decoration: const BoxDecoration(
          //color: Color(0xFFD4E7FE),
          gradient: LinearGradient(
              colors: [
                Color(0xFFD4E7FE),
                Color(0xFFF0F0F0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.3])),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                  text: dtt.dateOfWeekFormat.format(now),
                  style: const TextStyle(
                      color: Color(0XFF263064),
                      fontSize: 12,
                      fontWeight: FontWeight.w900),
                  children: [
                    TextSpan(
                      text: " " + dtt.dateFormat.format(now),
                      style: const TextStyle(
                          color: Color(0XFF263064),
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    )
                  ]),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 8,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    child: Image.asset(
                      imageLink,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TutorEditProfilePage()),
                      );
                    },
                  )),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String?>(
                    future: _getToken(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var token = snapshot.data;
                        Map<String, dynamic> tokenData = Jwt.parseJwt(token!);
                        var emailString =
                            tokenData['email'].toString().split("@");
                        return Text(
                          "Hi  " + emailString[0],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color(0XFF343E87),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return const Text("");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Here is a list of schedule",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "You need to check...",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Positioned _under() {
    return Positioned(
      top: 185,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height - 245,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FutureBuilder<String?>(
          future: _getToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var token = snapshot.data;
              return FutureBuilder<Courses>(
                future: API_Manager().getCourses(token),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.data[index];
                          return buildClassItem(data.title, data.description);
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Text("");
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Text("");
            }
          },
        ),
      ),
    );
  }

  Container buildClassItem(String subjectName, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 60,
                child: Text(
                  subjectName.trim(), //Subject Name
                  overflow: TextOverflow.clip,
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Text(
                      description.trim(), //Address
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
