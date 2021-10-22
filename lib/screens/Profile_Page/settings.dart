import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/Profile_Page/edit_profile.dart';

import '../../sizeconfig.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {

  bool _notification = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff23ADE8),
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
        ),
      ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.height!*3),
              height: SizeConfig.height!*18,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.width!*2),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.notifications_none,
                                          color: Colors.black54,
                                          size: SizeConfig.height! * 3,
                                        ),
                                        title: Text(
                                          "Notifications",
                                          style: GoogleFonts.poppins(
                                            fontSize: SizeConfig.height! * 2,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container(
                                    margin: EdgeInsets.only(right: SizeConfig.width!*2),
                                    child: Switch(onChanged: (bool value) {
                                      setState(() {
                                        _notification = value;
                                      });
                                    }, value: _notification,

                                      
                                    ),))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                height: SizeConfig.height! * 1,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )),
                  Lists("Edit Profile",
                      Icons.edit,edit_profile()),
                ],
              ),
            ),
          ),
    ));
  }
  Expanded Lists(String txt, IconData icon,Widget widget ) {
    return Expanded(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.width!*2),
                    child: ListTile(
                      leading: Icon(
                        icon,
                        color: Colors.black54,
                        size: SizeConfig.height! * 3,
                      ),
                      title: Text(
                        txt,
                        style: GoogleFonts.poppins(
                          fontSize: SizeConfig.height! * 2,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  height: SizeConfig.height! * 1,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ));
  }
}
