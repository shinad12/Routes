// // ignore_for_file: unused_element
// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:laboratary_project/homepage.dart';
// import 'package:laboratary_project/service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:hotelproj/screens/updateProfile.dart';

// class ProfilePage extends StatefulWidget {
//   // const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Future<Profile> fetchProfile(username) async {
//     final response = await http.post(Uri.parse('${Service.url}viewprofile.jsp'),
//         body: {"username": username});

//     if (response.statusCode == 200) {
//       log("statusCode:===" + response.statusCode.toString());

//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return Profile.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }
//   }

//   late Future<Profile> futureProfile;
//   late String username;

//   late SharedPreferences logindata;

//   @override
//   void initState() {
//     super.initState();
//     initial();
//   }

//   void initial() async {
//     logindata = await SharedPreferences.getInstance();
//     setState(() {
//       username = logindata.getString('username')!;
//       log('username:::::::$username');
//       futureProfile = fetchProfile(username);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Scaffold(
//           backgroundColor: Color.fromARGB(255, 4, 84, 7),
//           body: SafeArea(
//             child: FutureBuilder<Profile>(
//               future: futureProfile,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 350),
//                         child: SizedBox(
//                           height: 50,
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.arrow_back_ios,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute<void>(
//                                   builder: (BuildContext context) => MyHomePage(
//                                     title: "",
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 50,
//                         child: const Center(
//                           child: Text('PROFILE',
//                               style: TextStyle(
//                                 letterSpacing: 2,
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               )),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Container(
//                           height: 50,
//                           width: 500,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                               left: 20,
//                               top: 15,
//                             ),
//                             child: Text(
//                               snapshot.data!.name.toString(),
//                               // Profile.name,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Container(
//                           height: 50,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                               left: 20,
//                               top: 15,
//                             ),
//                             child: Text(
//                               snapshot.data!.email.toString(),
//                               // Profile.place,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Container(
//                           height: 50,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                               left: 20,
//                               top: 15,
//                             ),
//                             child: Text(
//                               snapshot.data!.profile.toString(),
//                               // Profile.phone,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Container(
//                           height: 50,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                               left: 20,
//                               top: 15,
//                             ),
//                             child: Text(
//                               snapshot.data!.address.toString(),
//                               // Profile.password,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Container(
//                           height: 50,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(30)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                               left: 20,
//                               top: 15,
//                             ),
//                             child: Text(
//                               username,
//                               // Profile.password,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }

//                 // By default, show a loading spinner.
//                 return CircularProgressIndicator();
//               },
//             ),
//           ))
//     ]);
//   }
// }

// class Profile {
//   Profile({
//     this.name,
//     this.email,
//     this.profile,
//     this.address,
//   });

//   String? name;
//   String? email;
//   String? profile;
//   String? address;

//   factory Profile.fromJson(Map<String, dynamic> json) {
//     return Profile(
//       name: json["name"],
//       email: json["email"],
//       profile: json["profile"],
//       address: json["address"],
//     );
//   }
// }



//  onPressed: () async {
//                         SharedPreferences preferences =
//                             await SharedPreferences.getInstance();
//                         preferences.setString("login", emailc.text.toString());
//                         log("email====" + emailc.text.toString());
//                         log("pass====" + passc.text.toString());
//                         login(emailc.text, passc.text, type);

//                         /// calling to servwer

//                         ///login(Email, password)
//                         // Navigator.push(context,
//                         //     MaterialPageRoute(builder: (context) => NavPage()))
//                       },