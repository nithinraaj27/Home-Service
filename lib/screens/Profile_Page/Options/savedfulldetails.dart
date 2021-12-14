

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../sizeconfig.dart';

class savedFullDetails extends StatefulWidget {
  final String name;
  final String image;
  final String mobile;
  final String service;
  final String status;
  final String experience;
  final String description;
  final String mail;
  final String qualification;
  final String subService;
  final String location;
  final String uid;

  const savedFullDetails(
      {Key? key,
      required this.name,
      required this.image,
      required this.mobile,
      required this.service,
      required this.status,
      required this.experience,
      required this.description,
      required this.mail,
      required this.qualification,
      required this.subService,
      required this.location,
      required this.uid})
      : super(key: key);

  @override
  _savedFullDetailsState createState() => _savedFullDetailsState();
}

class _savedFullDetailsState extends State<savedFullDetails> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    bool saved = true;

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
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.1,
          title: Text(
            "Its " + widget.name + "..!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: SizeConfig.height! * 2.7),
          ),
          actions: [
            GestureDetector(
                onTap: () async {
                  setState(() {
                    if (saved) {
                      saved = false;
                    } else {
                      saved = true;
                    }
                  });
                  saved
                      ? null :
                      await FirebaseFirestore.instance
                      .collection("userdetails")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("Saved")
                      .doc(widget.uid)
                      .delete().whenComplete(() => _alertBox("Removed from Saved")).whenComplete(() => Navigator.of(context).pop());
                },
                child: Icon(
                  saved
                      ? Icons.bookmark_outlined
                      : Icons.bookmark_border_outlined,
                  size: SizeConfig.height! * 3.5,
                )),
            SizedBox(
              width: SizeConfig.width! * 2,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.height! * 6),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width! * 4.5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: widget.status == 'Open'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              border: Border.all(
                                  width: 2,
                                  color: widget.status == 'Open'
                                      ? Colors.green
                                      : Colors.red)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.height! * 1.5,
                              ),
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  radius: SizeConfig.height! * 10,
                                  child: Image.network(
                                    widget.image,
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.height! * 2),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Has " +
                                            widget.experience +
                                            " of Experience in " +
                                            widget.service.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                            fontSize:
                                            SizeConfig.height! * 1.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.height! * 1,
                                    ),
                                    Container(
                                      child: Text(
                                        "Email : " + widget.mail,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                            fontSize:
                                            SizeConfig.height! * 1.4,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.height! * 2,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width! * 4.5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: widget.status == 'Open'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                              border: Border.all(
                                  width: 2,
                                  color: widget.status == 'Open'
                                      ? Colors.green
                                      : Colors.red)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                widget.description,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                  fontSize: SizeConfig.height! * 1.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: SizeConfig.height! * 3,
            ),
            Expanded(
                child: Column(
                  children: [
                    Text(
                      "📍 "
                          "Location : " +
                          widget.location,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: SizeConfig.height! * 1.7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.height! * 1.5,
                    ),
                    Text(
                      "⚒ " "subService : " + widget.subService,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: SizeConfig.height! * 1.7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FlutterPhoneDirectCaller.callNumber(widget.mobile);
          },
          child: Icon(Icons.local_phone_outlined),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
