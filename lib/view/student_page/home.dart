import 'package:flutter/material.dart';
import 'package:tutor_helper/model/tutors.dart';
import 'package:tutor_helper/presenter/date_time_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_helper/view/student_page/profile.dart';
import 'package:tutor_helper/api/api_manage.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  late Future<Tutors> _tutors;

  @override
  void initState() {
    _tutors = API_Manager().getTutors();
    super.initState();
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
                  //       return const Text("");
                  //     }
                  //   },
                  // ),
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
        // child: FutureBuilder<Tutors>(
        // future: _tutors,
        // builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   return ListView.builder(
        //     itemCount: snapshot.data!.data.classes.length,
        //     itemBuilder: (context, index) {
        //       var data = snapshot.data!.data.classes;
        //       return SizedBox(
        //         height: 100,
        //         child: ListTile(
        //             title: Text(data[index].title,
        //                 style:
        //                     const TextStyle(fontWeight: FontWeight.bold)),
        //             subtitle: Text(data[index].description,
        //                 maxLines: 2, overflow: TextOverflow.ellipsis),
        //             focusColor: Colors.amber,
        //             trailing: Text(
        //                 data[index].status == true ? "Ok" : "Failed"),
        //             onTap: () {
        //               // ignore: avoid_print
        //               print(data[index].id);
        //             }),
        //       );
        //     },
        //   );
        // } else {
        //   return const Text("");
        // }
        // }),
      ),
    );
  }

  Container buildTaskItem(int numDays, String courseTitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deadline",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "$numDays days left",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            child: Text(
              courseTitle,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
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

  Container buildClassItem(DateTime time, String subjectName, String address,
      String tutorImage, String tutorName) {
    DateTimeTutor dtt = DateTimeTutor();
    String timeString = dtt.timeFormat.format(time).split(" ")[0];
    String midday = dtt.timeFormat.format(time).split(" ")[1];
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
                timeString, //Time
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                midday, //Midday
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
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
                  subjectName, //Subject Name
                  overflow: TextOverflow.ellipsis,
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
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      address, //Address
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(tutorImage //Tutor Image
                        ),
                    radius: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    tutorName, //TutorName
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
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
