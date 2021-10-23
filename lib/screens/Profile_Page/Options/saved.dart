import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeconfig.dart';

class saved extends StatefulWidget {
  const saved({Key? key}) : super(key: key);

  @override
  _savedState createState() => _savedState();
}

class _savedState extends State<saved> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Saved Bookings",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("Saved Services"),
            ),
          ),
        ));
  }
}
