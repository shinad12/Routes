import 'package:flutter/material.dart';
import 'package:routesapplications/Company/COMPANY_LOGIN.dart';
import 'package:routesapplications/user/JOBSEEKER_LOGIN.dart';

class choose extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<choose> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hello There!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Automatic identity verification which enable you to verify your identity",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ),
              ],
            ),
            Container(
              height: 300,
              width: 600,
              child: Image.asset('assets/logo/routes.png'),
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()))
              },
              color: Color.fromARGB(255, 140, 201, 231),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 140, 201, 231),
                  ),
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                " JOBSEEKERS",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage1()));
              },
              color: Colors.blueGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                "COMPANY",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
