import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeconfig.dart';

class rate extends StatefulWidget {
  const rate({Key? key}) : super(key: key);

  @override
  _rateState createState() => _rateState();
}

class _rateState extends State<rate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Ratings",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Text("Rate Company"),
        ),
      ),
    ));
  }
}
