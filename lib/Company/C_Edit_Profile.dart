import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:routesapplications/Company/COMPANY_HOMEPAGE.dart';

class profile1 extends StatefulWidget {
  @override
  State<profile1> createState() => _profile1();
}

class _profile1 extends State<profile1> {
  bool _value = false;
  int val = 1;
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();
  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PickedFile? _image;

    _imageFromGallery() async {
      PickedFile? image = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        _image = image;
      });
    }

    _imageFromCamera() async {
      PickedFile? image = await ImagePicker()
          .getImage(source: ImageSource.camera, imageQuality: 50);
      setState(() {
        _image = image;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Edit profile')),
          actions: [
            Padding(
              padding: EdgeInsets.all(15),
              child: GestureDetector(
                child: Icon(Icons.home),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavPage1()));
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: FileImage(File("_imageFile!.path"))),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return SizedBox(
                            height: 112, //pinneyum matendi verum
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ),
                                  title: Text('Camera'),
                                  onTap: () {
                                    takePhoto(ImageSource.camera);
                                    //this is a code get image from Camera
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.image,
                                    color: Colors.blue,
                                  ),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    takePhoto(ImageSource.gallery);
                                    //this is a code get image from Gallery
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Company Name',
                              hintText: "Company Name"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Company Name ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: "Email"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your number!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                              hintText: "Pnone"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Location';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Location",
                              hintText: "Location"),
                        ),
                        SizedBox(
                          height: 20,
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
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavPage1()))
                                }
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  void takePhoto(ImageSource source) async {
    var _picker;
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      var _imageFile = pickedFile!;
      print("<<<<<<<<<<<<<<<<<<< IMAGE >>>>>>>>>>>>>>>>>>>>>>>" +
          _imageFile!.path);
    });
  }
}
