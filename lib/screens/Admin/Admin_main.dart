import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Bookings/bookings.dart';
import 'package:home_service/screens/Home_Page/homepage.dart';
import 'package:home_service/screens/Profile_Page/profile.dart';

import '../../main.dart';
import '../../sizeconfig.dart';
import 'Home.dart';

class adminMain extends StatefulWidget {
  const adminMain({Key? key}) : super(key: key);

  @override
  _adminMainState createState() => _adminMainState();
}

class _adminMainState extends State<adminMain> {
  int _selectedPage = 0;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  List<Widget> _tabs = [
    adminhome(),
    Center(child: Text("Home"),),
    Center(child: Text("Home"),),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: new FloatingActionButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
            child: Icon(Icons.logout),
          ),
          bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55),
                topRight: Radius.circular(55),
              ),
              child: new BottomNavigationBar(
                  backgroundColor: Color(0xff23ADE8),
                  selectedItemColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedPage,
                  unselectedItemColor: Colors.white.withOpacity(0.6),
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
          body: _tabs[_selectedPage],
        ));
  }
}

