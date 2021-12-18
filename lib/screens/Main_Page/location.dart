import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/service/user_details.dart';
import 'package:home_service/sizeconfig.dart';

import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';

class location_page extends StatefulWidget {
  final String? phone;
  const location_page({Key? key, this.phone}) : super(key: key);

  @override
  _location_pageState createState() => _location_pageState();
}

class _location_pageState extends State<location_page> {
  bool _autovalidate = false;
  String location = "";
  String Address = "";

  Future<void> set_data() async {
    await FirebaseFirestore.instance
        .collection("userdetails")
        .doc(widget.phone)
        .set({
      "location": Provider.of<user_details>(context, listen: false).Mobile_Loc,
    }).whenComplete(() => print("added"));
  }

  Future<void> getCurrentLocation() async {
    final PermissionStatus permission = await _getLocationPermission();
    print("p " + permission.toString());

    try {
      if (permission == PermissionStatus.granted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        );

        print("posi " + position.toString());

        var lat = position.latitude;
        var long = position.longitude;

        List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
            position.latitude, position.longitude);

        var place = placemarks[0];

        Address =
            ' ${place.locality}, ${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.country},${place.postalCode}';

        print("Function " + Address!);
        Provider.of<user_details>(context, listen: false).set_mob_loc(Address!);
        setState(() {
          location = Address!;
        });
      } else {}
    } catch (err) {
      _alertDialogBox(err.toString() + "\nKindly Turn on location");
    }
  }

  Future<PermissionStatus> _getLocationPermission() async {
    final PermissionStatus permission = await LocationPermissions()
        .checkPermissionStatus(level: LocationPermissionLevel.location);
    if (permission != PermissionStatus.granted) {
      final PermissionStatus permissionStatus = await LocationPermissions()
          .requestPermissions(
              permissionLevel: LocationPermissionLevel.location);
      print("Permission" + permissionStatus.toString());
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            content: Container(
              child: Text(
                error,
                style: TextStyle(
                    color: Colors.black, fontSize: SizeConfig.height! * 2),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close Dialog",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff23ADE8),
        title: Text(
          "Location",
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: FadeAnimation(
                    1.1,
                    GestureDetector(
                      onTap: () {
                        getCurrentLocation();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.height! * 1.5,
                            horizontal: SizeConfig.width! * 5),
                        height: SizeConfig.height! * 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff23ADE8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_searching,
                              color: Colors.white,
                              size: SizeConfig.height! * 3,
                            ),
                            Text(
                              "   Current Location",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: FadeAnimation(
                  1.1,
                  Container(
                    alignment: Alignment.center,
                    child: Text("Or"),
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: FadeAnimation(
                      1.1,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 6),
                        height: SizeConfig.height! * 4,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                location = val;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty && value == "") {
                                return "Location should not be left empty";
                              }
                              return null;
                            },
                            autovalidate: _autovalidate,
                            decoration: InputDecoration(
                                hintText:
                                    context.watch<user_details>().Mobile_Loc,
                                errorMaxLines: 1,
                                prefixIcon: Icon(
                                  Icons.gps_fixed,
                                  size: SizeConfig.height! * 3,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2.3,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                border: InputBorder.none),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    )),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<user_details>(context, listen: false)
                                  .Mobile_Loc ==
                              "Location"
                          ? _alertDialogBox("Location should not be left empty")
                          : set_data();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff23ADE8),
                      ),
                      child: Text(
                        "Continue",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
