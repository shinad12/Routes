import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:routesapplications/user/JOBSEEKER_HOMEPAGE.dart';

import 'package:routesapplications/commonurl.dart';
import 'package:routesapplications/sharedPreferences.dart';
import 'package:routesapplications/user/JOBSEEKER_SIGNUP.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:routesapplications/screen.dart';
import 'package:routesapplications/selection.dart';

class LoginPage extends StatelessWidget {
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
                  context, MaterialPageRoute(builder: (context) => choose()));
            }),
        elevation: 0,
        toolbarHeight: 80,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Sign In'),
        centerTitle: true,
        textTheme: TextTheme(
          headline6: TextStyle(
              color: Color(0XFF888888),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Welcome Back ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Sign in with your Username and password !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //     // color: Colors.amber,
            //     height: 280,
            //     width: 500,
            //     child: SvgPicture.asset('assets/images/login-image.svg')),
            SizedBox(
              height: 150,
            ),
            SignForm(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("Don't Have An Account?"),
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return SignupPage();
                            }));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String? email;
  String? password;

  bool? isLogged;

  @override
  void initState() {
    super.initState();

    UserSimplePreferences.init().then((value) {
      email = UserSimplePreferences.getUsername();
      //isLogged = UserSimplePreferences.getlogindata();
      check_if_already_login();
    });

    // birthday = UserSimplePreferences.getBirthday();
    // pets = UserSimplePreferences.getPets() ?? [];
  }

  void check_if_already_login() async {
    // logindata = await SharedPreferences.getInstance();
    // newuser = (logindata.getBool('login') ?? true);

    print("logged data >>>>>>>>>>>>>" + isLogged.toString());
    if (email != null) {
      if (email!.isNotEmpty) {
        log("GO TO HOME PAGE !!!!");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavPage()));
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    print('webservice');
    print(email);
    print(password);
    var result;
    final Map<String, dynamic> loginData = {
      'Email': email,
      'password': password,
    };

    // final url = "http://192.168.39.118:8080/communityApp/login.jsp";
    final response = await http.post(
      Uri.parse(commonUrl().url + "login.jsp"),
      body: loginData,
    );

    // http.Response response = await http.post(Uri.parse(url), body: loginData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.body);
      if (response.body.contains("success")) {
        await UserSimplePreferences.saveUser(email);
        await UserSimplePreferences.saveType("0");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavPage()),
        );
      }
      var userData = responseData;
      print(userData);

      loginModel ws = loginModel.fromJson(userData);

      result = {'status': true, 'message': 'Successful', 'user': ws};
      print("web res>>>>>>>>>" + result.toString());
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
          TextFormField(
            controller: userNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (value) {
              email = value;
            },
            decoration: InputDecoration(
              labelText: "email",
              hintText: 'Enter Your email',
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
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: 'Enter Your Password',
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
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  email = userNameController.text;
                  print(userNameController.text);
                  login(email.toString(), password.toString());
                  // final Future<Map<String, dynamic>> SuccessfullMessage =
                  //     SuccessfullMessage.then((response) async {
                  //   log("return database ====================================");
                  //   if (response['message'] == 'Successful') {
                  //     log("response ===" + response['message']);
                  //     // loginModel ls = response['user'];
                  //     // print(ls.username);

                  //     print('success');
                  //     // logindata.setBool('login', false);

                  //     // logindata.setString('username', username);

                  //     log("GO TO HOMEIN LOGIN SCREEN !!");
                  //     Navigator.of(context)
                  //         .pushReplacement(MaterialPageRoute(builder: (ctx) {
                  //       return NavPage1();
                  //     }));
                  //   } else {
                  //     print('Login Faild');
                  //   }
                  // });
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
                  'Sign In ',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class loginModel {
  final String? username;
  final String? password;
  final String? type;

  loginModel({this.username, this.password, this.type});

  factory loginModel.fromJson(Map<String, dynamic> Json) {
    return loginModel(
        username: Json['username'],
        password: Json['password'],
        type: Json['type']);
  }
}





// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         toolbarHeight: 80,
//         brightness: Brightness.light,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text('Sign In'),
//         centerTitle: true,
//         textTheme: TextTheme(
//           headline6: TextStyle(
//               color: Color(0XFF888888),
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 38),
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             Text(
//               'Welcome Back ',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Sign in with your Username and password !',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             // Container(
//             //     // color: Colors.amber,
//             //     height: 280,
//             //     width: 500,
//             //     child: SvgPicture.asset('assets/images/login-image.svg')),
//             SizedBox(
//               height: 150,
//             ),
//             SignForm(),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 45),
//               child: Container(
//                 child: Row(
//                   children: [
//                     Container(
//                       child: Text("Don't Have An Account?"),
//                     ),
//                     Container(
//                       child: TextButton(
//                           onPressed: () {
//                             Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (ctx) {
//                               return SignupPage();
//                             }));
//                           },
//                           child: Text(
//                             'Sign Up',
//                             style: TextStyle(color: Colors.blue),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SignForm extends StatefulWidget {
//   @override
//   _SignFormState createState() => _SignFormState();
// }

// class _SignFormState extends State<SignForm> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController userNameController = TextEditingController();

//   TextEditingController passwordController = TextEditingController();
//   String? username;
//   String? password;

//   bool? isLogged;
//   @override
//   void initState() {
//     super.initState();

//     UserSimplePreferences.init().then((value) {
//       username = UserSimplePreferences.getUsername();
//       isLogged = UserSimplePreferences.getlogindata();
//       check_if_already_login();
//     });

//     // birthday = UserSimplePreferences.getBirthday();
//     // pets = UserSimplePreferences.getPets() ?? [];
//   }

//   void check_if_already_login() async {
//     // logindata = await SharedPreferences.getInstance();
//     // newuser = (logindata.getBool('login') ?? true);

//     print("logged data >>>>>>>>>>>>>" + isLogged.toString());
//     if (isLogged == true) {
//       log("GO TO HOME PAGE !!!!");
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => NavPage()));
//     }
//   }

//   Future<Map<String, dynamic>> login(String username, String password) async {
//     print('webservice');
//     print(username);
//     print(password);
//     var result;
//     final Map<String, dynamic> loginData = {
//       'username': username,
//       'password': password,
//     };

//     // final url = "http://192.168.39.118:8080/communityApp/login.jsp";
//     final response = await http.post(
//       Uri.parse("${url}login.jsp"),
//       body: loginData,
//     );

//     // http.Response response = await http.post(Uri.parse(url), body: loginData);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       print(response.body);

//       var userData = responseData;
//       print(userData);

//       loginModel ws = loginModel.fromJson(userData);

//       result = {'status': true, 'message': 'Successful', 'user': ws};
//       print("web res>>>>>>>>>" + result.toString());
//     } else {
//       result = {
//         'status': false,
//         'message': json.decode(response.body)['error']
//       };
//     }
//     return result;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             controller: userNameController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your username';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               username = value;
//             },
//             decoration: InputDecoration(
//               labelText: "Username",
//               hintText: 'Enter Your Username',
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 42,
//                 vertical: 20,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(28),
//                 borderSide: BorderSide(
//                   color: Colors.teal[900]!.withOpacity(0.30),
//                 ),
//                 gapPadding: 10,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(28),
//                 borderSide: BorderSide(
//                   color: Colors.teal[900]!.withOpacity(0.30),
//                 ),
//                 gapPadding: 10,
//               ),
//               suffixIcon: Icon(
//                 Icons.person,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           TextFormField(
//             controller: passwordController,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter your password';
//               }
//               return null;
//             },
//             onChanged: (value) {
//               password = value;
//             },
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: "Password",
//               hintText: 'Enter Your Password',
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 42,
//                 vertical: 20,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(28),
//                 borderSide: BorderSide(
//                   color: Colors.teal[900]!.withOpacity(0.30),
//                 ),
//                 gapPadding: 10,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(28),
//                 borderSide: BorderSide(
//                   color: Colors.teal[900]!.withOpacity(0.30),
//                 ),
//                 gapPadding: 10,
//               ),
//               suffixIcon: Icon(
//                 Icons.lock,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   username = userNameController.text;
//                   print(userNameController.text);
//                   final Future<Map<String, dynamic>> SuccessfullMessage =
//                       login(username.toString(), password.toString());

//                   SuccessfullMessage.then((response) async {
//                     log("return database ====================================");
//                     if (response['message'] == 'Successful') {
//                       log("response ===" + response['message']);
//                       // loginModel ls = response['user'];
//                       // print(ls.username);

//                       print('success');
//                       // logindata.setBool('login', false);

//                       // logindata.setString('username', username);
//                       await UserSimplePreferences.saveUser(username!);
//                       log("GO TO HOMEIN LOGIN SCREEN !!");
//                       Navigator.of(context)
//                           .pushReplacement(MaterialPageRoute(builder: (ctx) {
//                         return LoginPage();
//                       }));
//                     } else {
//                       print('Login Faild');
//                     }
//                   });
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.teal[900]!.withOpacity(0.60),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50)),
//                   textStyle: const TextStyle(
//                       fontSize: 15, fontWeight: FontWeight.w400),
//                   elevation: 0),
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Text(
//                   'Sign In ',
//                   style: TextStyle(fontSize: 17),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }