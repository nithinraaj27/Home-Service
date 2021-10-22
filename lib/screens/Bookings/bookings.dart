import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "My Bookings",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("My Bookings"),
            ),
          ),
        ));
  }
}
