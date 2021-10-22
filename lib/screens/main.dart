
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Bookings/bookings.dart';
import 'package:home_service/screens/Profile_Page/profile.dart';
import 'package:home_service/sizeconfig.dart';

import 'Home_Page/homepage.dart';

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
   bookings(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: NavbarAnim(
        1,
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
          child: new BottomNavigationBar(
              backgroundColor: Color(0xff23ADE8),
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
