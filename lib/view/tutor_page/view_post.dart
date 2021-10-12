import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:tutor_helper/api/api_manage.dart';
import 'package:tutor_helper/model/tutor_requests.dart';
import 'package:tutor_helper/view/tutor_page/profile.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/view/tutor_page/view_post_detail.dart';

class TutorViewPost extends StatefulWidget {
  const TutorViewPost({Key? key}) : super(key: key);

  @override
  _TutorViewPostState createState() => _TutorViewPostState();
}

class _TutorViewPostState extends State<TutorViewPost> {
  final storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: "jwtToken");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imageLink = "assets/images/default_avatar.png";
    initializeDateFormatting('vi', null);
    final DateTime now = DateTime.now();
    DateTimeTutor dt = DateTimeTutor();

    return Stack(
      children: [
        Container(
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
                      text: dt.dateOfWeekFormat.format(now),
                      style: const TextStyle(
                          color: Color(0XFF263064),
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                      children: [
                        TextSpan(
                          text: " " + dt.dateFormat.format(now),
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

                        // image: const DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: NetworkImage(
                        //       "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
                        // ),
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
                            Map<String, dynamic> tokenData =
                                Jwt.parseJwt(token!);
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
                        height: 18,
                      ),
                      const Text(
                        "Check out some post of students",
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
        ),
        Positioned(
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
                  return FutureBuilder<TutorRequests>(
                    future: API_Manager().getTutorRequests(token),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.data[index];
                              return buildClassItem(
                                  data.title,
                                  data.description,
                                  "Name",
                                  data.tutorRequestId);
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
        ),
      ],
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        const Text(
          "See all",
          style: TextStyle(
              fontSize: 12,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Container buildClassItem(String courseTitle, String description,
      String fullName, int tutorRequestID) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  courseTitle,
                  style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  description,
                  style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  fullName,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                // ignore: avoid_print
                onPressed: () {
                  Get.to(() => const TutorViewPostDetail(),
                      arguments: tutorRequestID);
                },
                icon: const Icon(Icons.arrow_right),
              ),
            ],
          )
        ],
      ),
    );
  }
}
