import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:home_service/screens/Home_Page/booking.dart';
import 'package:home_service/screens/Home_Page/seviceProviderFullDetail.dart';
import 'package:home_service/screens/Profile_Page/Options/savedfulldetails.dart';
import 'package:home_service/sizeconfig.dart';

class savedCard extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  final String mail;
  final String mobile;
  final String qualification;
  final String subservice;
  final String uid;
  final String experience;
  final String location;
  final String service;
  final String status;

  const savedCard(
      {Key? key,
      required this.name,
      required this.desc,
      required this.image,
      required this.mail,
      required this.mobile,
      required this.qualification,
      required this.subservice,
      required this.uid,
      required this.experience,
      required this.location,
      required this.service,
      required this.status})
      : super(key: key);

  @override
  _savedCardState createState() => _savedCardState();
}

class _savedCardState extends State<savedCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _alertDialogBox(String error) async {
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

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => savedFullDetails(
                      name: widget.name,
                      mail: widget.mail,
                      description: widget.desc,
                      service: widget.service,
                      qualification: widget.qualification,
                      location: widget.location,
                      experience: widget.experience,
                      image: widget.image,
                      mobile: widget.mobile,
                      status: widget.status,
                      uid: widget.uid,
                      subService: widget.subservice,
                    )));
      },
      child: Container(
        color: Colors.grey[100],
        height: SizeConfig.height! * 12,
        width: SizeConfig.width! * 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.image,
                    ),
                    radius: 30.0,
                  ),
                  Text(
                    widget.status,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: SizeConfig.height! * 1.7,
                          fontWeight: FontWeight.bold,
                          color: widget.status == "Open"
                              ? Colors.green
                              : Colors.red,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: SizeConfig.height! * 2.7,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.mail,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: SizeConfig.height! * 1.5,
                      ),
                ),
                Text(
                  widget.mobile,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: SizeConfig.height! * 1.5,
                      ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.phone_outlined),
                  onPressed: () async {
                    FlutterPhoneDirectCaller.callNumber(widget.mobile);
                  },
                ),
                TextButton(
                  onPressed: () {
                    widget.status == "Open"
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => booking(
                                      service: widget.service,
                                      subservice: widget.subservice,
                                      mobile: widget.mobile,
                                      name: widget.name,
                                      id: widget.uid,
                                      image: widget.image,
                                    )))
                        : _alertDialogBox(
                            "Service Not Available,Try Again Later");
                  },
                  child: Text(
                    "Add + ",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: SizeConfig.height! * 1.7,
                        color: Colors.lightBlue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
