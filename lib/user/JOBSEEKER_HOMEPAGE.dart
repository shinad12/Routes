import 'package:flutter/material.dart';
import 'package:routesapplications/user/Search_Button.dart';
import 'package:routesapplications/user/AppliedJob_Button.dart';
import 'package:routesapplications/user/Edit_profile.dart';
import 'package:routesapplications/user/Home_Button.dart';

import 'package:routesapplications/user/JOBSEEKER_LOGIN.dart';

import 'package:routesapplications/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NavPage> {
  int _currentIndex = 0;
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    _pages.add(homeScreen());
    _pages.add(searchpage());
    _pages.add(Appliedjob());
    super.initState();
  }

  void logout() async {
    SharedPreferences? _preferences;

    _preferences = await SharedPreferences.getInstance();

    await _preferences.setString('Email', '');
    //await _preferences!.setBool(_islogin, false);
    _preferences.remove('Email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal[900]!.withOpacity(0.50),
          title: Text('Routes')),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal[900]!.withOpacity(0.50),
                ),
                child: Column(
                  children: [
                    // new CircleAvatar(
                    //   radius: 60.0,
                    //   backgroundColor: const Color(0xFF778899),
                    //   child: new Image.asset(
                    //     'assets/logo/dropbox.png',
                    //   ), //For Image Asset
                    // ),
                  ],
                )

                //Text('Name'),
                ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavPage()),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()));
                }),
            ListTile(
              leading: Icon(Icons.work),
              title: const Text('Jobs'),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => jobs()));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: const Text('About US'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('logout'),
              onTap: () {
                logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.teal[900]!.withOpacity(0.50),
                selectedItemColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work), label: 'Applied jobs')
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: _currentIndex == 1
              ? Colors.teal.withOpacity(0.50)
              : Colors.blueGrey,
          child: Icon(Icons.search),
          onPressed: () => setState(() {
            _currentIndex = 1;
          }),
        ),
      ),
    );
  }
}


// To parse this JSON data, do
//
//     final jobmodel = jobmodelFromJson(jsonString);
