import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:routesapplications/Company/COMPANY_LOGIN.dart';
import 'package:http/http.dart' as http;

import '../commonurl.dart';

// class SignupPage2 extends StatefulWidget {
//   @override
//   State<SignupPage2> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage2> {
//   TextEditingController pname = TextEditingController();
//   TextEditingController cname = TextEditingController();
//   TextEditingController emailc = TextEditingController();
//   TextEditingController phonec = TextEditingController();
//   TextEditingController textarea = TextEditingController();

//   TextEditingController passc = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               size: 20,
//               color: Colors.black,
//             )),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SafeArea(
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 Text(
//                   "Sign up",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Create an Account,Its free",
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 TextFormField(
//                   controller: pname,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Conerned Person Name',
//                       hintText: "Name"),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Consernd Name ';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: cname,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Company Name',
//                       hintText: "Name"),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Company Name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: emailc,
// validator: (value) {
//   if (value!.isEmpty ||
//       !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//           .hasMatch(value)) {
//     return 'Enter a valid email!';
//   }
//   return null;
// },
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Email',
//                       hintText: "Email"),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: phonec,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Phone',
//                       hintText: "Phone"),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter valid phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Enter Description!';
//                       }
//                       return null;
//                     },
//                     controller: textarea,
//                     keyboardType: TextInputType.multiline,
//                     maxLines: 4,
//                     decoration: InputDecoration(
//                         hintText: "Enter Description",
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 1, color: Colors.redAccent)))),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: passc,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Password',
//                       hintText: "Password"),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Confirm Password',
//                       hintText: "Confirm Password"),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 new Container(
//                   padding: const EdgeInsets.only(left: 0, top: 40.0),
//                   child: new RaisedButton(
//                     child: const Text('Submit',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Colors.white)),
//                     onPressed: () => {
//                       if (_formKey.currentState!.validate())
//                         {
//                           signup(
//                             pname.text,
//                             cname.text,
//                             emailc.text,
//                             phonec.text,
//                             textarea.text,
//                             passc.text,
//                           )
//                           // Navigator.pop(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => LoginPage1()))
//                         },
//                     },
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(40)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account? "),
//                     MaterialButton(
//                         child: Text('Login'),
//                         onPressed: () => {
//                               Navigator.pop(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => LoginPage1()))
//                             }),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 300,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignupPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //toolbarHeight: 100,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Sign Up'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (ctx) {
                return LoginPage1();
              }));
            }),
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
            'Company Register Account ',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            'Complete Your Details !',
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
          SignForm(),
        ],
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

  TextEditingController industryController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String industry, location, username, password, phonenumber;

  bool visibility = false;

  // bool _passwordVisible = true;
  bool _obscureText = true;
  bool _passwordVisible = true;

  signup(industry, location, phonenumber, username, password) async {
    log("c_name =" + industry.toString());
    log("Email =" + username.toString());
    log("phone =" + phonenumber.toString());
    log("location =" + location.toString());

    log("password =" + password.toString());

    Map data = {
      'industry': industry,
      'email': username,
      'phone': phonenumber,
      'location': location,
      'password': password,
    };
    log(data.toString());
    final response = await http.post(
      Uri.parse(commonUrl().url + "c_signup.jsp"),
      body: data,
    );
    if (response.statusCode == 200) {
      // setState(() {
      //   isLoading = false;
      // });
      log("resss===" + response.body);

      if (response.body.contains("success")) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage1()),
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
      print("Please Try again");
      final snackBar = SnackBar(
        content: Text(
          "Check Internet connection and Try again!! ",
          style: TextStyle(color: Colors.white),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
            child: collegeForm(),
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
            child: usernameForm(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: passwordform(),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print(industryController.text);
                    print(locationController.text);

                    print(phonenumberController.text);
                    print(userNameController.text);
                    print(passwordController.text);
                    signup(industry, location, phonenumber, username, password);
                    // final Future<Map<String, dynamic>> SuccessfullMessage =
                    // vm.companyReg(industry, empno, location, phonenumber,
                    //     username, password);
                    // SuccessfullMessage.then((response) {
                    //   // if (response['status']) {
                    //   Navigator.of(context)
                    //       .pushReplacement(MaterialPageRoute(builder: (ctx) {
                    //     return LoginPage1();
                    //   }));
                    //   // } else {
                    //   //   print('Registration Failde');
                    //   // }
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
                    'Sign Up',
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
      controller: industryController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Industry';
        }
        return null;
      },
      onChanged: (value) {
        industry = value;
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
        labelText: "Industry",
        hintText: 'Industry',
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
          Icons.ac_unit,
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField collegeForm() {
    return TextFormField(
      controller: locationController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Location';
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
        hintText: ' Phone Number',
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

  TextFormField usernameForm() {
    return TextFormField(
      controller: userNameController,
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return 'Enter a valid email!';
        }
        return null;
      },
      onChanged: (value) {
        username = value;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: ' Email',
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

  TextFormField passwordform() {
    // String validatePassword(String value) {
    //   RegExp regex = RegExp(
    //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    //   if (value.isEmpty) {
    //     return 'Please enter password';
    //   } else {
    //     if (!regex.hasMatch(value)) {
    //       return 'Enter valid password';
    //     } else {
    //       return null;
    //     }
    //   }
    // }
    RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    //A function that validate user entered password
    bool validatePassword(String pass) {
      password = pass.trim();
      if (pass_valid.hasMatch(password)) {
        return true;
      } else {
        return false;
      }
    }

    return TextFormField(
      controller: passwordController,
      // validator: validatePassword,
      // validator: (value) {
      //   if (value.isEmpty) {
      //     return 'Please enter your password';
      //   }
      //   return null;
      // },
      // onChanged: (value) {
      //   password = value;
      // },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter password";
        } else {
          //call function to check password
          bool result = validatePassword(value);
          if (result) {
            // create account event
            return null;
          } else {
            return " Password should contain Capital, small letter & Number & Special";
          }
        }
      },
      keyboardType: TextInputType.text,
      // obscureText: true,
      obscureText: _obscureText,
      // obscureText: _passwordVisible,
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
        // suffixIcon: Icon(
        //   Icons.lock,
        //   color: Colors.grey,
        // ),

        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            semanticLabel: _obscureText ? 'show password' : 'hide password',
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
