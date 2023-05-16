import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';
import 'package:routesapplications/user/JOBSEEKER_HOMEPAGE.dart';
import 'package:http/http.dart' as http;

class Appliedjob extends StatelessWidget {
  late UserSimplePreferences sharedPreference;
  String? username = UserSimplePreferences.getUsername();
  Future<List<AppliedJobModel>> fetchPost(String username) async {
    final response = await http.post(
        Uri.parse(commonUrl().url + 'viewappliedjobs.jsp'),
        body: {'username': username});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<AppliedJobModel>((json) => AppliedJobModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  context, MaterialPageRoute(builder: (context) => NavPage()));
            }),
        elevation: 0,
        title: Text(
          "Applied Jobs",
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

              FutureBuilder<List<AppliedJobModel>>(
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
                                            "Company Name   :  ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Expanded(
                                            child: Text(
                                                // comp.title,
                                                // "Aloshya",
                                                jobappliedItems.industry,
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
                                              "Location               :  ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // "aloshya@gmail,com",
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
                                              "Phone Number    : ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // comp.description,
                                                // "1111111111",
                                                jobappliedItems.phone,
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

List<AppliedJobModel> appliedJobModelFromJson(String str) =>
    List<AppliedJobModel>.from(
        json.decode(str).map((x) => AppliedJobModel.fromJson(x)));

String appliedJobModelToJson(List<AppliedJobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppliedJobModel {
  AppliedJobModel({
    required this.industry,
    required this.phone,
    required this.location,
    required this.position,
  });

  String industry;
  String phone;
  String location;
  String position;

  factory AppliedJobModel.fromJson(Map<String, dynamic> json) =>
      AppliedJobModel(
        industry: json["industry"],
        phone: json["phone"],
        location: json["location"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "industry": industry,
        "phone": phone,
        "location": location,
        "position": position,
      };
}
