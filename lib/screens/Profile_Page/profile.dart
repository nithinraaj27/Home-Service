import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Profile_Page/Options/about.dart';
import 'package:home_service/screens/Profile_Page/Options/rate.dart';
import 'package:home_service/screens/Profile_Page/Options/saved.dart';
import 'package:home_service/screens/Profile_Page/Options/scheduled_booking.dart';
import 'package:home_service/screens/Profile_Page/Options/settings.dart';
import 'package:home_service/screens/Profile_Page/Options/share.dart';
import 'package:home_service/service/user_details.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:provider/provider.dart';

import 'Edit Profile/edit_profile.dart';
import 'Options/service_provider.dart';

class profile extends StatefulWidget {
  final String? Name;
  final String? MobileNumber;
  final String? Uid;
  const profile({Key? key, this.Name, this.MobileNumber, this.Uid})
      : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<user_details>(context, listen: false).set_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff23ADE8),
              title: Text(
                "My Profile",
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig.height! * 2.5,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              child: FadeAnimation(
                1,
                Container(
                  height: SizeConfig.height! * 90,
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.height! * 2.5),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: SizeConfig.width! * 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Icon(
                                            Icons.verified_user_outlined,
                                            size: SizeConfig.height! * 3,
                                          )),
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                                context
                                                                .watch<
                                                                    user_details>()
                                                                .Name ==
                                                            "" ||
                                                        context
                                                            .watch<
                                                                user_details>()
                                                            .Name
                                                            .isEmpty
                                                    ? "VERIFIED CUSTOMER"
                                                    : context
                                                        .watch<user_details>()
                                                        .Name,
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      SizeConfig.height! * 2,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            edit_profile()));
                                              },
                                              child: FaIcon(
                                                Icons.edit,
                                                color:
                                                    Colors.lightBlue.shade900,
                                                size: SizeConfig.height! * 3,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeConfig.width! * 15.5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    context
                                                        .watch<user_details>()
                                                        .Mobile == "" || context
                                                        .watch<user_details>()
                                                        .Mobile.isEmpty ? "Mobile number" : context
                                                        .watch<user_details>()
                                                        .Mobile ,
                                                    style: GoogleFonts.poppins(
                                                      fontSize:
                                                          SizeConfig.height! *
                                                              2,
                                                      color: Colors.grey,
                                                    ))),
                                          ],
                                        ))),
                                Expanded(
                                  child: SizedBox(),
                                )
                              ],
                            ),
                          )),
                      Lists("Register as Service Provider",
                          Icons.handyman_outlined, service_provider()),
                      Lists("About Company", Icons.info_outline, about()),
                      Lists("Share Company", Icons.share_outlined, share()),
                      Lists("Scheduled Booking",
                          Icons.home_repair_service_outlined, schedules()),
                      Lists("Saved Services", Icons.bookmark_outline_outlined,
                          saved()),
                      Lists("Rate Company", Icons.star, rate()),
                      Lists("Settings", Icons.settings, settings()),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: Text(
                            "Logout",
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Color(0xffE21818),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            )));
  }

  Expanded Lists(String txt, IconData icon, Widget widget) {
    return Expanded(
        child: Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => widget));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 2),
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
