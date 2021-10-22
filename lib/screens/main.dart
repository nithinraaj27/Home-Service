import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/service/googlesignin.dart';
import 'package:home_service/sizeconfig.dart';

import 'homepage.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int _selectedPage = 0;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  List<Widget> _tabs = [
    HomePage(),
    Center(
      child: Text("Booking"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            googlesigninclass.logout();
          }),
      bottomNavigationBar: NavbarAnim(
        1,
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
          child: new BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedPage,
              unselectedItemColor: Colors.black,
              onTap: (val) {
                setState(() {
                  _selectedPage = val;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: SizeConfig.height! * 3.5,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                          fontSize: SizeConfig.height! * 2,
                          fontWeight: FontWeight.w400),
                    )),
                BottomNavigationBarItem(
                    icon: FaIcon(Icons.how_to_reg_rounded,
                        size: SizeConfig.height! * 3.5),
                    title: Text(
                      "Booking",
                      style: TextStyle(
                          fontSize: SizeConfig.height! * 2,
                          fontWeight: FontWeight.w400),
                    )),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: SizeConfig.height! * 3.5),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: SizeConfig.height! * 2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ]),
        ),
      ),
      body: _tabs[_selectedPage],
    ));
  }
}
