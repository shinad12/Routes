import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:routesapplications/Company/COMPANY_HOMEPAGE.dart';
import 'package:routesapplications/user/Home_Button.dart';
import 'package:routesapplications/Company/View_Button.dart';
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';

class JobPostForm extends StatelessWidget {
  String industry, position, id;
  JobPostForm(
      {Key? key,
      required this.industry,
      required this.position,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // toolbarHeight: 80,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Job Application Form',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          textTheme: TextTheme(
            headline6: TextStyle(
                color: Color(0XFF888888),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SignForm());
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late UserSimplePreferences sharedPreference;
  String? username = UserSimplePreferences.getUsername();

  // final _formKey = GlobalKey<FormState>();

  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController responsibilityController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  late String position,
      salary,
      qualification,
      specialisation,
      responsibility,
      skills;

  Future<Map<String, dynamic>> jobapplysuccessitem(
      // String companylogo,

      position,
      salary,
      qualification,
      responsibilty,
      username,
      skills) async {
    print('>>>>>>>>>>>>>>>>>> webservice >>>>>>>>>>>>>>>>>>>>>');

    // print(companylogo);
    print(username);

    var result;
    final Map<String, dynamic> Regdata = {
      // 'companylogo': companylogo,

      'position': position,
      'username': username,
      'salary': salary,
      'qualification': qualification,
      'responsibility': responsibilty,
      'skills': skills,
    };

    final response = await http.post(
      Uri.parse(commonUrl().url + "PostJob.jsp"),
      body: Regdata,
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.body);
      var webData = responseData;
      print(webData);
      JobSuccessModel ws = JobSuccessModel.fromJson(webData);

      result = {'status': true, 'message': 'Succcessful', 'WebService': ws};
      print('Web res>>>>>>>>>>>>>>>>>>>>>>>>>' + result.toString());

      if (response.body.contains("success")) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavPage1()),
        );

        final snackBar = SnackBar(
          content: Text(
            " success!!",
            style: TextStyle(color: Colors.white),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: PositionForm(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: locationForm(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: qualificationForm(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: responsibilityForm(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: skillsform(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("=================================================");
                    print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
                    print(positionController.text);
                    print(salaryController.text);
                    print(qualificationController.text);
                    print(responsibilityController.text);

                    print(skillsController.text);

                    jobapplysuccessitem(position, salary, qualification,
                        responsibility, username, skills);

                    // SuccessfullMessage.then((response) {
                    //   if (response['status']) {
                    //     Navigator.of(context)
                    //         .push(MaterialPageRoute(builder: (ctx) {
                    //       return Success();
                    //     }));
                    //   } else {
                    //     print('Registration Failde');
                    //   }
                    // });
                    // Navigator.of(context)
                    //     .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    //   return Home();
                    // }));
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal[900]!.withOpacity(0.60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    elevation: 0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  TextFormField PositionForm() {
    return TextFormField(
      controller: positionController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onChanged: (value) {
        position = value;
      },
      // validator: (value) {
      //   if (!value.isValidEmail()) {
      //     return 'Check your email';
      //   }
      //   return null;
      // },
      // onChanged: (value) {
      //   name = value;
      // },
      // validator: (input) => input.isValidEmail() ? null : "Check your email",
      decoration: InputDecoration(
        labelText: "Position",
        hintText: 'Enter Your Position',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField locationForm() {
    return TextFormField(
      controller: salaryController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter salary package';
        }
        return null;
      },
      onChanged: (value) {
        salary = value;
      },
      decoration: InputDecoration(
        labelText: "Salary ",
        hintText: 'Salary',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          Icons.location_city,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField qualificationForm() {
    return TextFormField(
      controller: qualificationController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Qualification';
        }
        return null;
      },
      onChanged: (value) {
        qualification = value;
      },
      decoration: InputDecoration(
        labelText: "Qualification",
        hintText: 'Qualification',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField responsibilityForm() {
    return TextFormField(
      controller: responsibilityController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'responsibility';
        }
        return null;
      },
      onChanged: (value) {
        responsibility = value;
      },
      decoration: InputDecoration(
        labelText: "responsibility",
        hintText: 'responsibility',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          Icons.location_city,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField skillsform() {
    return TextFormField(
      controller: skillsController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Skills';
        }
        return null;
      },
      onChanged: (value) {
        skills = value;
      },
      // obscureText: true,
      // obscureText: _passwordVisible,
      decoration: InputDecoration(
        labelText: "Skills",
        hintText: 'Seperated by Comma (,)',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(
            color: Colors.teal[900]!.withOpacity(0.30),
          ),
          gapPadding: 10,
        ),
        suffixIcon: Icon(
          Icons.lock,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class JobSuccessModel {
  final int? id;
  final String? position;
  final String? location;
  final String? qualification;
  final String? responsibility;
  final String? username;
  final String? skills;
  // final String? yearofpass;

  JobSuccessModel(
      {this.position,
      this.id,
      this.location,
      this.qualification,
      this.skills,
      this.responsibility,
      this.username});

  factory JobSuccessModel.fromJson(Map<String, dynamic> Json) {
    return JobSuccessModel(
        id: Json['id'],
        position: Json['position'],
        location: Json['location'],
        qualification: Json['qualification'],
        responsibility: Json['responsibility'],
        username: Json['username'],
        skills: Json['skills']
        // yearofpass: Json['yearofpass']
        );
  }
}
