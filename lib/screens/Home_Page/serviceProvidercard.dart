import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:home_service/screens/Home_Page/booking.dart';
import 'package:home_service/screens/Home_Page/seviceProviderFullDetail.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:table_calendar/table_calendar.dart';

class ServiceProvidersCard extends StatefulWidget {

  final String uid;
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

  const ServiceProvidersCard(
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
      required this.location, required this.uid})
      : super(key: key);

  @override
  _ServiceProvidersCardState createState() => _ServiceProvidersCardState();
}

class _ServiceProvidersCardState extends State<ServiceProvidersCard> {

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
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FullDetails(
                    name: widget.name,
                    image: widget.image,
                    mobile: widget.mobile,
                    service: widget.service,
                    status: widget.status,
                    experience: widget.experience,
                    description: widget.description,
                    mail: widget.mail,
                    qualification: widget.qualification,
                    subService: widget.subService,
                    location: widget.location, uid: widget.uid,
                  )),
        );
      },
      child: Container(
        color: Colors.grey[100],
        height: SizeConfig.height! * 12,
        width: SizeConfig.width! * 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
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
                            fontSize: SizeConfig.height! * 1.2,
                            fontWeight: FontWeight.bold,
                            color: widget.status == "Open"
                                ? Colors.green
                                : Colors.red,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.name,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: SizeConfig.height! * 2.7,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.mail,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: SizeConfig.height! * 1.5,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.mobile,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontSize: SizeConfig.height! * 1.5,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: Icon(Icons.phone,color: Colors.blue,size: SizeConfig.height! * 3.6,),
                        onPressed: () async {
                          FlutterPhoneDirectCaller.callNumber(widget.mobile);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        widget.status == "Open"? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => booking(service: widget.service,subservice: widget.subService, mobile: widget.mobile, name: widget.name, id: widget.uid,image: widget.image,))):
                        _alertDialogBox("Service Not Available,Try Again Later");
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: SizeConfig.height! * 3.5,
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
