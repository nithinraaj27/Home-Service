import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../main.dart';

class booking extends StatefulWidget {
  final String name;
  final String mobile;
  final String id;
  final String service;
  final String subservice;
  final String image;

  const booking(
      {Key? key,
        required this.service,
        required this.subservice,
        required this.name,
        required this.mobile,
        required this.id,
        required this.image})
      : super(key: key);
  @override
  _bookingState createState() => _bookingState();
}

class _bookingState extends State<booking> {

  String ss = "";
  String time = "";
  late DateTime selectedDay = DateTime.now();
  late DateTime focusedDay = DateTime.now();

  String userName = "";
  String userMobile = "";
  String userMail = "";
  String location = "";

  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    Future<void> fetch_details() async {
      await FirebaseFirestore.instance
          .collection("userdetails")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element['Uid'] == FirebaseAuth.instance.currentUser!.uid) {
            setState(() {
              userName = element['Name'];
              userMobile = element['Mobile'];
              userMail = element['E-mail'];
              location = element['location'];
            });
          }
        });
      });
    }

    Future<void> addtoservice(DateTime date, String tym, String service,
        String subservice, String name, String mobile, String id, String image) async {
      String s = DateTime.now().toString();
      ss = s;
      await FirebaseFirestore.instance
          .collection("userdetails")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc("current")
          .collection("orders")
          .doc(ss)
          .set({
        "ID": id,
        "Name": name,
        "Mobile": mobile,
        "Service": service,
        "Sub-Service": subservice,
        "Date": DateFormat("yyyy-MM-dd").format(date),
        "Time": tym,
        "Image": image,
        "DocId": ss,
        "status" : "Requested",
      });
    }

    Future<void> addtoserviceprovider(
        DateTime date,
        String tym,
        String service,
        String subservice,
        String name,
        String mobile,
        String id,
        String mail,
        String loc,
        String image
        ) async {
      await FirebaseFirestore.instance
          .collection("Service Providers")
          .doc(id)
          .collection("orders")
          .doc("Requested")
          .collection("orders")
          .doc(ss)
          .set({
        "ID": FirebaseAuth.instance.currentUser!.uid,
        "Name": name,
        "Mobile": mobile,
        "Email": mail,
        "Date": DateFormat("yyyy-MM-dd").format(date),
        "Time": tym,
        "location": loc,
        "DocId": ss,
        "status" : "Requested",
        "Service": service,
        "SubService": subservice,
        "Image" : image,
      });


    }

    Future<void> _alertDialogBox(DateTime date, String tym) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text(
                  "You have booked " +
                      widget.service +
                      " service on " +
                      DateFormat('yyyy-MM-dd').format(date) +
                      " at " +
                      tym,
                  style: TextStyle(
                      color: Colors.black54, fontSize: SizeConfig.height! * 2),
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      addtoservice(
                          selectedDay,
                          time,
                          widget.service,
                          widget.subservice,
                          widget.name,
                          widget.mobile,
                          widget.id,
                          widget.image
                      )
                          .whenComplete(() => fetch_details().whenComplete(() =>
                          addtoserviceprovider(
                            date,
                            tym,
                            widget.service,
                            widget.subservice,
                            userName,
                            userMobile,
                            widget.id,
                            userMail,
                            location,
                            widget.image,
                          )));
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> helpertwo()));
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            );
          });
    }

    Future<void> _alertBox(String error) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                child: Text(
                  error,
                  style: TextStyle(
                      color: Colors.black54, fontSize: SizeConfig.height! * 2),
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            );
          });
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  size: SizeConfig.height! * 4,
                  color: Colors.black,
                )),
            title: Text(
              "Choose Date and Time",
              style: TextStyle(
                  fontSize: SizeConfig.height! * 2.5, color: Colors.black),
            ),
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Expanded(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: SizeConfig.width! * 2),
                      child: TableCalendar(
                        focusedDay: selectedDay,
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2050),
                        calendarFormat: format,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        onFormatChanged: (CalendarFormat _format) {
                          setState(() {
                            format = _format;
                          });
                        },
                        onDaySelected: (DateTime selectDay, DateTime focusday) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusday;
                          });
                        },
                        calendarStyle: CalendarStyle(
                            isTodayHighlighted: true,
                            selectedDecoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            todayDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            )),
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        },
                        headerStyle: HeaderStyle(
                            titleCentered: true,
                            titleTextStyle: TextStyle(fontSize: SizeConfig.height! * 2),
                            formatButtonVisible: true,
                            formatButtonDecoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            headerPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width! * 5,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Time",
                          style: GoogleFonts.poppins(
                              color: Colors.blue,
                              letterSpacing: 2,
                              fontSize: SizeConfig.height! * 3,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: time == "08:00 AM"
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            time = "08:00 AM";
                                          });
                                        },
                                        child: Text(
                                          "08:00 AM",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              SizeConfig.height! * 2,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: time == "10:00 AM"
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            time = "10:00 AM";
                                          });
                                        },
                                        child: Text(
                                          "10:00 AM",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              SizeConfig.height! * 2,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: time == "12:00 PM"
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            time = "12:00 PM";
                                          });
                                        },
                                        child: Text(
                                          "12:00 PM",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              SizeConfig.height! * 2,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: time == "02:00 PM"
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            time = "02:00 PM";
                                          });
                                        },
                                        child: Text(
                                          "02:00 PM",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              SizeConfig.height! * 2,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: time == "04:00 PM"
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            time = "04:00 PM";
                                          });
                                        },
                                        child: Text(
                                          "04:00 PM",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              SizeConfig.height! * 2,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: time == "06:00 PM"
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            time = "06:00 PM";
                                          });
                                        },
                                        child: Text(
                                          "06:00 PM",
                                          style: GoogleFonts.poppins(
                                              fontSize:
                                              SizeConfig.height! * 2,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.height! * 2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            time == "" ? _alertBox("Please Select the Time Slot") : _alertDialogBox(selectedDay, time);
                          },
                          child: Container(
                            margin: EdgeInsets.all(30),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Book",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}