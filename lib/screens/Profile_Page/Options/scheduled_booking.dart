import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/Bookings/current.dart';

import '../../../sizeconfig.dart';

class schedules extends StatefulWidget {
  const schedules({Key? key}) : super(key: key);

  @override
  _schedulesState createState() => _schedulesState();
}

class _schedulesState extends State<schedules> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Scheduled Bookings",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: current()
        ));
  }
}
