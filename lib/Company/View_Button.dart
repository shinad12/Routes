// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:routesapplications/commonurl.dart';
// import 'package:routesapplications/user/job_details.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class viewjob extends StatefulWidget {
//   @override
//   State<viewjob> createState() => _homeScreenState();
// }

// class _homeScreenState extends State<viewjob> {
//   late Future<List<Jobmodel>> joblist;

//   Future<List<Jobmodel>> getjob(String Email) async {
//     log("inside");

//     final Map<String, dynamic> loginData = {'Email': Email};

//     // final url = "http://192.168.39.118:8080/communityApp/login.jsp";
//     final response = await http.post(
//       Uri.parse(commonUrl().url + "PostJob.jsp"),
//       body: loginData,
//     );

//     // final response =
//     //     await http.post(Uri.parse(commonUrl().url + "PostJob.jsp"));

//     if (response.statusCode == 200) {
//       // log(response.statusCode.t);
//       log("statusCode====" + response.statusCode.toString());
//       // var abc = response.body;
//       // log('response result=' + response.body);
//       final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//       log("parsed====" +
//           json.decode(response.body).cast<Map<String, dynamic>>().toString());
//       print(parsed);
//       log("response====" + response.body);

//       return parsed.map<Jobmodel>((json) => Jobmodel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load course');
//     }
//   }

//   SharedPreferences? _preferences;
//   late String Email;
//   void getsession() async {
//     SharedPreferences? _preferences;

//     _preferences = await SharedPreferences.getInstance();

//     setState(() {
//       Email = _preferences!.getString('Email')!;

//       print("Email====" + Email);
//     });
//     //await _preferences!.setBool(_islogin, false);
//     // _preferences.remove('Email');
//   }

//   @override
//   void initState() {
//     getsession();
//     //joblist = getjob(username);
//     super.initState();
//     log("inside initsate");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: FutureBuilder<List<Jobmodel>>(
//             future: getjob(Email),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return (ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final jobitem = snapshot.data![index];
//                     return Container(
//                       // height: 150,
//                       child: Card(
//                         elevation: 9,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                         ),
//                         clipBehavior: Clip.hardEdge,
//                         child: InkWell(
//                           splashColor: Colors.blue.withAlpha(30),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => JobDetailPage(
//                                       salary: jobitem.salary,
//                                       skills: jobitem.skills,
//                                       industry: jobitem.industry,
//                                       id: jobitem.id,
//                                       description: jobitem.responsibility,
//                                       qualification: jobitem.qualification,
//                                       location: jobitem.location,
//                                       position: jobitem.position)),
//                             );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ListTile(
//                               dense: false,
//                               leading: Image.asset('assets/logo/gitlab.png'),
//                               title: Text(
//                                 jobitem.industry,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20),
//                               ),
//                               subtitle: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     jobitem.location,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     jobitem.position,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                 ],
//                               ),
//                               trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ));
//               }
//               return Center(child: CircularProgressIndicator());
//             }));
//   }
// }

// class Jobmodel {
//   Jobmodel({
//     required this.id,
//     required this.position,
//     required this.location,
//     required this.salary,
//     required this.qualification,
//     required this.responsibility,
//     required this.username,
//     required this.skills,
//     required this.industry,
//   });

//   String id;
//   String position;
//   String location;
//   String qualification;
//   String responsibility;
//   String username;
//   String skills;
//   String salary;
//   String industry;

//   factory Jobmodel.fromJson(Map<String, dynamic> json) => Jobmodel(
//         id: json["id"],
//         position: json["position"],
//         salary: json["salary"],
//         location: json["location"],
//         qualification: json["qualification"],
//         responsibility: json["responsibility"],
//         username: json["username"],
//         skills: json["skills"],
//         industry: json["industry"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "position": position,
//         "location": location,
//         "qualification": qualification,
//         "responsibility": responsibility,
//         "username": username,
//         "skills": skills,
//         "industry": industry,
//       };
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routesapplications/Company/COMPANY_HOMEPAGE.dart';
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';
import 'package:http/http.dart' as http;

class ViewJobAppliedSection extends StatelessWidget {
  late UserSimplePreferences sharedPreference;
  String? username = UserSimplePreferences.getUsername();
  Future<List<ViewApplyUsersModel>> fetchPost(String username) async {
    final response = await http.post(
        Uri.parse("${commonUrl().url}Viewappliedusers.jsp"),
        body: {'username': username});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ViewApplyUsersModel>(
              (json) => ViewApplyUsersModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("username >>>>>>>>>>>>>>>>>>>>000000000000>>>>>>" +
        username.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              print("clicked====");
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => NavPage1()));
            }),
        elevation: 0,
        title: Text(
          "Job Applicants",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // CustomActionBar(
          //   backArrow: true,
          //   title: "Applied Jobs",
          //   //  head: true,
          // ),
          Expanded(
              child: Stack(
            children: [
              // FutureBuilder(
              //     future: vm.getJobAppliedItems(username, jobid),
              //     builder: (BuildContext context,
              //         AsyncSnapshot<List<JobAppliedViewModel>> snapshot) {
              //       print("snap____________" + snapshot.data.toString());
              //       switch (snapshot.connectionState) {
              //         case ConnectionState.done:
              //           {
              //             print("vm.jobappliedItems.length________________" +
              //                 vm.jobappliedItems.length.toString());
              //             return

              FutureBuilder<List<ViewApplyUsersModel>>(
                future: fetchPost(username.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final jobappliedItems = snapshot.data![index];
                          return
                              // children: [
                              Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height/4,
                            child: Card(
                                shadowColor: Colors.white,
                                elevation: 12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                child: Column(children: [
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text(
                                              jobappliedItems.position,
                                              // "Software Engineer",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            // Text(
                                            //   // "Software Engineer",
                                            //   style: TextStyle(
                                            //       fontSize: 13,
                                            //       fontWeight:
                                            //           FontWeight.w600,
                                            //       color: Colors.grey),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 70,
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Text(
                                            "Name             :  ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(
                                            child: Text(
                                                // comp.title,
                                                // "Aloshya",
                                                jobappliedItems.name,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                )),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "Email :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // "aloshya@gmail,com",
                                                jobappliedItems.email,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "phonenumber :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "1111111111",
                                                jobappliedItems.phonenumber,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "experience :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "Fresher",
                                                jobappliedItems.experience,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "location :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "location",
                                                jobappliedItems.location,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "qualification :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "bca",
                                                jobappliedItems.qualification,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "skills :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "flutter",
                                                jobappliedItems.skills,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Wrap(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(

                                          // runSpacing: 4,
                                          // alignment:WrapAlignment.start ,
                                          //  // verticalDirection: VerticalDirection.up,
                                          //
                                          //
                                          //   runAlignment: WrapAlignment.end,
                                          // direction: Axis.vertical,
                                          children: [
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Text(
                                              "specialisation :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "flutter",
                                                jobappliedItems.specialisation,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(

                                        // runSpacing: 4,
                                        // alignment: WrapAlignment.start,
                                        //
                                        //
                                        // runAlignment: WrapAlignment.end,
                                        // direction: Axis.vertical,
                                        children: [
                                          SizedBox(
                                            width: 14,
                                          ),
                                          // Text(
                                          //   "Status          :  ",
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight:
                                          //           FontWeight.w500),
                                          // ),
                                          // Expanded(
                                          //   child: Text(
                                          //     comp.status,
                                          //     style: TextStyle(
                                          //       fontSize: 16,
                                          //     ),
                                          //   ),
                                          // )
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                ])),
                          );
                          // ]
                          // }
                          //             });
                          //       }
                          //     default:
                          //       return Center(child: CircularProgressIndicator());
                          //   }
                          // }),
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
// To parse this JSON data, do
//
//     final viewApplyUsersModel = viewApplyUsersModelFromJson(jsonString);

List<ViewApplyUsersModel> viewApplyUsersModelFromJson(String str) =>
    List<ViewApplyUsersModel>.from(
        json.decode(str).map((x) => ViewApplyUsersModel.fromJson(x)));

String viewApplyUsersModelToJson(List<ViewApplyUsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewApplyUsersModel {
  ViewApplyUsersModel({
    required this.id,
    required this.position,
    required this.email,
    required this.name,
    required this.phonenumber,
    required this.location,
    required this.qualification,
    required this.specialisation,
    required this.skills,
    required this.experience,
  });

  String id;
  String position;
  String email;
  String phonenumber;
  String location;
  String qualification;
  String specialisation;
  String skills, name, experience;

  factory ViewApplyUsersModel.fromJson(Map<String, dynamic> json) =>
      ViewApplyUsersModel(
        id: json["id"],
        experience: json["experience"],
        position: json["position"],
        email: json["username"],
        phonenumber: json["phonenumber"],
        location: json["location"],
        name: json["name"],
        qualification: json["qualification"],
        specialisation: json["specialisation"],
        skills: json["skills"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'name': name,
        'experience': experience,
        "position": position,
        "username": email,
        "phonenumber": phonenumber,
        "location": location,
        "qualification": qualification,
        "specialisation": specialisation,
        "skills": skills,
      };
}
