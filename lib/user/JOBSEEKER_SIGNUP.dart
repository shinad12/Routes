import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:routesapplications/user/JOBSEEKER_LOGIN.dart';
import 'package:intl/intl.dart';
import 'package:routesapplications/commonurl.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? gender;
  String _selectedDate = 'Tap to select date';
  TextEditingController dateController = TextEditingController();
  TextEditingController namec = TextEditingController();
  TextEditingController emailc = TextEditingController();
  TextEditingController phonec = TextEditingController();
  TextEditingController addressc = TextEditingController();

  TextEditingController passc = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  signup(name, DOB, Email, phonenumber, Address, password, gender) async {
    log("Name =" + name.toString());
    log("DOB =" + DOB.toString());
    log("Email =" + Email.toString());
    log("Phone =" + phonenumber.toString());
    log("Address =" + Address.toString());

    log("Password =" + password.toString());
    log("gender =" + gender.toString());

    Map data = {
      'Name': name,
      'DOB': DOB,
      'Email': Email,
      'Phone': phonenumber,
      'Address': Address,
      'Password': password,
      'gender': gender,
    };
    log(data.toString());
    final response = await http.post(
      Uri.parse(commonUrl().url + "registration.jsp"),
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
          MaterialPageRoute(builder: (context) => LoginPage()),
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
    log("iniusde reggggggggggggggg");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SizedBox(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an Account,Its free",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: namec,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          hintText: "Name"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          namec = value as TextEditingController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your DOB!';
                            }
                            return null;
                          },
                          onSaved: (value) =>
                              dateController = value as TextEditingController,
                          controller: dateController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter Date"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("yyyy-MM-dd").format(pickedDate);

                              setState(() {
                                dateController.text = formattedDate.toString();
                              });
                            } else {
                              print("Not selected");
                            }
                          },
                        ))),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailc,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          emailc = value as TextEditingController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: "Email"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phonec,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                          hintText: "Phone"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter valid phone number';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          phonec = value as TextEditingController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: addressc,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your address!';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          addressc = value as TextEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          hintText: "Address"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passc,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: "Password"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          hintText: "Confirm Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 130,
                          child: RadioListTile(
                            title: Text("Male"),
                            value: "male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 145,
                          child: RadioListTile(
                            title: Text("Female"),
                            value: "female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    new Container(
                      padding: const EdgeInsets.only(left: 0, top: 40.0),
                      child: new RaisedButton(
                        child: const Text('Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white)),
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              signup(
                                  namec.text,
                                  dateController.text,
                                  emailc.text,
                                  phonec.text,
                                  addressc.text,
                                  passc.text,
                                  gender)
                              // Navigator.pop(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoginPage()))

                              // server calling
                            }
                        },
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        MaterialButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () => {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()))
                                }),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
