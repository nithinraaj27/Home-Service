import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:home_service/screens/Home_Page/seviceProviderFullDetail.dart';
import 'package:home_service/sizeconfig.dart';

class ServiceProvidersCard extends StatefulWidget {
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
      required this.location})
      : super(key: key);

  @override
  _ServiceProvidersCardState createState() => _ServiceProvidersCardState();
}

class _ServiceProvidersCardState extends State<ServiceProvidersCard> {
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
                    location: widget.location,
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
                  onPressed: () {},
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
