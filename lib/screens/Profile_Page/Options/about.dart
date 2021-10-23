import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeconfig.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "About Company",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("About Company"),
            ),
          ),
        ));
  }
}
