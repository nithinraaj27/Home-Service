import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/Bookings/current.dart';
import 'package:home_service/screens/Bookings/history.dart';

import '../../sizeconfig.dart';

class bookings extends StatefulWidget {
  const bookings({Key? key}) : super(key: key);

  @override
  _bookingsState createState() => _bookingsState();
}

class _bookingsState extends State<bookings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff23ADE8),
              title: Text(
                "My Bookings",
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
              ),
              bottom: TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: SizeConfig.height! * 2,
                  fontWeight: FontWeight.w500,

                ),
                tabs: [
                  Tab(text: "Scheduled",),
                  Tab(text: "History")
                ],
              )
            ),
            body: TabBarView(
              children: [
                current(),
                history(),
              ],
            )
          ),
        ));
  }
}
