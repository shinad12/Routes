import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/user/job_details.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late Future<List<Jobmodel>> joblist;

  Future<List<Jobmodel>> getjob() async {
    log("inside");

    final response =
        await http.get(Uri.parse(commonUrl().url + "user_home.jsp"));

    if (response.statusCode == 200) {
      // log(response.statusCode.t);
      log("statusCode====" + response.statusCode.toString());
      // var abc = response.body;
      // log('response result=' + response.body);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      log("parsed====" +
          json.decode(response.body).cast<Map<String, dynamic>>().toString());
      print(parsed);
      log("response====" + response.body);

      return parsed.map<Jobmodel>((json) => Jobmodel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load course');
    }
  }

  @override
  void initState() {
    joblist = getjob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder<List<Jobmodel>>(
            future: getjob(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                log("length --" + snapshot.data!.length.toString());
                return (ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final jobitem = snapshot.data![index];
                    return Container(
                      // height: 150,
                      child: Card(
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JobDetailPage(
                                        salary: jobitem.salary,
                                        industry: jobitem.industry,
                                        id: jobitem.id,
                                        description: jobitem.responsibility,
                                        qualification: jobitem.qualification,
                                        location: jobitem.location,
                                        position: jobitem.position,
                                        skills: jobitem.skills,
                                      )),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              dense: false,
                              leading: Image.asset('assets/logo/gitlab.png'),
                              title: Text(
                                jobitem.industry,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobitem.location,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    jobitem.position,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class Jobmodel {
  Jobmodel({
    required this.id,
    required this.salary,
    required this.position,
    required this.location,
    required this.qualification,
    required this.responsibility,
    required this.username,
    required this.skills,
    required this.industry,
  });

  String id;
  String position;
  String location;
  String qualification;
  String responsibility;
  String username;
  String skills;
  String industry;
  String salary;

  factory Jobmodel.fromJson(Map<String, dynamic> json) => Jobmodel(
        id: json["id"],
        position: json["position"],
        salary: json["salary"],
        location: json["location"],
        qualification: json["qualification"],
        responsibility: json["responsibility"],
        username: json["username"],
        skills: json["skills"],
        industry: json["industry"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "location": location,
        "qualification": qualification,
        "responsibility": responsibility,
        "username": username,
        "skills": skills,
        "industry": industry,
      };
}
