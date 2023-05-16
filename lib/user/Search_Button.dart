import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';
import 'package:routesapplications/user/job_details.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  String? email;
  List<Jobmodel> productlist = [];
  List<Jobmodel> searchlist = [];

  Future<List<Jobmodel>> fetchProducts() async {
    final reponse =
        await http.get(Uri.parse(commonUrl().url + "user_home.jsp"));
    if (reponse.statusCode == 200) {
      log(reponse.body);
      List res = jsonDecode(reponse.body);
      return res.map((e) => Jobmodel.fromJson(e)).toList();
    } else {
      throw Exception("Faild");
    }
  }

  gedata() async {
    productlist = await fetchProducts();
  }

  late UserSimplePreferences sharedPreference;
  String? username = UserSimplePreferences.getUsername();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gedata();
  }

  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TextField(
                onChanged: (value) {
                  value = value.toLowerCase();
                  setState(() {
                    searchlist = productlist.where((element) {
                      var name = element.industry.toLowerCase();
                      return name.contains(value);
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearText,
                      // () {
                      //   /* Clear the search field */
                      // },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
                controller: fieldText,
              ),
            ),
            SizedBox(
              height: 700,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  // return UserTile(product: _searchlist[index-1],);
                  if (productlist.isNotEmpty) {
                    //   _isLoading=false;

                    return index == 0
                        ? Text("")
                        : UserTile(
                            product: searchlist[index - 1],
                          );
                  } else {
                    return Center(child: null);
                  }
                },
                itemCount: searchlist.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final Jobmodel product;

  UserTile({required this.product});

  get h4Style => null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log("go to deaild page ==");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => JobDetailPage(
        //               skills: '',
        //               salary: '',
        //               qualification: '',
        //               position: '',
        //               description: '',
        //               id: '',
        //               industry: '',
        //               location: '',
        //             )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Color.fromARGB(255, 232, 245, 255),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.industry,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 5),
                      // _furnitureScore(product),
                      const SizedBox(height: 5),
                      Text(
                        product.position,
                        style: const TextStyle(fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
