import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:routesapplications/commonurl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routesapplications/user/JOBSEEKER_LOGIN.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  // String username;
  // UpdateProfile({@required this.username});
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String? val;
  final ImagePicker _picker = ImagePicker();
  late String email, password, phonenumber, name;
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailcontroller = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController phonenumberController = TextEditingController();
  String uploadStatus = "";
  List<Profile> profilelist = [];
  String myusername = "";
  profile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    myusername = pref.getString('Email')!;
    var user_name = pref.getString('Email');
    log("Email" + user_name.toString());
  }

  late Future<Profile> getprofiledata;
  Future<Profile> getprofiledetails(String username) async {
    log("onside");
    final response =
        await http.get(Uri.parse(commonUrl().url + "updateprofile.jsp"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    profile();
    getprofiledata = getprofiledetails(myusername);
    //  initial();
  }

  // void initial() async {
  //   logindata = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = logindata.getString('username');
  //     print('username :::::::::>>>>:::::::' + username);
  //   });
  // }

  //  var imageFile;
  File? image;
  PickedFile? _imageFile;

  void _openGallery(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedImage!.path);
      preferences.setString("image", pickedImage.path);

      log(image.toString());
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final XFile? pickedImageCamera =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      image = File(pickedImageCamera!.name);
      log(image.toString());
    });
    Navigator.of(context).pop();
  }

  var savedimage;

  Future<Map<String, dynamic>> updateProfile(
      {required String name,
      required String email,
      required String phone,
      required PickedFile imagefile,
      required String address}) async {
    // print(clasid);
    // print(selected);

    var request = http.MultipartRequest(
        "POST", Uri.parse(commonUrl().url + "updateprofile"));
    var pic = await http.MultipartFile.fromPath("images", imagefile.path);
    // request.files.add(pic);
    request.fields['Name'] = name;
    request.fields['Email'] = email;
    request.fields['Phone'] = phone;
    request.fields['Address'] = address;
    // request.fields['phonenumber'] = phonenumber;
    // request.fields['examtitle'] = examtitle;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("aks" + responseString.toString());
    Map<String, dynamic> result;
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (responseString.contains("success")) {
        setState(() {
          String uploadStatus = "File Uploaded Succesfully";
        });
      }
      // else {
      //   setState(() {
      //     uploadStatus = "Failed...........";
      //   });
      // }
    }
    throw Exception("ERROR");
  }

  var address, phone;
  Widget build(BuildContext context) {
    log("username =777==" + myusername.toString());
    var container = Container(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        color: Color.fromARGB(255, 128, 103, 238),
        height: 40,
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: ElevatedButton(
          child: const Text('submit'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ));
    var listTile = ListTile(
        title: Text("both"),
        leading: Radio(
          value: 1,
          groupValue: val,
          onChanged: (value) {
            setState(() {
              val = value.toString();
            });
          },
          activeColor: Color.fromARGB(153, 6, 181, 158),
        ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(153, 6, 181, 158),
        title: Text('Profile'),
      ),
      body: FutureBuilder<Profile>(
        future: getprofiledata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            log("name ===" + snapshot.data!.name);

            name = snapshot.data!.name;
            address = snapshot.data!.address;
            email = snapshot.data!.email;
            phone = snapshot.data!.phone;

            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 65,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: _imageFile == null
                                ? CircleAvatar(
                                    radius: 65,
                                    backgroundImage: NetworkImage(
                                        'https://img.myloview.com/posters/unknown-male-avatar-profile-image-businessman-vector-700-199769934.jpg')

                                    //  dp == nullg
                                    //     ? AssetImage('assets/profile.png')
                                    //     : _imageFile == null
                                    //         ? NetworkImage(commonurl().commourl +
                                    //             "/images/" +
                                    //             dp!)
                                    //         : FileImage(File(_imageFile!.path))
                                    //             as ImageProvider),
                                    )
                                : CircleAvatar(
                                    radius: 65,
                                    backgroundImage:
                                        FileImage(File(_imageFile!.path)),
                                  )),
                      ),
                      onTap: () {
                        log("edit bottomsheeet--------");

                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            backgroundColor: Color.fromARGB(255, 251, 254, 254),
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
                                        color: Color.fromARGB(255, 0, 13, 13),
                                      ),
                                      title: Text('Camera'),
                                      onTap: () {
                                        takePhoto(ImageSource.camera);
                                        // _openCamera(context);
                                        //  takepic(ImageSource.camera);
                                        //this is a code get image from Camera
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.image,
                                        color: Color.fromARGB(255, 0, 13, 13),
                                      ),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        takePhoto(ImageSource.gallery);
                                        // _openGallery(context);
                                        // this is a code get image from Gallery
                                      },
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    Text(
                      myusername.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: name,
                      // controller: name,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(153, 6, 181, 158),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                            ),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //   color: Color.fromARGB(153, 6, 181, 158),
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Name',
                          hintText: "Name"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: email,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(153, 6, 181, 158),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                            ),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //   color: Color.fromARGB(153, 6, 181, 158),
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Email',
                          hintText: "Email"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: phone,
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(153, 6, 181, 158),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                            ),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //   color: Color.fromARGB(153, 6, 181, 158),
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Phone',
                          hintText: "Phone"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: address,
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(153, 6, 181, 158),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                            ),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //   color: Color.fromARGB(153, 6, 181, 158),
                            // ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Color.fromARGB(153, 6, 181, 158),
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Address',
                          hintText: "Address"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        //  crossAxisAlignment: CrossAxisAlignment.center,
                        color: Colors.white,
                        height: 40,
                        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              side: BorderSide(
                                color: Color.fromARGB(153, 6, 181, 158),
                              ),
                            ),
                            primary: Color.fromARGB(153, 6, 181, 158),
                          ),
                          child: const Text('Submit'),
                          onPressed: () async {
                            updateProfile(
                                name: name,
                                email: email,
                                phone: phone,
                                imagefile: _imageFile!,
                                address: address);
                          },
                        ))
                  ],
                ),
              ),
            ]);
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget show_bottomSheet() {
    return Container(
      height: 100.0,
      color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      print("<<<<<<<<<<<<<<<<<<< IMAGE >>>>>>>>>>>>>>>>>>>>>>>" +
          _imageFile!.path);
    });
  }
}

class Profile {
  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.Password,
  });

  String name;
  String email;
  String phone;
  String address;
  String Password;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["Name"],
        email: json["Email"],
        phone: json["Phone"],
        address: json["Address"],
        Password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Email": email,
        "Phone": phone,
        "Address": address,
        "Password": Password,
      };
}
