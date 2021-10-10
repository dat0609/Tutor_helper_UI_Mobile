import 'package:flutter/material.dart';
import 'package:tutor_helper/api/api_manage.dart';
import 'package:tutor_helper/model/tutors.dart';
import 'package:tutor_helper/view/student_page/profile.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';

class StudentViewPost extends StatefulWidget {
  const StudentViewPost({Key? key}) : super(key: key);

  @override
  _StudentViewPostState createState() => _StudentViewPostState();
}

class _StudentViewPostState extends State<StudentViewPost> {
  late Future<Tutors> _tutors;

  @override
  void initState() {
    _tutors = API_Manager().getTutors();
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
                      style: TextStyle(
                          color: Color(0XFF263064),
                          fontSize: 12,
                          fontWeight: FontWeight.w900),
                      children: [
                        TextSpan(
                          text: " " + dt.dateFormat.format(now),
                          style: TextStyle(
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
                                builder: (context) => StudentEditProfilePage()),
                          );
                        },
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FutureBuilder<Tutors>(
                      //   future: _tutors,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       // String fullName = snapshot.data!.data.fullName;
                      //       return Text(
                      //         "Hi $fullName",
                      //         style: const TextStyle(
                      //           fontSize: 25,
                      //           fontWeight: FontWeight.w900,
                      //           color: Color(0XFF343E87),
                      //         ),
                      //       );
                      //     } else if (snapshot.hasError) {
                      //       return Text('${snapshot.error}');
                      //     } else {
                      //       return const CircularProgressIndicator();
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
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
            child: ListView(
              children: [
                buildTitleRow("Student posts", 2),
                const SizedBox(
                  height: 20,
                ),
                buildClassItem(
                    "Math 2", "1050 CMT8", "3/10/2021", "Loc", "Picture"),
                buildClassItem("English 4", "391 Cộng Hòa", "9/11/2021", "Anh",
                    "Picture 2"),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        )
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

  Container buildClassItem(String courseTitle, String address, String date,
      String fullName, String imageLink) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Start",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  courseTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Text(
                          address,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageLink),
                    radius: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    fullName,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     IconButton(
              //       // ignore: avoid_print
              //       onPressed: () {
              //         print("123");
              //       },
              //       icon: const Icon(Icons.volume_up),
              //     ),
              //   ],
              // )
            ],
          )
        ],
      ),
    );
  }
}