import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/Home_Page/homepage.dart';
import 'package:home_service/sizeconfig.dart';

class current_card extends StatefulWidget {
  final String name;
  final String service;
  final String subservice;
  final String date;
  final String time;
  final String id;
  final String mobile;
  final String image;
  final String status;
  final String DocId;

  const current_card(
      {Key? key,
      required this.name,
      required this.service,
      required this.subservice,
      required this.date,
      required this.time,
      required this.id,
      required this.mobile,
      required this.image,
      required this.status,
      required this.DocId})
      : super(key: key);

  @override
  _current_cardState createState() => _current_cardState();
}

class _current_cardState extends State<current_card> {
  bool saved = false;

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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.height! * 13,
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 0.2, color: Colors.lightBlue.shade900))),
        padding: EdgeInsets.only(bottom: SizeConfig.height! * 1),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.status,
                        style: GoogleFonts.poppins(
                            color: widget.status == "Cancelled"
                                ? Colors.red
                                : widget.status == "Accepted"
                                ? Colors.green
                                : Colors.yellow.shade700,
                            fontSize: SizeConfig.height! * 1.8,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: SizeConfig.width! * 1,
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: SizeConfig.height! * 2,
                                fontWeight: FontWeight.w900),
                          )),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.subservice,
                            style: TextStyle(
                                fontSize: SizeConfig.height! * 1.8,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.date,
                              style: TextStyle(
                                  fontSize: SizeConfig.height! * 1.8,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.time,
                              style: TextStyle(
                                  fontSize: SizeConfig.height! * 1.8,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: InkWell(
                          onTap: () {
                            FlutterPhoneDirectCaller.callNumber(widget.mobile);
                          },
                          child: Icon(
                            Icons.call,
                            color: Colors.green,
                            size: SizeConfig.height! * 3.5,
                          )),
                    )),
                    Expanded(
                        child: Container(
                      child: InkWell(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection("userdetails")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("orders")
                                .doc('history')
                                .collection('orders')
                                .doc(widget.DocId)
                                .set({
                                  "Date": widget.date,
                                  "ID": widget.id,
                                  "Image": widget.image,
                                  "Mobile": widget.mobile,
                                  "Name": widget.name,
                                  "Service": widget.service,
                                  "SubService": widget.subservice,
                                  "Time": widget.time,
                                  "status": "Cancelled",
                                  "DocId": widget.DocId,
                                })
                                .whenComplete(() async {
                                  await FirebaseFirestore.instance
                                      .collection("userdetails")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("orders")
                                      .doc("current")
                                      .collection("orders")
                                      .doc(widget.DocId)
                                      .delete();
                                })
                                .whenComplete(() async {
                                  await FirebaseFirestore.instance
                                      .collection("Service Providers")
                                      .doc(widget.id)
                                      .collection("orders")
                                      .doc("Requested")
                                      .collection("orders")
                                      .doc(widget.DocId)
                                      .delete();
                                })
                                .whenComplete(
                                    () => _alertBox("Order Cancelled"))
                                .whenComplete(() => Navigator.of(context).pop());
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: SizeConfig.height! * 3.5,
                          )),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
