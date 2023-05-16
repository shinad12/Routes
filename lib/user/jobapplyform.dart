import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:routesapplications/user/Home_Button.dart';
import 'package:routesapplications/user/JOBSEEKER_HOMEPAGE.dart';
import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';

class JobApplyForm extends StatelessWidget {
  String companyname, position, jobid;
  JobApplyForm(
      {required this.companyname, required this.position, required this.jobid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Job Application',
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
          SizedBox(
            height: 10,
          ),
          Text(
            position,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            companyname,
            // 'Complete Your Details !',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   height: 100,
          //   child: SvgPicture.asset('assets/images/section1.svg'),
          // ),
          SizedBox(
            height: 30,
          ),
          SignForm(
            jobid: jobid,
          ),
        ],
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  String jobid;
  SignForm({required this.jobid});
  @override
  _SignFormState createState() => _SignFormState();
}

// extension EmailValidator on String {
//   bool isValidEmail() {
//     return RegExp(
//             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//         .hasMatch(this);
//   }
// }
// String? validateEmail(String? value) {
//   Pattern pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regex = RegExp(pattern);
//   if (!regex.hasMatch(value!))
//     return 'Enter Valid Email';
//   else
//     return null;
// }

class _SignFormState extends State<SignForm> {
  UserSimplePreferences? sharedPreference;
  String? username = UserSimplePreferences.getUsername();

  String? validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController specialisationController = TextEditingController();
  // TextEditingController collegeController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController skillsController = TextEditingController();

  String? name,
      gender,
      email,
      phonenumber,
      location,
      qualification,
      specialisation,
      // college,
      experience,
      skills;
  // yearofpass;

  bool visibility = false;
  bool _passwordVisible = true;

  Future<Map<String, dynamic>> jobapplysuccessitem(
      // String companylogo,
      String jobid,
      name,
      gender,
      username,
      phonenumber,
      location,
      qualification,
      specialisation,
      // college,
      experience,
      skills
      // yearofpass
      ) async {
    print('>>>>>>>>>>>>>>>>>> webservice >>>>>>>>>>>>>>>>>>>>>');

    // print(companylogo);
    print(username);
    print(jobid);
    print(gender);
    print(name);
    print(phonenumber);
    print(location);
    print(qualification);
    print(specialisation);
    print(experience);
    print(skills);

    Map<String, dynamic> result;
    final Regdata = {
      // 'companylogo': companylogo,
      'job_id': jobid,
      'name': name,
      'gender': gender,
      'username': username,
      'location': location,
      'phonenumber': phonenumber,
      'qualiction': qualification,
      'specialisation': specialisation,
      // 'college': college,
      'experience': experience,
      'skills': skills,
      // 'yearofpass': yearofpass,
    };

    final response = await http.post(
      Uri.parse(commonUrl().url + "applyjob.jsp"),
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
          MaterialPageRoute(builder: (context) => NavPage()),
        );

        // final snackBar = SnackBar(
        //   content: Text(
        //     " success!!",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // );

        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: nameForm(),
          ),

          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              visibility ? Colors.red : Colors.black),
                      child: ListTile(
                        leading: Radio(
                          activeColor: Colors.black,
                          value: 'male',
                          groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value;
                              print(gender);
                            });
                          },
                        ),
                        title: Text(
                          'Male',
                          style: TextStyle(
                              color: visibility ? Colors.red : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              visibility ? Colors.red : Colors.black),
                      child: ListTile(
                        leading: Radio(
                          focusColor: Colors.black,
                          activeColor: Colors.black,
                          value: 'female',
                          groupValue: gender,
                          onChanged: (String? value) {
                            setState(() {
                              gender = value;
                              print(gender);
                            });
                          },
                        ),
                        title: Text('Female',
                            style: TextStyle(
                                color: visibility ? Colors.red : Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: phoneForm(),
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
            child: specialisationForm(),
          ),
          SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   child: collegeform(),
          // ),
          // SizedBox(
          //   height: 30,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: experienceform(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: skillsform(),
          ),
          // SizedBox(
          //   height: 30,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   child: yearofpassform(),
          // ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  print("=================================================");
                  if (_formKey.currentState!.validate()) {
                    print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
                    print(nameController.text);

                    print(phonenumberController.text);
                    print(experienceController.text);
                    print(skillsController.text);
                    print(gender);

                    jobapplysuccessitem(
                        widget.jobid,
                        name,
                        gender,
                        username,
                        phonenumber,
                        location,
                        qualification,
                        specialisation,
                        experience,
                        skills);

                    // SuccessfullMessage.then((response) {
                    //   if (response['status']) {
                    //     Navigator.of(context)
                    //         .push(MaterialPageRoute(builder: (ctx) {
                    //       return NavPage();
                    //     }));
                    //   } else {
                    //     print('Registration Failde');
                    //   }
                    // }
                    // );
                    // Navigator.of(context)
                    //     .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    //   return Home();
                    // }));
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF778899),
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

  TextFormField nameForm() {
    return TextFormField(
      controller: nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onChanged: (value) {
        name = value;
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
        labelText: "Name",
        hintText: 'Enter Your Name',
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

  TextFormField phoneForm() {
    return TextFormField(
      controller: phonenumberController,
      validator: (value) {
        if (value!.length != 10) {
          return 'Mobile Number must be of 10 digit';
        }
        return null;
      },
      onChanged: (value) {
        phonenumber = value;
      },
      keyboardType: TextInputType.phone,
      // validator: validateMobile,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: 'Enter Your Phone Number',
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
          Icons.call,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField locationForm() {
    return TextFormField(
      controller: locationController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onChanged: (value) {
        location = value;
      },
      decoration: InputDecoration(
        labelText: "Location",
        hintText: 'Location',
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
          return 'Please enter your Username';
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

  TextFormField specialisationForm() {
    return TextFormField(
      controller: specialisationController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'specialisation';
        }
        return null;
      },
      onChanged: (value) {
        specialisation = value;
      },
      decoration: InputDecoration(
        labelText: "specialisation",
        hintText: 'specialisation',
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

  // TextFormField collegeform() {
  //   return TextFormField(
  //     controller: collegeController,
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return 'College';
  //       }
  //       return null;
  //     },
  //     onChanged: (value) {
  //       college = value;
  //     },
  //     // obscureText: true,
  //     // obscureText: _passwordVisible,
  //     decoration: InputDecoration(
  //       labelText: "College",
  //       hintText: 'College',
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       contentPadding: EdgeInsets.symmetric(
  //         horizontal: 42,
  //         vertical: 20,
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide(
  //           color: Colors.teal[900]!.withOpacity(0.30),
  //         ),
  //         gapPadding: 10,
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide(
  //           color: Colors.teal[900]!.withOpacity(0.30),
  //         ),
  //         gapPadding: 10,
  //       ),
  //       suffixIcon: Icon(
  //         Icons.lock,
  //         color: Colors.grey,
  //       ),
  //     ),
  //   );
  // }

  TextFormField experienceform() {
    return TextFormField(
      controller: experienceController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Experience';
        }
        return null;
      },
      onChanged: (value) {
        experience = value;
      },
      // obscureText: true,
      // obscureText: _passwordVisible,
      decoration: InputDecoration(
        labelText: "Experience",
        hintText: 'Experience',
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
        hintText: 'Skills',
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
            color: Color(0xFF004D40).withOpacity(0.30),
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

  // TextFormField yearofpassform() {
  //   return TextFormField(
  //     controller: yearofpassController,
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return 'Year of Pass';
  //       }
  //       return null;
  //     },
  //     onChanged: (value) {
  //       yearofpass = value;
  //     },
  //     // obscureText: true,
  //     // obscureText: _passwordVisible,
  //     decoration: InputDecoration(
  //       labelText: "Year of Pass",
  //       hintText: 'Year of pass',
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       contentPadding: EdgeInsets.symmetric(
  //         horizontal: 42,
  //         vertical: 20,
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide(
  //           color: Colors.teal[900]!.withOpacity(0.30),
  //         ),
  //         gapPadding: 10,
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(28),
  //         borderSide: BorderSide(
  //           color: Colors.teal[900]!.withOpacity(0.30),
  //         ),
  //         gapPadding: 10,
  //       ),
  //       suffixIcon: Icon(
  //         Icons.lock,
  //         color: Colors.grey,
  //       ),
  //     ),
  //   );
  // }
}

class JobSuccessModel {
  final int? jobid;
  final String? position;
  final String? name;
  final String? gender;
  final String? email;
  final String? location;
  final String? phonenumber;
  final String? qualification;
  final String? specialisation;
  final String? college;
  final String? experience;
  final String? skills;
  // final String? yearofpass;

  JobSuccessModel(
      {this.position,
      this.jobid,
      this.name,
      this.gender,
      this.email,
      this.college,
      this.experience,
      this.phonenumber,
      this.location,
      this.qualification,
      this.skills,
      this.specialisation
      // this.yearofpass
      });

  factory JobSuccessModel.fromJson(Map<String, dynamic> Json) {
    return JobSuccessModel(
        jobid: Json['job_id'],
        position: Json['position'],
        name: Json['name'],
        gender: Json['gender'],
        email: Json['email'],
        phonenumber: Json['phonenumber'],
        location: Json['location'],
        qualification: Json['qualiction'],
        specialisation: Json['specialisation'],
        // college: Json['college'],
        experience: Json['experience'],
        skills: Json['skills']
        // yearofpass: Json['yearofpass']
        );
  }
}
// String name,
//     gender,
//     email,
//     phonenumber,
//     location,
//     qualification,
//     specialisation,
//     college,
//     experience,
//     skills,
//     yearofpass;