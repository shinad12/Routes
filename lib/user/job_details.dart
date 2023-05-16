import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:routesapplications/sharedPreferences.dart';
import 'package:routesapplications/user/jobapplyform.dart';

class JobDetailPage extends StatefulWidget {
  String industry,
      description,
      id,
      qualification,
      location,
      position,
      skills,
      salary;
  JobDetailPage(
      {required this.industry,
      required this.id,
      required this.description,
      required this.qualification,
      required this.salary,
      required this.location,
      required this.position,
      required this.skills});

  // static Route<T> getJobDetail<T>() {
  //   return MaterialPageRoute(
  //     builder: (_) => JobDetailPage(),
  //   );
  // }

  static const kBlack = const Color(0xFF000000);
  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  late UserSimplePreferences sharedPreference;
  String? type = UserSimplePreferences.getType();

  Widget _header(BuildContext context) {
    log("type ===========" + type.toString());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26, vertical: 26),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/logo/gitlab.png', height: 40),
              SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.industry,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.location,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 32),
          Row(
            children: [
              _headerStatic("Salary", widget.salary),
              _headerStatic("Applicants", "45"),
              // _headerStatic("Salary", "\$120,000"),
            ],
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Image.asset('assets/icon/document.png',
                    height: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Expanded(
                child: Image.asset('assets/icon/museum.png',
                    height: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Expanded(
                child: Image.asset('assets/icon/wall-clock.png',
                    height: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              Expanded(
                child: Image.asset('assets/icon/map.png',
                    height: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
          Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            height: 25,
          )
        ],
      ),
    );
  }

  Widget _headerStatic(String title, String sub) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          SizedBox(height: 5),
          Text(
            sub,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          )
        ],
      ),
    );
  }

  Widget _jobDescription(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Job Position",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            widget.position,
            // "You will be Gitlab's dedicated UI/Ux designer, reporting to the chief Technology Officer. You will come up with the user experience for few product features, including developing conceptual design to test with clients and then. Share the...",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          SizedBox(height: 20),
          Text(
            "Job Responsibility",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            widget.description,
            // "You will be Gitlab's dedicated UI/Ux designer, reporting to the chief Technology Officer. You will come up with the user experience for few product features, including developing conceptual design to test with clients and then. Share the...",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          SizedBox(height: 20),
          Text(
            "Job Qualification",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            widget.qualification,
            // "You will be Gitlab's dedicated UI/Ux designer, reporting to the chief Technology Officer. You will come up with the user experience for few product features, including developing conceptual design to test with clients and then. Share the...",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          SizedBox(height: 20),
          Text(
            "Skills",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            widget.skills,
            // "You will be Gitlab's dedicated UI/Ux designer, reporting to the chief Technology Officer. You will come up with the user experience for few product features, including developing conceptual design to test with clients and then. Share the...",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
    );
  }

  // Widget _ourPeople(BuildContext context) {
  //   return Container(
  //     height: 92,
  //     padding: EdgeInsets.only(left: 16),
  //     margin: EdgeInsets.only(top: 30),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Our People",
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
  //         SizedBox(height: 12),
  //         Expanded(
  //           child: ListView(
  //             scrollDirection: Axis.horizontal,
  //             children: [],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _people(BuildContext context, {String? img, String? name}) {
    return Container(
      margin: EdgeInsets.only(right: 18),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(img!),
          ),
          SizedBox(height: 8),
          Text(name!,
              style:
                  TextStyle(fontSize: 10, color: Color.fromARGB(255, 0, 0, 0))),
        ],
      ),
    );
  }

  Widget _apply(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(top: 54),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 96, 125, 139)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JobApplyForm(
                            companyname: widget.industry,
                            position: widget.position,
                            jobid: widget.id,
                          )),
                );
              },
              child: Text(
                "Apply Now",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 250, 250, 250),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          SizedBox(
            height: 50,
            width: 60,
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              child: Icon(
                Icons.bookmark_border,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        // toolbarHeight: 100,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        textTheme: TextTheme(
          headline6: TextStyle(
              color: Color(0XFF888888),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _jobDescription(context),
            ],
          ),
        ],
      ),
      bottomSheet: type == "0" ? _apply(context) : SizedBox(),
    );
  }
}
