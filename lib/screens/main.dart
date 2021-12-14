
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
          bottomNavigationBar: CupertinoTabScaffold(
              resizeToAvoidBottomInset: false,
              tabBar: CupertinoTabBar(
                backgroundColor: Color(0xff23ADE8),
                activeColor: Colors.white,
                inactiveColor: Colors.black54,
                items:  <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Icon(
                          Icons.home,
                          size: SizeConfig.height! * 3.5,
                        ),
                      ),
                      title: Text("Home",style: GoogleFonts.poppins(fontSize: SizeConfig.height! * 1.5,fontWeight: FontWeight.w500),),
                      ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: FaIcon(
                        Icons.how_to_reg_rounded,
                        size: SizeConfig.height! * 3.5,
                      ),
                    ),
                    title: Text("Bookings",style: GoogleFonts.poppins(fontSize: SizeConfig.height! * 1.5,fontWeight: FontWeight.w500),),
                  ),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Icon(
                          Icons.person,
                          size: SizeConfig.height! * 3.5,
                        ),
                      ),
                    title: Text("Profile",style: GoogleFonts.poppins(fontSize: SizeConfig.height! * 1.5,fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
              tabBuilder: (context,index){
                switch(index)
                {
                  case 0:
                    return CupertinoTabView(
                      builder: (context){
                        return CupertinoPageScaffold(
                          child: HomePage(),
                        );
                      },
                    );

                  case 1:
                    return CupertinoTabView(
                      builder: (context){
                        return CupertinoPageScaffold(
                          child: bookings(),
                        );
                      },
                    );

                  case 2:
                    return CupertinoTabView(
                      builder: (context){
                        return CupertinoPageScaffold(
                          child: profile(),
                        );
                      },
                    );

                  default: return CupertinoTabView(builder: (context){
                    return CupertinoPageScaffold(
                      child: HomePage(),
                    );
                  },);
                }
              }
          ),
    ));
  }
}
