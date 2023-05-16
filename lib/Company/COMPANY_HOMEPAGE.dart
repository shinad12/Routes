import 'package:flutter/material.dart';
import 'package:routesapplications/Company/C_Edit_Profile.dart';
import 'package:routesapplications/Company/C_HOMEBUTTON.dart';
import 'package:routesapplications/Company/View_Button.dart';

import 'package:routesapplications/Company/AddJob_Button.dart';

import 'package:routesapplications/Company/COMPANY_LOGIN.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavPage1 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NavPage1> {
  int _currentIndex = 0;
  List<Widget> _pages = <Widget>[];
  @override
  void initState() {
    _pages.add(ChomeScreen());
    _pages.add(JobPostForm(
      industry: '',
      id: '',
      position: '',
    ));
    _pages.add(ViewJobAppliedSection());
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
      appBar: AppBar(backgroundColor: Colors.blueGrey, title: Text('Routes')),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Column(
                    // children: [
                    //   new CircleAvatar(
                    //     radius: 60.0,
                    //     backgroundColor: const Color(0xFF778899),
                    //     child: new Image.asset(
                    //       'assets/logo/dropbox.png',
                    //     ), //For Image Asset
                    //   ),
                    // ],
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
                  MaterialPageRoute(builder: (context) => NavPage1()),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile1()));
                }),
            ListTile(
              leading: Icon(Icons.work),
              title: const Text('Jobs'),
              onTap: () {},
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
                // newuser = (logindata.getBool('login') ?? true);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage1()));
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
                backgroundColor: Colors.blueGrey,
                selectedItemColor: Colors.white,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work), label: 'View Applicants')
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
              ? Colors.teal[900]!.withOpacity(0.50)
              : Colors.blueGrey,
          child: Icon(Icons.add),
          onPressed: () => setState(() {
            _currentIndex = 1;
          }),
        ),
      ),
    );
  }
}
