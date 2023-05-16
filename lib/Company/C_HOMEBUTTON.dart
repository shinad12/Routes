import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';
import 'package:routesapplications/user/job_details.dart';

class ChomeScreen extends StatefulWidget {
  @override
  State<ChomeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<ChomeScreen> {
  late Future<List<Jobmodel>> joblist;

  Future<List<Jobmodel>> getjob(String username) async {
    log("inside getjob -");
    final Map<String, dynamic> Data = {
      'username': username,
    };
    final response = await http.post(
        Uri.parse(
          commonUrl().url + "c_home.jsp",
        ),
        body: Data);

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

  late UserSimplePreferences sharedPreference;
  String? username = UserSimplePreferences.getUsername();

  @override
  void initState() {
    joblist = getjob(username.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder<List<Jobmodel>>(
            future: getjob(username.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                log("inisde  ====");
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
    required this.position,
    required this.salary,
    required this.location,
    required this.qualification,
    required this.responsibility,
    required this.skills,
    required this.industry,
  });

  String id;
  String position;
  String location;
  String qualification;
  String salary;
  String responsibility;

  String skills;
  String industry;

  factory Jobmodel.fromJson(Map<String, dynamic> json) => Jobmodel(
        id: json["id"],
        salary: json["salary"],
        position: json["position"],
        location: json["location"],
        qualification: json["qualification"],
        responsibility: json["responsibility"],
        skills: json["skills"],
        industry: json["industry"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "location": location,
        "qualification": qualification,
        "responsibility": responsibility,
        "skills": skills,
        "industry": industry,
      };
}
